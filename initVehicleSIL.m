% initVehicleSIL: This function checks to make sure the matlab environment is set up properly. This file checks if the 
% user has the required toolboxes, support packages, and loads variable and bus definitions that are used in the
% F-16.slx model.
% ======================================================================================================================
%                                                       INPUTS
% ======================================================================================================================
% opts.launchFullSIL:            Flag used to launch the full SIL, should not be used on first attempt of using SIL
% opts.visualizationType:        The method that will be used to visualize the aircraft while SIL is running
% opts.launchQGroundControl:     This is a flag telling the function that QGC is not already launched
% opts.simHostIP:                 IP Address of users computer
% opts.vehicleType:              The plant model that will be used during the SIL simulation (currently can only be F-16)
% opts.controllerType:           The flight controller used in the SIL simulation (currently can only be PX4)
%
% ======================================================================================================================
%                                                    EXAMPLE USAGE
% ======================================================================================================================
% initVehicleSIL("launchFullSIL", true, "visualizationType","FlightGear","simHostIP","10.0.0.200"): Launch full SIL sim and visualize vehicle using FlightGear and set IP
% address for PX4 connection.
% initVehicleSIL("launchFullSIL",false,):             Run the intialization file only, this should be used before changing any models
function initVehicleSIL(opts)

    arguments
        opts.launchFullSIL        (1,1) logical = false        % input true if running the full SIL is desired
        opts.vehicleType          (1,1) string  = "F-16"       % Currently F-16 is the only vehicle config
        opts.visualizationType    (1,1) string  = "Matlab"     % Options "PassThrough", "FlightGear", or "Matlab"
        opts.launchQGroundControl (1,1) logical = false        % If QGC is already launched set this to false (TODO: currently non-functional)
        opts.simHostIP            (1,1) string  = "10.0.0.243" % Replace with your IP address
        opts.controllerType       (1,1) string  = "PX4"        % Currently PX4 is the only controller that can be used
        opts.PX4RepoPath          (1,1) string  = "PX4-Autopilot" % This is the path to the PX4 repo
    end
% Note: In future versions these will be arguments 
vehicleParams.type                  = opts.vehicleType; 
vehicleParams.controllerType        = opts.controllerType; 
visualizationType                   = opts.visualizationType;
controllerType                      = opts.controllerType;
vehicleType                         = opts.vehicleType;

