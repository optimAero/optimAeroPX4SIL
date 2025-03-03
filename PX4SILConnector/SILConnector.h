/*  File    : SILConnector.h
 *  Abstract:
 *
 *  A C++ header file defining the Sensor and SILConnector classes.
 *
 *  Copyright (c) 2023 Kiril Boychev
 */
#ifndef _SILConnector_h
#define _SILConnector_h

#include <asio.hpp>
#include "mavlink/common/mavlink.h"

struct SensorIMU{
    float xacc;
    float yacc;
    float zacc;
    float xgyro;
    float ygyro;
    float zgyro;
    float xmag;
    float ymag;
    float zmag;
};

struct SensorAirData{
    float abs_pressure;
    float diff_pressure;
    float temperature;
};

struct SensorGPS{
    uint8_t fix_type;
    int32_t lat;
    int32_t lon;
    int32_t alt;
    uint16_t eph;
    uint16_t epv;
    uint16_t vel;
    int16_t vn;
    int16_t ve;
    int16_t vd;
    uint16_t cog;
    uint8_t satellites_visible;
};

struct SensorAltimeter{
    uint16_t current_distance;
};

struct Inputs{
    std::array<uint16_t,12> channels;
    uint8_t rssi;
};

struct GroundTruth{
    float phi;
    float theta;
    float psi;
    float rollspeed;
    float pitchspeed;
    float yawspeed;
    int32_t lat;
    int32_t lon;
    int32_t alt;
    int16_t vx;
    int16_t vy;
    int16_t vz;
    uint16_t ind_airspeed;
    uint16_t true_airspeed;
    int16_t xacc;
    int16_t yacc;
    int16_t zacc;
};

class SILConnector{

    private:
        asio::io_service m_io_service;
        asio::ip::tcp::socket m_tcp_socket;
        asio::ip::tcp::acceptor m_acceptor;
        uint8_t m_tcp_buffer[1024];
        std::string m_source_address;
        unsigned int m_source_port;
        std::array<float,16> m_hil_actuator_controls;
        std::array<uint8_t,1> m_hil_actuator_mode;
        std::chrono::time_point<std::chrono::steady_clock> m_last_heartbeat_time;
        std::chrono::time_point<std::chrono::steady_clock> m_last_hil_gps_time;
        std::chrono::time_point<std::chrono::steady_clock> m_last_distance_sensor_time;

    public:
        SILConnector(const std::string &source_address,const unsigned int & source_port)
            :m_io_service(),
            m_tcp_socket(m_io_service),
            m_source_address(source_address),
            m_source_port(source_port),
            m_acceptor(m_io_service,asio::ip::tcp::endpoint(asio::ip::address::from_string("0.0.0.0"), 4560)){
        }

        void open(){
            
            m_acceptor.accept(m_tcp_socket);

            m_last_heartbeat_time = std::chrono::steady_clock::now();
            m_last_hil_gps_time = std::chrono::steady_clock::now(); 
            m_last_distance_sensor_time = std::chrono::steady_clock::now(); 

        }

        void close(){

            if(m_tcp_socket.is_open()){
                m_tcp_socket.close();
            }

        }

        void read_tcp_socket(){
            
            auto bytes_available = m_tcp_socket.available();
            
            if(bytes_available){
                
                auto bytes_received = m_tcp_socket.receive(asio::buffer(m_tcp_buffer,bytes_available));
                
                if(bytes_received){
                   
                    mavlink_message_t encoded_msg;
                    mavlink_status_t status;
                    
                    for (auto i = 0; i < bytes_received; i++)
                    {
                        if (mavlink_parse_char(MAVLINK_COMM_0, m_tcp_buffer[i], &encoded_msg, &status))
                        {
                            if (encoded_msg.msgid == MAVLINK_MSG_ID_HIL_ACTUATOR_CONTROLS)
                            {
                                mavlink_hil_actuator_controls_t hil_actuator_controls_msg;

                                mavlink_msg_hil_actuator_controls_decode(&encoded_msg, &hil_actuator_controls_msg);

                                for(auto j=0;j<16;j++){
                                    m_hil_actuator_controls[j]=hil_actuator_controls_msg.controls[j];
                                }
                                m_hil_actuator_mode[0] = hil_actuator_controls_msg.mode;
                            }
                        }
                    }
                }
            }
        }

        const std::array<float,16>& get_hil_actuator_controls() const{
            return m_hil_actuator_controls;
        }
    
        const std::array<uint8_t,1>& get_hil_actuator_mode() const{
            return m_hil_actuator_mode;
        }

        void send_sensors(
            const uint64_t &time_usec,
            const SensorIMU &imu,
            const SensorAirData &air_data,
            const SensorGPS &gps,
            const SensorAltimeter &altimeter,
            const GroundTruth &ground_truth
            ){
                
                uint16_t bytes_to_send = 0;
                mavlink_message_t encoded_msg;

                auto now = std::chrono::steady_clock::now();
                
                auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now-m_last_heartbeat_time);
                
