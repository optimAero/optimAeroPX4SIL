function [] = makeHarness(modelName, varargin)
% makeHarness.m Creates a test harness for the model name given
% looks for the model in the current path and places the test harness and 
% the xml in the correct testing folder
%
%=================================
% Inputs
%=================================
% modelName: name of a model in the MATLAB's current path
% deleteExisting (optional): flag allowing script to delete existing harness, xml file, and test sequence scripts  
%=================================
% OUTPUTS
%=================================
% none
%=================================
% EXAMPLE USAGE
% =================================
% makeHarness('gps')
% makeHarness('gps.slx')
% makeHarness('gps.slx', 'deleteExisting', false)
% makeHarness('gps.slx', 'deleteExisting', true)

    deleteExisting = false;
    for ii = 1:2:length(varargin)
        if strcmp('deleteExisting', varargin{ii})
            deleteExisting = varargin{ii + 1};
        end
    end
    
    % load model
    load_system(modelName)

    % determine path and harness name
    fullmodelPath = which(modelName);
    [modelPath, modelName, ~] = fileparts(fullmodelPath);
    if isempty(modelPath)
        harnessPath = '../testing/';
    else
        if contains(modelPath, 'components')
            harnessPath = strrep(modelPath, 'components', 'testing');
        else
            harnessPath = [modelPath, '\testing'];
        end
    end
    harnessName = [modelName 'TestHarness'];
    
    % check if harness already exist
    if exist(harnessName, 'file')>0 && ~deleteExisting
        error('Harness already exist! Set deleteExisting to true to delete exisiting harness.')
    elseif exist(harnessName,'file')>0 && deleteExisting
        sltest.harness.delete(modelName, harnessName)
    end
    
    % create harness
    sltest.harness.create(modelName,'Name', harnessName,...
        'Source', 'Test Sequence', 'SaveExternally', true)
    
    % load harness
    sltest.harness.load(modelName, harnessName);
    
    %% custom set-up
    % add a stopTest parameter
    sltest.testsequence.addSymbol([harnessName '/Test Sequence'], 'stopTest', 'Data', 'Output');
    % edit init step to initialize stopTest to false
    initStep = sltest.testsequence.readStep([harnessName '/Test Sequence'], 'Run', 'Action');
    initStep(end+1) = initStep(1);
    initStep(end+1) = initStep(1);
    initStep(end+1:end+17) = 'stopTest = false;';
    sltest.testsequence.editStep([harnessName '/Test Sequence'], 'Run', 'Action', initStep);
    % rename first step to Initialize
    sltest.testsequence.editStep([harnessName '/Test Sequence'], 'Run', 'Name', 'Initialize');
    % add EndTest step, set stopTest to true when transitioning to this step
    sltest.testsequence.addStep([harnessName '/Test Sequence'], 'EndTest');
    sltest.testsequence.editStep([harnessName '/Test Sequence'], 'EndTest', 'Action', 'stopTest = true;');
    % add transition between the two existing steps
    sltest.testsequence.addTransition([harnessName '/Test Sequence'], 'Initialize', 'true', 'EndTest')
    sltest.testsequence.useScenario([harnessName '/Test Sequence'], 'Scenario_1')

    %% add stop block
    add_block('simulink/Sinks/Stop Simulation', [harnessName, '/Stop'])
    % get position of the last test sequence block port 
    testSeqPort   = get_param([harnessName, '/Test Sequence'], 'PortConnectivity');
    % place stop block to the right of the last test sequence block port 
    set_param([harnessName,'/Stop'], 'position', [testSeqPort(end).Position(1) + 50,...
                                                        testSeqPort(end).Position(2) + 50,...
                                                        testSeqPort(end).Position(1) + 85,...
                                                        testSeqPort(end).Position(2) + 90])
    stopPort = get_param([harnessName, '/Stop'], 'PortConnectivity');
    % create line between stop and test sequence blocks 
    add_line(harnessName, [testSeqPort(end).Position; stopPort(1).Position])
    
    %% save changes, close model and test harness
    save_system(harnessName);
    sltest.harness.close(modelName, harnessName);
    close_system(modelName, 0);
    
    %% move the test harness and harnessInfo.xml to the correct testing directory
    movefile(['./' harnessName '.slx'], harnessPath);
    movefile([modelPath '\' modelName '_harnessInfo.xml'], harnessPath);

end