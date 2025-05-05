function [] = testVehicleSIL()
% testVehicleSIL.m Conducts tests on VehicleSIL.slx
% Testing:
% 1. Compile testing on all components
% 2. Unit tests defined by test harnesses and mldatx test definitions
%
% TestResults.pdf summarizes results of unit testing 
%=================================
% Inputs
%=================================
% none
%=================================
% OUTPUTS
%=================================
% none
%=================================
% EXAMPLE USAGE
% =================================
% testVehicleSIL()
% testVehicleSIL('rebuildHarnesses', true)

disp('Test Vehicle SIL Model')

clear all
bdclose('all')
evalin('base', 'initVehicleSIL')

%% Change the cache folders to non-default locations
cfg = Simulink.fileGenControl('getConfig');
currentCacheFolder = cfg.CacheFolder;
fullpathHere = mfilename('fullpath');
[pathHere, ~, ~] = fileparts(fullpathHere);
cfg.CacheFolder = [pathHere, '\work'];
if ~exist([pathHere, '\work'], 'dir')
    mkdir(pathHere, 'work')
end
Simulink.fileGenControl('setConfig', 'config', cfg);

try
    %% Compile Models
    disp('Compiling models...')
    %vehicle
    try
        vehicleParams = evalin('base', 'vehicleParams');
        vehicleParams.type = erase(vehicleParams.type, '-');
        eval(strcat(vehicleParams.type, '([], [], [], ''compile'')'))
        eval(strcat(vehicleParams.type, '([], [], [], ''term'')'))
    catch ME
        warning('Error compiling vehicle model.')
        rethrow(ME)
    end
    
    %sensors
    try
        sensors([], [], [], 'compile')
        sensors([], [], [], 'term')
    catch ME
        warning('Error compiling sensors model.')
        rethrow(ME)
    end
    
    %environment
    try
        environment([], [], [], 'compile')
        environment([], [], [], 'term')
    catch ME
        warning('Error compiling environment model.')
        rethrow(ME)
    end
    
    %Vehicle Plant
    try
        VehiclePlant([], [], [], 'compile')
        VehiclePlant([], [], [], 'term')
    catch ME
        warning('Error compiling Vehicle Plant model.')
        rethrow(ME)
    end
    
    % sim Vehicle Plant
    try
        paramStruct.StopTime = "10";
        sim("VehiclePlant", paramStruct);
    catch ME
        warning('Error executing Vehicle Plant model.')
        rethrow(ME)
    end
    
    bdclose('all')
    
    disp('Finished compiling models...')
    

    %% Unit testing 
    disp('Unit testing starting...')
    
    disp('Rebuilding test harnesses...')
    rebuildHarness('all', 'pathRootDir', pathHere)
    if strcmpi(vehicleParams.type, "F16")
        sltest.testmanager.load('F16.mldatx');
    end
    sltest.testmanager.load('sensors.mldatx');
    sltest.testmanager.load('environment.mldatx');
    results = sltest.testmanager.run;
    
    % reporting
    testResultsPath = strrep(mfilename("fullpath"), 'testVehicleSIL', 'testResults.pdf');
    if exist(testResultsPath, 'file')
        delete testResults.pdf
    end
    
    % get branch and current commit hash
    [~, gitBranchString] = system('git rev-parse --abbrev-ref HEAD');
    [~, gitHashString] = system('git rev-parse HEAD');
    titleString = string(['Branch: ', gitBranchString]);
    authorString = string(['Previous Commit Hash: ', gitHashString]);
    
    if results.NumPassed == results.NumTotal
        disp('Unit testing passed!')
        disp('Printing results....')
        sltest.testmanager.report(results, testResultsPath, 'LaunchReport', false, 'IncludeTestResults', 0, 'Title', titleString, 'Author', authorString);
        sltest.testmanager.clearResults
    else
        sltest.testmanager.report(results, testResultsPath, 'LaunchReport', false, 'Title', titleString, 'Author', authorString);
        error(['Unit testing failed! ' '<a href="matlab: sltest.testmanager.view">Click here to view results</a>' ' or view them in testResults.pdf'])
    end

    %% Change the cache folders to original locations
    cfg.CacheFolder = currentCacheFolder;
    Simulink.fileGenControl('setConfig', 'config', cfg);

    %% Clean up and initialize before exiting
    clear all
    bdclose('all')
    evalin('base', 'initVehicleSIL')
    
catch ME
    %% Change the cache folders to original locations
    cfg.CacheFolder = currentCacheFolder;
    Simulink.fileGenControl('setConfig', 'config', cfg);

    %let user know of orginal error
    rethrow(ME)

    %% Clean up and initialize before exiting
    clear all
    bdclose('all')
    evalin('base', 'initVehicleSIL')
end