                if(elapsed.count()>1000){ //1Hz

                    mavlink_heartbeat_t heartbeat_msg;
                    heartbeat_msg.autopilot = (uint8_t)MAV_AUTOPILOT_GENERIC;
                    heartbeat_msg.type = (uint8_t)MAV_TYPE_GENERIC;
                    heartbeat_msg.system_status=(uint8_t)0;
                    heartbeat_msg.base_mode=(uint8_t)0;
                    heartbeat_msg.custom_mode=(uint32_t)0;

                    mavlink_msg_heartbeat_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &heartbeat_msg);

                    bytes_to_send = mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send],&encoded_msg);

                    m_last_heartbeat_time=now;
                }

                mavlink_hil_sensor_t hil_sensor_msg;
                hil_sensor_msg.time_usec = time_usec;
                hil_sensor_msg.xacc = imu.xacc;
                hil_sensor_msg.yacc = imu.yacc;
                hil_sensor_msg.zacc = imu.zacc;
                hil_sensor_msg.xgyro = imu.xgyro;
                hil_sensor_msg.ygyro = imu.ygyro;
                hil_sensor_msg.zgyro = imu.zgyro;
                hil_sensor_msg.xmag = imu.xmag;
                hil_sensor_msg.ymag = imu.ymag;
                hil_sensor_msg.zmag = imu.zmag;
                hil_sensor_msg.abs_pressure = air_data.abs_pressure;
                hil_sensor_msg.diff_pressure = air_data.diff_pressure;
                hil_sensor_msg.temperature = air_data.temperature;
                hil_sensor_msg.fields_updated = (uint32_t)0x1FFF;
                hil_sensor_msg.id = (uint8_t)0;

                mavlink_msg_hil_sensor_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &hil_sensor_msg);

                bytes_to_send += mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send],&encoded_msg);

                now = std::chrono::steady_clock::now();
                
                elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now-m_last_hil_gps_time);
                
                if(elapsed.count()>200){ //5Hz

                    mavlink_hil_gps_t hil_gps_msg;
                    hil_gps_msg.time_usec = time_usec;
                    hil_gps_msg.fix_type = gps.fix_type;
                    hil_gps_msg.lat = gps.lat;
                    hil_gps_msg.lon = gps.lon;
                    hil_gps_msg.alt = gps.alt;
                    hil_gps_msg.eph = gps.eph;
                    hil_gps_msg.epv = gps.epv;
                    hil_gps_msg.vel = gps.vel;
                    hil_gps_msg.vn = gps.vn;
                    hil_gps_msg.ve = gps.ve;
                    hil_gps_msg.vd = gps.vd;
                    hil_gps_msg.cog = gps.cog;
                    hil_gps_msg.satellites_visible = gps.satellites_visible;
                    hil_gps_msg.id = (uint8_t)0;
                    hil_gps_msg.yaw = (uint16_t)0;

                    mavlink_msg_hil_gps_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &hil_gps_msg);

                    bytes_to_send += mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send],&encoded_msg);
                    
                    m_last_hil_gps_time = now;

                }

                now = std::chrono::steady_clock::now();
                
                elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(now-m_last_distance_sensor_time);

                if(elapsed.count()>10){ //50Hz

                    uint16_t min_distance = 2;
                    uint16_t max_distance = 5000;
                    double low_signal_strength=1.5811;
                    double high_signal_strength=70.7284;
                    uint8_t signal_quality;
                    uint16_t current_distance = altimeter.current_distance;

                    if(current_distance <= min_distance){
                        current_distance = min_distance;
                        signal_quality = 100;
                    }else if (current_distance >= max_distance || std::isinf((double)current_distance)){
                        current_distance = (uint16_t)0;
                        signal_quality = 0;
                    }else{
                        double signal_strength = std::sqrt(current_distance);
                        signal_quality = (uint8_t)((high_signal_strength - signal_strength) / (high_signal_strength - low_signal_strength)*100);
                    }

                    mavlink_distance_sensor_t distance_sensor_msg;
                    distance_sensor_msg.time_boot_ms=(uint32_t)(time_usec /(1e3));
                    distance_sensor_msg.min_distance=(uint16_t)min_distance;
                    distance_sensor_msg.max_distance=(uint16_t)max_distance;
                    distance_sensor_msg.current_distance=(uint16_t)current_distance;
                    distance_sensor_msg.type=(uint8_t)MAV_DISTANCE_SENSOR_LASER;
                    distance_sensor_msg.id=(uint8_t)0;
                    distance_sensor_msg.orientation=(uint8_t)MAV_SENSOR_ROTATION_PITCH_270;
                    distance_sensor_msg.covariance=(uint8_t)UINT8_MAX;
                    distance_sensor_msg.horizontal_fov=(float)0.05236;
                    distance_sensor_msg.vertical_fov=(float)0.05236;
                    distance_sensor_msg.quaternion[0]=(float)1; 
                    distance_sensor_msg.quaternion[1]=(float)0; 
                    distance_sensor_msg.quaternion[2]=(float)0; 
                    distance_sensor_msg.quaternion[3]=(float)0; 
                    distance_sensor_msg.signal_quality=(uint8_t)signal_quality;

                    mavlink_msg_distance_sensor_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &distance_sensor_msg);

                    bytes_to_send += mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send], &encoded_msg);

                    m_last_distance_sensor_time = now;

                }
                
                // mavlink_hil_rc_inputs_raw_t hil_rc_inputs_raw;
                // 
                // hil_rc_inputs_raw.time_usec = time_usec;
                // hil_rc_inputs_raw.chan1_raw = inputs.channels[0];
                // hil_rc_inputs_raw.chan2_raw = inputs.channels[1];
                // hil_rc_inputs_raw.chan3_raw = inputs.channels[2];
                // hil_rc_inputs_raw.chan4_raw = inputs.channels[3];
                // hil_rc_inputs_raw.chan5_raw = inputs.channels[4];
                // hil_rc_inputs_raw.chan6_raw = inputs.channels[5];
                // hil_rc_inputs_raw.chan7_raw = inputs.channels[6];
                // hil_rc_inputs_raw.chan8_raw = inputs.channels[7];
                // hil_rc_inputs_raw.chan9_raw = inputs.channels[8];
                // hil_rc_inputs_raw.chan10_raw = inputs.channels[9];
                // hil_rc_inputs_raw.chan11_raw = inputs.channels[10];
                // hil_rc_inputs_raw.chan12_raw = inputs.channels[11];
                // hil_rc_inputs_raw.rssi = inputs.rssi;

                // mavlink_msg_hil_rc_inputs_raw_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &hil_rc_inputs_raw);

                // bytes_to_send += mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send], &encoded_msg);


                float phi = ground_truth.phi;
                float theta = ground_truth.theta;
                float psi = ground_truth.psi;

                float sphi = std::sin(phi / 2.0);
                float stheta = std::sin(theta / 2.0);
                float spsi = std::sin(psi / 2.0);
                float cphi = std::cos(phi / 2.0);
                float ctheta = std::cos(theta / 2.0);
                float cpsi = std::cos(psi / 2.0);

                float attitude_quaternion[4];
                attitude_quaternion[0] = cpsi * ctheta * cphi + spsi * stheta * sphi;
                attitude_quaternion[1] = cpsi * ctheta * sphi - spsi * stheta * cphi;
                attitude_quaternion[2] = cpsi * stheta * cphi + spsi * ctheta * sphi;
                attitude_quaternion[3] = spsi * ctheta * cphi - cpsi * stheta * sphi;

                mavlink_hil_state_quaternion_t hil_state_quaternion;
                hil_state_quaternion.attitude_quaternion[0] = attitude_quaternion[0];
                hil_state_quaternion.attitude_quaternion[1] = attitude_quaternion[1];
                hil_state_quaternion.attitude_quaternion[2] = attitude_quaternion[2];
                hil_state_quaternion.attitude_quaternion[3] = attitude_quaternion[3];
                hil_state_quaternion.rollspeed = ground_truth.rollspeed;
                hil_state_quaternion.pitchspeed = ground_truth.pitchspeed;
                hil_state_quaternion.yawspeed = ground_truth.yawspeed;
                hil_state_quaternion.lat = ground_truth.lat;
                hil_state_quaternion.lon = ground_truth.lon;
                hil_state_quaternion.alt = ground_truth.alt;
                hil_state_quaternion.vx = ground_truth.vx;
                hil_state_quaternion.vy = ground_truth.vy;
                hil_state_quaternion.vz = ground_truth.vz;
                hil_state_quaternion.ind_airspeed = ground_truth.ind_airspeed;
                hil_state_quaternion.true_airspeed = ground_truth.true_airspeed;
                hil_state_quaternion.xacc = ground_truth.xacc;
                hil_state_quaternion.yacc = ground_truth.yacc;
                hil_state_quaternion.zacc = ground_truth.zacc;

                mavlink_msg_hil_state_quaternion_encode_chan(1, 200, MAVLINK_COMM_0, &encoded_msg, &hil_state_quaternion);

                bytes_to_send += mavlink_msg_to_send_buffer(&m_tcp_buffer[bytes_to_send], &encoded_msg);

                m_tcp_socket.send(asio::buffer(m_tcp_buffer,bytes_to_send));
            }
};

#endif