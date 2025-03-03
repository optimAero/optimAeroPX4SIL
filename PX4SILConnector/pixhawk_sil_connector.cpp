/*  File    : pixhawk_sil_connector.cpp
 *  Abstract:
 *
 *  Simulink C++ S-function for software-in-the-loop (SIL) simulation with Pixhawk.
 *
 *  Copyright (c) 2023 Kiril Boychev
 */

#include <algorithm>
#include <iostream>
#include <iterator>
#include <sstream>
#include <string>

#include "SILConnector.h"

#define S_FUNCTION_LEVEL 2
#define S_FUNCTION_NAME pixhawk_sil_connector

/*
 * Need to include simstruc.h for the definition of the SimStruct and
 * its associated macro definitions.
 */
#include "simstruc.h"

/*====================*
 * S-function methods *
 *====================*/

/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *    The sizes information is used by Simulink to determine the S-function
 *    block's characteristics (number of inputs, outputs, states, etc.).
 */
static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, 0);

    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S))
    {
        return;
    }

    ssSetSimStateCompliance(S, DISALLOW_SIM_STATE);
    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 1);

    if (!ssSetNumInputPorts(S, 10))
    {
        return;
    }

    ssSetInputPortWidth(S, 0, 1); // time (s)
    ssSetInputPortDirectFeedThrough(S, 0, 1);
    ssSetInputPortWidth(S, 1, 3); // A_measured (m/s^2)
    ssSetInputPortDirectFeedThrough(S, 1, 1);
    ssSetInputPortWidth(S, 2, 3); // omega_b_measured (rad/s)
    ssSetInputPortDirectFeedThrough(S, 2, 1);
    ssSetInputPortWidth(S, 3, 3); // B_measured (gauss)
    ssSetInputPortDirectFeedThrough(S, 3, 1);
    ssSetInputPortWidth(S, 4, 1); // P_measured (hPa)
    ssSetInputPortDirectFeedThrough(S, 4, 1);
    ssSetInputPortWidth(S, 5, 1); // T_measured (degC)
    ssSetInputPortDirectFeedThrough(S, 5, 1);
    ssSetInputPortWidth(S, 6, 1); // h_measured (m)
    ssSetInputPortDirectFeedThrough(S, 6, 1);
    ssSetInputPortWidth(S, 7, 1); // q_measured (hPa)
    ssSetInputPortDirectFeedThrough(S, 7, 1);
    ssSetInputPortWidth(S, 8, 12); // xyz_measured (-)
    ssSetInputPortDirectFeedThrough(S, 8, 1);
    // ssSetInputPortWidth(S, 9, 13); // rc_channels (-)
    // ssSetInputPortDirectFeedThrough(S, 9, 1);
    ssSetInputPortWidth(S, 9, 17); // ground_truth (-)
    ssSetInputPortDirectFeedThrough(S, 9, 1);

    if (!ssSetNumOutputPorts(S, 2)) 
    {
        return;
    }

    ssSetOutputPortWidth(S, 0, 16);
    ssSetOutputPortWidth(S, 1, 1);

    // ssSetNumSampleTimes(S, 1);
    // ssSetNumPWork(S, 1);
    // ssSetNumRWork(S, 0);
    // ssSetNumIWork(S, 0);
    // ssSetNumModes(S, 0);
    // ssSetNumNonsampledZCs(S, 0);
    // ssSetOptions(S, 0);
    ssSetNumSampleTimes(S, 1);
    ssSetNumPWork(S, 1);
    ssSetNumDWork(S, 0);
    ssSetNumIWork(S, 0);
    ssSetNumRWork(S, 1); // previous time
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);
    ssSetOptions(S, 0);
}

/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    This function is used to specify the sample time(s) for your
 *    S-function. You must register the same number of sample times as
 *    specified in ssSetNumSampleTimes.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, 0.004);
    ssSetOffsetTime(S, 0, 0.0);
    ssSetModelReferenceSampleTimeDefaultInheritance(S);
}

#define MDL_START /* Change to #undef to remove function */
#if defined(MDL_START)
/* Function: mdlStart =======================================================
 * Abstract:
 *    This function is called once at start of model execution. If you
 *    have states that should be initialized once, this is the place
 *    to do it.
 */
static void mdlStart(SimStruct *S)
{
    static std::string eStatus;

    try
    {

        static SILConnector sil_connector("0.0.0.0",4560);

        mexPrintf("Waiting for PX4 to connect on TCP port 4560...\n");

        sil_connector.open();

        mexPrintf("PX4 connected on TCP port 4560.\n");

        ssSetPWorkValue(S,0,(void *)&sil_connector);

    }
    catch (const std::exception &e)
    {
        eStatus = std::string(e.what());
        ssSetErrorStatus(S, eStatus.c_str());
    }
}
#endif /*  MDL_START */

