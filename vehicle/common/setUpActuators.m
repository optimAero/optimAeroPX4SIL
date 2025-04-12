actuatorDelay_s = 0.005;
plantSampleTime_s = 0.01;
parameters.engine.minThrottle = 0.01; %idle happens above this value


switch lower(vehicleParams.type)
    case "f-16"
        % TODO: Should things in vehicle\F16\data\aeroDataF16.m be listed here?
    case "hexarotor"
        % Engine based on U15II KV100 T-Motor
        vehicleParams.rotor.diameter_m  = 1.016; % 40 inch rotor
        vehicleParams.rotor.maxRPM      = 3473; %Temporary value
        vehicleParams.rotor.cmdToRpmData = [0 vehicleParams.rotor.maxRPM];
        vehicleParams.rotor.cmdToRpmBkpts_nd = [0 1];
        vehicleParams.rotor.kct_nd =  1.02218439320555e-09;
        vehicleParams.rotor.kcp_nd = 1.61778363723605e-12;
        % Mimic PX4 spin direction and motor number for hexarotor
        % NOTE: +X-Axis is out of the nose, +Y is out of starboard side, +Z is toward ground
        vehicleParams.rotor.motorLocs = [ 0.0000    1.0000 0;
                                          0.0000   -1.0000 0;
                                          0.8660   -0.5000 0;
                                         -0.8660    0.5000 0;
                                          0.8660    0.5000 0;
                                         -0.8660   -0.5000 0];
        vehicleParams.rotor.spinDirectionCW_isTrue = [1 0 1 0 1 0]; 

        % Using a generic 2nd order transfer function for an ESC and brushless motor
        vehicleParams.actuator.tfNumerator = 250000;
        vehicleParams.actuator.tfDenominator = [1 700 250000];

    otherwise
        error(char(["unknown vehicle: " vehicleType]))
end