% check for required toolboxes, support packages, and MATLAB version
% list is here: (https://www.mathworks.com/matlabcentral/answers/377731-how-do-features-from-license-correspond-to-names-from-ver#answer_300675)
requiredTools ={'Aerospace_Blockset'
                'Aerospace_Toolbox'
                'Control_Toolbox'
                'MATLAB_Coder'
                'Real-Time_Workshop' %Simulink Coder
                'RTW_Embedded_Coder' %Embedded Coder
                'SIMULINK' 
                'Simulink_Test'
                'UAV_Toolbox'};              

requiredSupportPackages = {};
requiredSupportPackages(1).Name = {'UAV Toolbox Support Package for PX4 Autopilots'};
requiredSupportPackages(1).Version = '24.1.2';

for ii = 1:length(requiredTools)
    if ~license('test', char(requiredTools(ii)))
        warning(['Please install ' char(requiredTools(ii))])
    end
end

supportPackagesInstalled = matlabshared.supportpkg.getInstalled;
if isempty(supportPackagesInstalled)
    for ii = 1:numel(requiredSupportPackages)
        warning(['Please install ' char(requiredSupportPackages(ii).Name)])
    end
else
    supportPackagesInstalledNames = {supportPackagesInstalled.Name};
    supportPackagesInstalledVersions = {supportPackagesInstalled.InstalledVersion};
    for ii = 1:numel(requiredSupportPackages)
        compareIdx = contains(supportPackagesInstalledNames, requiredSupportPackages(ii).Name);
        if ~any(compareIdx)
           warning(['Please install ' char(requiredSupportPackages(ii).Name)])  
        elseif ~strcmp(supportPackagesInstalledVersions(compareIdx), requiredSupportPackages(ii).Version)
            warning(['Please install v' requiredSupportPackages(ii).Version])
        end
    end
end

% initSIL.m Initializes path, load bus definitions, and sets model 
% parameters for vehicleSIL.slx 
addpath(genpath('PX4-Autopilot'));
addpath(genpath('environment'));
addpath(genpath('sensors'));
addpath(genpath('data'));
addpath(genpath('signals'));
addpath(genpath('utilities'));
addpath(genpath('visualization'));
addpath(genpath('PX4SILConnector'));
if strcmp(vehicleParams.type, "F-16")
    addpath(genpath('F16'));
elseif strcmp(vehicleParams.type, "Default")
    addpath(genpath('vehicle'));
end

Simulink.fileGenControl('set', ...
    'CacheFolder', 'work', ...
    'CodeGenFolder', 'work', ...
    'createDir', true)


load('standardSILConfigurationParams.mat')
stepSize_s = 0.004; % step size used in standardSILConfugrationParams.mat file

% Conversions
ft2m = 0.3048;
m2ft = 3.28084;
lbf2N = 4.44822;
lbs2kg = 0.453592;

% load bus definitions
busDefinition

% load vehicle specific data
if strcmp(vehicleParams.type, "F-16")
    vehicleParams.dryMass_kg = 20500 * lbs2kg;
    vehicleParams.aircraftInertialBody_kgm2 = [12820.61 0 1331.41; 0 75673.62 0; 0 0 85552.11];
    vehicleParams.bRef_m = 30 * ft2m;
    vehicleParams.SRef_m2 = 27.8709;
    vehicleParams.cRef_m = 11.32 * ft2m;% Mean Aero Chord
    vehicleParams.aircraftCg_m = [vehicleParams.cRef_m * 0.35; 0; 0]; 
    vehicleParams.refCG_m = [vehicleParams.cRef_m * 0.35; 0; 0]; % reference cg
    aeroDataF16    
end

% Initial Conditions
% set initial location to Juancho E. Yrausquin Airport
referenceAltitude_m = 125 * ft2m;
referenceLatitude_deg = 17.645927; 
referenceLongitude_deg = -63.222027;
aircraftInitialPosInNED_m = [0, 0, -referenceAltitude_m];
aircraftInitialVelInBody_mps = [0, 0, 0];
aircraftInitialEuler_rad = [0, 0, 1.9199];

aircraftInitialBodyRates_radps = [0, 0, 0];
referenceDecimalYear_years = 2024; % World magnetic model doesn't work in 2025
aircraftInitial.lat_deg = referenceLatitude_deg;
aircraftInitial.lon_deg = referenceLongitude_deg;
aircraftInitial.alt_m = aircraftInitialPosInNED_m(3);
aircraftInitial.yawAngle_rad = aircraftInitialEuler_rad(3);
terrainHeightNED_m = aircraftInitialPosInNED_m(3); 

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

%actuatorInterface
actuatorDelay_s = 0.005;
plantSampleTime_s = 0.01;
parameters.engine.minThrottle = 0.01; %idle happens above this value

% Load F16 Engine Model
F16EngineData

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

% Variant Models
% Note: When using the FlightGear option, you must start Flightgear manually by running runFlightGear.m
if strcmp(opts.visualizationType, 'Matlab')
    warning("When using Matlab visualization the SIL runs slower than FlightGear. Recommend setting simulink model to" + ...
        " accelerator mode.")
end

% Save all workspace variables and push them to base workspace
save('workspace')
evalin("base", 'load workspace.mat')
delete workspace.mat
% Launch full SIL if requested
if opts.launchFullSIL
    % Run flightgear if requested
    currLoc = pwd;
    if strcmp(opts.visualizationType, "FlightGear")
        evalin("base", 'runFlightGear')
    end

    % Open QGC
    % Note: System currenlty freezing when running this from script
    disp('Launch QGroundControl manually.');
    %pause;


    % Launch PX4
    eval(strcat("cd ", opts.PX4RepoPath))
    opts.simHostIPVal = double(split(opts.simHostIP, '.'));
    [status,cmdout] = system(sprintf('start wsl bash -c "export PX4_SIM_HOSTNAME=%d.%d.%d.%d && make px4_sitl_default optimAeroF16"',...
        opts.simHostIPVal(1), opts.simHostIPVal(2), opts.simHostIPVal(3), opts.simHostIPVal(4)));
    % Open simulink model
    if isempty(cmdout)
        % cmdout being empty means PX4 is running If it is not empty then most likely there's an error
        cd(currLoc)
        open VehicleSilSimulation.slx
        sim VehicleSilSimulation
    else
        warning(['If the repo path argument points to the WSL side, matlab cannot call the make command. PX4 must be' ...
            ' built manually'])
        error(cmdout)

    end

end

end