% recursively go through every slx file in the current folder (will try folders
% even if they're not in the path but will catch out) and disable logging
% of all signals.

modelFiles = dir(fullfile(pwd,'**/*.slx'));

for k = 1:length(modelFiles)
    skipThisFile = false;
    modelName = modelFiles(k).name(1:end-4);
    try
        load_system(modelName);
    catch
        skipThisFile = true;
    end
    if ~skipThisFile
        mdlsignals = find_system(modelName,'MatchFilter', @Simulink.match.activeVariants, 'FindAll','on','LookUnderMasks','all','FollowLinks','on','type','line','SegmentType','trunk');
    
        ph = get_param(mdlsignals,'SrcPortHandle');
        fileChanged = false;
        for i = 1:length(ph)
            try
                if strcmp(get_param(ph{i}, 'datalogging'), 'on')
                    set_param(ph{i},'datalogging','off');
                    fileChanged = true;
                end
            catch
               disp(['some error occurred, continuing: ' modelName])
               save_system(modelName);
               disp(['force saved ' modelName]);
            end
        end
        if fileChanged
            save_system(modelName);
            disp(['saved ' modelName]);
        else
            disp(['no changes: ' modelName]);
        end
        close_system(modelName);
        clear mdlsignals, ph;
    end
end