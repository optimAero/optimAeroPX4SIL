% Winds aloft
xWindInNED_mps = 0;
yWindInNED_mps = 0;
zWindInNED_mps = 0;

% Gusts
gustEnabled = false;
gustStartTime_sec = 5;
gustDuration_sec = 5; % when to start decreasing the gust
gustLength_m = [120 100 80];
gustAmplitude_mps = [3.5 3.5 3.0];

% Turbulence
turbulenceEnabled = false;
turbulenceStartTime_sec = 5;
turbulenceEndTime_sec = 10;
turbulenceWingspan_m = 10;
turbulenceMinAirspeed_mps = 1;

airDensityAtStd_kgpm3 = 1.225;