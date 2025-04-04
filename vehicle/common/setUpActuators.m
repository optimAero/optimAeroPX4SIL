actuatorDelay_s = 0.005;
plantSampleTime_s = 0.01;
parameters.engine.minThrottle = 0.01; %idle happens above this value


switch lower(vehicleParams.type)
    case "f-16"
        % TODO: Should things in vehicle\F16\data\aeroDataF16.m be listed here?
    case "hexarotor"
        vehicleParams.rotor.maxRPM         = 2000; %Temporary value
        vehicleParams.rotor.kct_Npm4radps2 =  1.02218439320555e-09;
        vehicleParams.rotor.kcp_Wpm5radps3 = 1.61778363723605e-12;
        vehicleParams.rotor.cmdDelay_s = 0.1; 
        vehicleParams.rotor.motorLocs = [ 1.0000    0.0000;
                                    0.5000    0.8660;
                                   -0.5000    0.8660;
                                   -1.0000    0.0000;
                                   -0.5000   -0.8660;
                                    0.5000   -0.8660];
    otherwise
        error(char(["unknown vehicle: " vehicleType]))
end