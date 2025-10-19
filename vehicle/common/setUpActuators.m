% This script sets up the actuator parameters for the selected vehicle. This includes
% parameters that define the motors, control surfaces, engines, etc.
actuatorDelay_s = 0.005;
plantSampleTime_s = 0.01;
parameters.engine.minThrottle = 0.01; %idle happens above this value

switch lower(vehicleParams.type)
    case "f-16"
        % Max deflection of control surfaces
        maxAilDefl_deg = 20;
        maxRudderDefl_deg = 30;
        maxElevatorDefl_deg = 25;
        elevatorDeflRateLimit_degps = 60;
        aileronDeflRateLimit_degps = 80;
        rudderDeflRateLimit_degps = 120;
        tauElevator_s = 0.0495;
        tauAilerons_s = 0.0495;
        tauRudder_s = 0.0495;
        F16EngineData

    case "hexarotor"
        % Engine based on U15II KV100 T-Motor
        vehicleParams.rotor.diameter_m  = 1.016; % 40 inch rotor
        vehicleParams.rotor.maxRPM      = 3473;
        vehicleParams.rotor.cmdToRpmData = [0 vehicleParams.rotor.maxRPM];
        vehicleParams.rotor.cmdToRpmBkpts_nd = [0 1];
        vehicleParams.rotor.kct_nd =  0.002455798004676;
        vehicleParams.rotor.kcp_nd = 1.530217019534773e-04; 
        % Mimic PX4 spin direction and motor number for hexarotor
        % NOTE: +X-Axis is out of the nose, +Y is out of starboard side, +Z is toward ground
        vehicleParams.rotor.motorLocs = [ 0.0000    1.0000 0;
                                          0.0000   -1.0000 0;
                                          0.8660   -0.5000 0;
                                         -0.8660    0.5000 0;
                                          0.8660    0.5000 0;
                                         -0.8660   -0.5000 0];
        vehicleParams.rotor.spinDirectionCW_isTrue = [1 0 1 0 0 1]; 

        % Using a generic 2nd order transfer function for an ESC and brushless motor
        vehicleParams.actuator.tfNumerator = 250000;
        vehicleParams.actuator.tfDenominator = [1 700 250000];

    otherwise
        error(char(["unknown vehicle: " vehicleType]))
end