% visDiffBranch.m: visual difference between the local slx file indicated and the same file from another branch. 
% Note: will not show difference in referenced files; will use existing local reference files. You have to run this on
% each of them individually to see deltas.
% Example usage: 
% visDiffBranch('cgMassInertia.slx', pwd, 'origin/main')
% visDiffBranch('F16/components/cgMassInertia.slx', 'D:\OA\px4sil', 'origin/main')
% visDiffBranch('cgMassInertia.slx')

function visDiffBranch(fileName, projectPath, compareToBranch)
    %Warning: this tool must be ran within the repo
    arguments
        fileName        (1, :) char
        projectPath     (1, :) char = pwd()
        compareToBranch (1, :) char = 'origin/main'
    end
    curDir = pwd;
    cd(projectPath)
    
    [tempFilePath, absolutePath] = getFromAnotherBranch(projectPath, compareToBranch, fileName);
    visdiff(tempFilePath, absolutePath);
    cd(curDir)

end

function [tempFileAbsPath, absPath] = getFromAnotherBranch(projectPath, compareToBranch, fileName)
    arguments
        projectPath         (1, :) char
        compareToBranch     (1, 1) string
        fileName            (1, 1) string
    end
    
    [pathRelativeToRepoRoot, absPath] = getFilePathWrtRepo(fileName, projectPath);
    tempFileAbsPath = getTempFilePath(pathRelativeToRepoRoot);
    gitCmdChar = sprintf('git cat-file --filters %s:%s > %s', char(compareToBranch), pathRelativeToRepoRoot, tempFileAbsPath);
    disp(['git cmd: ', gitCmdChar]);
    [exitCode, callReturn] = system(gitCmdChar);
    assert(~exitCode, ['error: ', newline, callReturn]);
    
    if ispc   
        [filePath, fileName, fileExt] = fileparts(tempFileAbsPath);
        if length(fileName) > 62 % max filename length in Windows install
            tempFileAbsPath = [filePath '\' fileName(1:62) fileExt];
            copyfile([filePath '\' fileName fileExt], tempFileAbsPath)
        end
    else
        error('no linux/unix support yet')
    end

end


function tempFilePath = getTempFilePath(pathRelativeToRepoRoot)
    % helper function to get the path to a unique-named temporary file
    [~, fName, fExt] = fileparts(pathRelativeToRepoRoot);
    tempFilePathName = [tempname(), '_', fName];
    [tempPath, tempName, ~] = fileparts(tempFilePathName);
    if length(tempName) > 62
        % visdiff wont work if this is longer than 62 characters so take characters off of the front of the name
        tempName = tempName(end-61:end);
    end
    tempFilePath = [tempPath, tempName, fExt]; % temporary file with correct file extension
    end
    
    function [pathRelativeToRepoRoot, absPath] = getFilePathWrtRepo(fileName, projectPath)
        
    if contains(fileName, filesep)
        assert(isfile(fileName), ["File not found: ", fileName]);
        filePath = java.nio.file.Paths.get(fileName, "");
        if filePath.isAbsolute()
            filePathAbs = filePath;
        else
            filePath = java.nio.file.Paths.get(pwd(), fileName);
            filePathAbs = filePath.toAbsolutePath();
        end
    else
        absPath = which(fileName);
        assert(~isempty(absPath), "File not found: ", fileName);
        filePathAbs = java.nio.file.Paths.get(absPath, "");
    end
    
    rootPath = java.nio.file.Paths.get(projectPath, "");
    pathRelativeToRepoRoot = char(rootPath.relativize(filePathAbs).normalize().toString());
    
    if ispc
        pathRelativeToRepoRoot = strrep(pathRelativeToRepoRoot, '\', '/');
    end
    
    absPath = char(filePathAbs.normalize().toString());

end