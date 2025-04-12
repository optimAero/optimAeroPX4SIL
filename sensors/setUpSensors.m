% This script holds the parameters for the GPS, accelerometer, gyro, and barometer sensors. 
% GPS data used in the simulation
parameters.gps.vertPositionAccuracy_m = 40;
parameters.gps.horzPositionAccuracy_m = 30;
parameters.gps.vertPositionAccuracy_m = 0;
parameters.gps.velocityAccuracy_mps = 0.05;
parameters.gps.decayFactor_nd = 0.999; % 0 -> white noise, 1 -> random walk

% specific accel and gyro not known, so use parameters from a representative
% device "ICM-42688-P"
parameters.accel.naturalFrequency_radps = 190;
parameters.accel.dampingRatio_nd = 0.707;
parameters.accel.scaleFactCrossCoupling_nd = [1 0 0; 0 1 0; 0 0 1;];
parameters.accel.measurementBias_mps2 = [0 0 0];
parameters.accel.lowerUpperLimits_mps2 = [-10000 -10000 -10000 10000 10000 10000];
parameters.accel.noisePower_mps2 = [0.0000001 0.0000001 0.0000001];
parameters.gyro.naturalFrequency_radps = 190;
parameters.gyro.dampingRatio_nd = 0.707;
parameters.gyro.scaleFactCrossCoupling_nd = [1 0 0; 0 1 0; 0 0 1;];
parameters.gyro.measurementBias_radps = [0 0 0];
parameters.gyro.gSensitiveBias_radps = [0 0 0];
parameters.gyro.lowerUpperLimits_radps = [-10000 -10000 -10000 10000 10000 10000];
parameters.gyro.noisePower_radps = [0.0000001 0.0000001 0.0000001];
parameters.mag.noisePower_gauss = [0.000001 0.000001 0.000001];
parameters.baro.noisePower_Pa = [0.001];
parameters.thermo.noisePower_degC = [0.001];