/* Function: mdlOutputs =======================================================
 * Abstract:
 *    In this function, you compute the outputs of your S-function
 *    block.
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{

    if (ssIsSampleHit(S, 0, tid)){

        static std::string eStatus;

        try
        {
            
            SILConnector *sil_connector = (SILConnector *)ssGetPWorkValue(S,0);
            
            InputRealPtrsType time = ssGetInputPortRealSignalPtrs(S, 0);
            InputRealPtrsType A_measured = ssGetInputPortRealSignalPtrs(S, 1);
            InputRealPtrsType omega_b_measured = ssGetInputPortRealSignalPtrs(S, 2);
            InputRealPtrsType B_measured = ssGetInputPortRealSignalPtrs(S, 3);
            InputRealPtrsType P_measured = ssGetInputPortRealSignalPtrs(S, 4);
            InputRealPtrsType T_measured = ssGetInputPortRealSignalPtrs(S, 5);
            InputRealPtrsType h_measured = ssGetInputPortRealSignalPtrs(S, 6);
            InputRealPtrsType q_measured = ssGetInputPortRealSignalPtrs(S, 7);
            InputRealPtrsType xyz_measured = ssGetInputPortRealSignalPtrs(S, 8);
            // InputRealPtrsType rc_channels = ssGetInputPortRealSignalPtrs(S, 9);
            InputRealPtrsType ground_truth = ssGetInputPortRealSignalPtrs(S, 9);

            uint64_t time_usec = (uint64_t)((*time[0]) * 1e6);

            SensorIMU imu;

            imu.xacc = (float)(*A_measured[0]);
            imu.yacc = (float)(*A_measured[1]);
            imu.zacc = (float)(*A_measured[2]);
            imu.xgyro = (float)(*omega_b_measured[0]);
            imu.ygyro = (float)(*omega_b_measured[1]);
            imu.zgyro = (float)(*omega_b_measured[2]);
            imu.xmag = (float)(*B_measured[0]);
            imu.ymag = (float)(*B_measured[1]);
            imu.zmag = (float)(*B_measured[2]);

            SensorAirData air_data;

            air_data.abs_pressure = (float)(*P_measured[0]);
            air_data.diff_pressure = (float)(*q_measured[0]);
            air_data.temperature = (float)(*T_measured[0]);

            SensorGPS gps;
            gps.fix_type = (uint8_t)(*xyz_measured[0]);
            gps.lat = (int32_t)(*xyz_measured[1]);
            gps.lon = (int32_t)(*xyz_measured[2]);
            gps.alt = (int32_t)(*xyz_measured[3]);
            gps.eph = (uint16_t)(*xyz_measured[4]);
            gps.epv = (uint16_t)(*xyz_measured[5]);
            gps.vel = (uint16_t)std::floor(*xyz_measured[6]);
            gps.vn = (int16_t)std::floor(*xyz_measured[7]);
            gps.ve = (int16_t)std::floor(*xyz_measured[8]);
            gps.vd = (int16_t)std::floor(*xyz_measured[9]);
            gps.cog = (uint16_t)(*xyz_measured[10]);
            gps.satellites_visible = (uint8_t)(*xyz_measured[11]);

            SensorAltimeter altimeter;

            altimeter.current_distance = (uint16_t)(*h_measured[0]);

            // Inputs inputs;
            // for(unsigned int i=0;i<12;i++){
            //     inputs.channels[i]=(uint16_t)(*rc_channels[i]);
            // }
            // inputs.rssi = (uint8_t)(*rc_channels[12]);

            GroundTruth gt;

            gt.phi=(float)(*ground_truth[0]);
            gt.theta=(float)(*ground_truth[1]);
            gt.psi=(float)(*ground_truth[2]);
            gt.rollspeed=(float)(*ground_truth[3]);
            gt.pitchspeed=(float)(*ground_truth[4]);
            gt.yawspeed=(float)(*ground_truth[5]);
            gt.lat = (int32_t)(*ground_truth[6]);
            gt.lon = (int32_t)(*ground_truth[7]);
            gt.alt = (int32_t)(*ground_truth[8]);
            gt.vx = (int16_t)(*ground_truth[9]);
            gt.vy = (int16_t)(*ground_truth[10]);
            gt.vz = (int16_t)(*ground_truth[11]);
            gt.ind_airspeed = (uint16_t)(*ground_truth[12]);
            gt.true_airspeed = (uint16_t)(*ground_truth[13]);
            gt.xacc = (int16_t)(*ground_truth[14]);
            gt.yacc = (int16_t)(*ground_truth[15]);
            gt.zacc = (int16_t)(*ground_truth[16]);

            // sil_connector->send_sensors(
            //                     time_usec,
            //                     imu,
            //                     air_data,
            //                     gps,
            //                     altimeter,
            //                     inputs,
            //                     gt
            //                     );
            sil_connector->send_sensors(
                time_usec,
                imu,
                air_data,
                gps,
                altimeter,
                gt
            );


            sil_connector->read_tcp_socket();

            auto hil_actuator_controls = sil_connector->get_hil_actuator_controls();
            auto hil_actuator_mode = sil_connector->get_hil_actuator_mode();

            real_T *pwm = ssGetOutputPortRealSignal(S, 0);
            real_T *mode = ssGetOutputPortRealSignal(S, 1);


            for (auto i = 0; i < 16; i++)
            {
                pwm[i] = (real_T)hil_actuator_controls[i];
            }
            mode[0] = (real_T)hil_actuator_mode[0];

        }
        catch (const std::exception &e)
        {
            eStatus = std::string(e.what());
            ssSetErrorStatus(S, eStatus.c_str());
        }
    }
}

/* Function: mdlTerminate =====================================================
 * Abstract:
 *    In this function, you should perform any actions that are necessary
 *    at the termination of a simulation.  For example, if memory was
 *    allocated in mdlStart, this is the place to free it.
 */
static void mdlTerminate(SimStruct *S)
{
    SILConnector *sil_connector = (SILConnector *)ssGetPWorkValue(S,0);
    if(sil_connector){
        mexPrintf("Closing SILConnector...\n");
        sil_connector->close();
    }
}
/*======================================================*
 * See sfuntmpl.doc for the optional S-function methods *
 *======================================================*/

/*=============================*
 * Required S-function trailer *
 *=============================*/

#ifdef MATLAB_MEX_FILE /* Is this file being compiled as a MEX-file? */
#include "simulink.c"  /* MEX-file interface mechanism */
#else
#include "cg_sfun.h" /* Code generation registration function */
#endif