% initVehicleSIL: This function checks to make sure the matlab environment is set up properly. This file checks if the
% user has the required toolboxes, support packages, and loads variable and bus definitions that are used in the
% F-16.slx model.
% ======================================================================================================================
%                                                       INPUTS
% ======================================================================================================================
% opts.launchFullSIL:            Flag used to launch the full SIL, set to False if desire is to only to load workspace.
%                                NOTE: should not be used on first attempt of using SIL.
% opts.visualizationType:        The method that will be used to visualize the aircraft while SIL is running
% opts.simHostIP:                IP Address of users computer
% opts.vehicleType:              The plant model that will be used during the SIL simulation: F-16, hexarotor, etc
% opts.controllerType:           The flight controller used in the SIL simulation (currently can only be PX4)
% opts.PX4RepoPath               Path relative to optimAeroPX4SIL if PX4 repo is on windows side, or path relative to root wsl directory
% opts.PX4InWSL                  If attempting to use the PX4 repo cloned into the WSL root directory, set this variable to true
% opts.makeClean                 Removes all the compiled build files and intermediate artifacts. This may need to be 
%                                set to true when making changes to the configuration file. 
% ======================================================================================================================
%                                                    EXAMPLE USAGE
% ======================================================================================================================
% initVehicleSIL("launchFullSIL",false):   
%   Run the intialization file only, this should be used before changing any models
% initVehicleSIL("launchFullSIL", true, "vehicleType", "F-16", "visualizationType", "FlightGear", "simHostIP", "10.0.0.200","PX4InWSL",true):
%   Launch full SIL sim of F-16, visualize vehicle using FlightGear, use the PX4 repo cloned into the WSL root directory
%   and set IP address for PX4 connection.
% initVehicleSIL("launchFullSIL", false, "vehicleType", "hexarotor", "visualizationType", "FlightGear", "simHostIP", "10.0.0.200","PX4InWSL", false)
%   Load sim as "hexarotor"
% initVehicleSIL("launchFullSIL", true, "vehicleType", "hexarotor", "visualizationType", "FlightGear", "simHostIP", "192.168.12.145", "PX4InWSL", true, "makeClean", true)
%   Launch full sim for hexarotor in flight gear with the PX4 repo in Linux partition for faster compilation, make clean
%   on PX4 compile every time

function initVehicleSIL(opts)

arguments
    opts.launchFullSIL        (1,1) logical = false
    opts.vehicleType          (1,1) string  = "F-16"            % "F-16", "hexarotor"
    opts.visualizationType    (1,1) string  = "Matlab"          % "PassThrough", "FlightGear", or "Matlab"
    opts.simHostIP            (1,1) string  = "10.0.0.243"      % Replace with your IP address (not WSL's IP)
    opts.controllerType       (1,1) string  = "PX4"             % Currently PX4 is the only controller that can be used
    opts.PX4RepoPath          (1,1) string  = "PX4-Autopilot"   % PX4 repository path
    opts.PX4InWSL             (1,1) logical = false             % Is PX4 repository stored in Linux partition
    opts.makeClean            (1,1) logical = false             % Run "make clean" before "make" - if in doubt, use if PX4 config changes made
end
% Note: In future versions these will be arguments
vehicleParams.type                   = opts.vehicleType;
vehicleParams.controllerType         = opts.controllerType;

% check for required toolboxes, support packages, and MATLAB version
% list is here: (https://www.mathworks.com/matlabcentral/answers/377731-how-do-features-from-license-correspond-to-names
% -from-ver#answer_300675)
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
requiredSupportPackages(1).Version = {'24.1.2', '24.1.3'};

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
        elseif all(strcmpi(supportPackagesInstalledVersions(compareIdx), requiredSupportPackages(ii).Version))
            warning(['Please install v' requiredSupportPackages(ii).Version{1} ' or v' ...
                requiredSupportPackages(ii).Version{2} ' of the ' requiredSupportPackages(ii).Name{1}])
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
addpath(genpath('vehicle/common'));

if strcmpi(vehicleParams.type, "F-16")
    addpath(genpath('vehicle/F16'));
    compilerVehicleName = "optimAeroF16";
elseif strcmpi(vehicleParams.type, "hexarotor")
    addpath(genpath('vehicle/hexarotor'))
    compilerVehicleName = "optimAeroHex";
end

Simulink.fileGenControl('set', ...
    'CacheFolder', 'work', ...
    'CodeGenFolder', 'work', ...
    'createDir', true)

load('standardSILConfigurationParams.mat')
stepSize_s = 0.004; % step size used in standardSILConfugrationParams.mat file

% Conversions
constants

% load bus definitions
busDefinition(vehicleParams.type)

% load vehicle specific data and initial conditions
setUpVehicle

% load sensor data
setUpSensors

%actuatorInterface
setUpActuators

% set up winds
setUpEnvironment


% Variant Models
% Note: When using the FlightGear option, you must start Flightgear manually by running runFlightGear.m
if strcmpi(opts.visualizationType, 'Matlab')
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
    if strcmpi(opts.visualizationType, "FlightGear")
        evalin("base", 'runFlightGear')
    end

    % Open QGC
    disp('Launch QGroundControl manually.');

    % Launch PX4
    opts.simHostIPVal = double(split(opts.simHostIP, '.'));
    if ~opts.PX4InWSL
        % Launch PX4-Autopilot that is checked out on the Windows side
        eval(strcat("cd ", opts.PX4RepoPath))
        opts.simHostIPVal = double(split(opts.simHostIP, '.'));
        if opts.makeClean
            [~,cmdout] = system(sprintf(['start wsl bash -c "export PX4_SIM_HOSTNAME=%d.%d.%d.%d && make clean && ' ...
                'make px4_sitl_default %s"'],...
                opts.simHostIPVal(1), opts.simHostIPVal(2), opts.simHostIPVal(3), opts.simHostIPVal(4), ...
                compilerVehicleName ));
        else
            [~,cmdout] = system(sprintf('start wsl bash -c "export PX4_SIM_HOSTNAME=%d.%d.%d.%d && make px4_sitl_default %s"',...
                opts.simHostIPVal(1), opts.simHostIPVal(2), opts.simHostIPVal(3), opts.simHostIPVal(4), ...
                compilerVehicleName ));
        end
    else
        if opts.makeClean
            % Launch PX4-Autopilot that is cloned into the WSL root directory
            [~,cmdout] = system(sprintf(['start wsl bash -c "cd ~/%s && export PX4_SIM_HOSTNAME=%d.%d.%d.%d && ' ...
                'make clean && make px4_sitl_default %s"'],...
                opts.PX4RepoPath, opts.simHostIPVal(1), opts.simHostIPVal(2), opts.simHostIPVal(3), ...
                opts.simHostIPVal(4), compilerVehicleName ));
        else
            % Launch PX4-Autopilot that is cloned into the WSL root directory
            [~,cmdout] = system(sprintf(['start wsl bash -c "cd ~/%s && export PX4_SIM_HOSTNAME=%d.%d.%d.%d &&' ...
                ' make px4_sitl_default %s"'],...
                opts.PX4RepoPath, opts.simHostIPVal(1), opts.simHostIPVal(2), opts.simHostIPVal(3), ...
                opts.simHostIPVal(4), compilerVehicleName ));
        end
    end

    if ~isempty(cmdout)
        % Display system command output if system call fails
        error(cmdout)
    end

    % Open simulink model
    cd(currLoc)
    open VehicleSilSimulation.slx
    % Run simulink model
    sim VehicleSilSimulation
end

end