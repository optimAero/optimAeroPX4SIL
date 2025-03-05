function [] = rebuildHarness(modelName, varargin)
% rebuildHarness.m Rebuilds an existing test harness for a given model
% name, by default will only rebuild if the test harness is older than the model
%=================================
% Inputs
%=================================
% modelName: name of a model in the MATLAB's current path, also accepts
% 'all' to rebuild all the test harnesses in a given root directory
% pathRootDir(optional): root directory to search for models, required if
% modelName = 'all'
% forceUpdate(optional): will update the test harness even if the model is 
% older
%=================================
% OUTPUTS
%=================================
% none
%=================================
% EXAMPLE USAGE
% =================================
% rebuildHarness('gps')
% rebuildHarness('gps')
% rebuildHarness('gps', 'forceUpdate', true)
% rebuildHarness('all', 'pathRootDir', './')

    % optional inputs 
    pathRootDir = '';
    forceUpdate = false;
    for ii = 1:2:length(varargin)
        if strcmp('pathRootDir', varargin{ii})
            pathRootDir = varargin{ii + 1};
        end
        if strcmp('forceUpdate', varargin{ii})
            forceUpdate = varargin{ii + 1};
        end
    end

    %rebuild any old test harnesses, modelName == 'all'
    if strcmp(modelName, 'all')

        if isempty(pathRootDir)
            error('If using keyword ''all'' you must also define the pathRootDir parameter.')
        end
        
        %find all .slx
        slxList = dir(fullfile(pathRootDir, '**\*.slx'));
        slxNames = unique({slxList.name});
        for slxName = slxNames
            
            %check if .slx file is a model or test harness
            if contains(slxName{1}, 'TestHarness')
                %skip if slx file is a test harness continue
                continue
            end

            %check if model has a test harness and its older than the model
            updateTestHarness = false;
            for harnessName = slxNames
                if contains(harnessName, [slxName{1}(1:end-4) 'TestHarness']) && isfile(which(harnessName{1}))
                        lastModDateModel = get_param(load_system(slxName{1}), 'LastModifiedDate');
                        lastModDateModel = datetime(lastModDateModel, 'InputFormat', 'eee MMM dd HH:mm:ss y');
                        lastModDateHarness = get_param(load_system(harnessName{1}), 'LastModifiedDate');
                        lastModDateHarness = datetime(lastModDateHarness, 'InputFormat', 'eee MMM dd HH:mm:ss y');
                        if lastModDateHarness<lastModDateModel || forceUpdate
                            disp(['Rebuilding test harness for ' slxName{1}])
                            updateTestHarness = true;
                        end
                        close_system(slxName{1}, 0);
                        close_system(harnessName{1}, 0);
                end
            end
            if updateTestHarness
                modelName = slxName{1}(1:end-4);
                harnessName = [slxName{1}(1:end-4) 'TestHarness'];
                load_system(modelName)
                sltest.harness.rebuild(modelName, harnessName)
                close_system(modelName, 0);
            end
        end
    %rebuild test harnesses from modelName
    else
        %determine model and harness names
        fullmodelPath = which(modelName);
        [~,modelName,~] = fileparts(fullmodelPath);
        harnessName = [modelName 'TestHarness'];
        %compare modification dates to determine if a rebuild is needed
        lastModDateMode = get_param(load_system(modelName), 'LastModifiedDate');
        lastModDateMode = datetime(lastModDateMode,'InputFormat', 'eee MMM dd HH:mm:ss y');
        lastModDateHarness = get_param(load_system(harnessName), 'LastModifiedDate');
        lastModDateHarness = datetime(lastModDateHarness, 'InputFormat', 'eee MMM dd HH:mm:ss y');
        if lastModDateHarness<lastModDateMode || forceUpdate
            disp(['Rebuilding test harness for ' modelName])
            sltest.harness.rebuild(modelName, harnessName )
        else
            disp([modelName ' is newer than its test harness, rebuilding skipped!'])
            disp('Set ''forceUpdate'' to true a force a rebuild.')
        end
        close_system(modelName, 0);
        close_system(harnessName, 0);
    end

end