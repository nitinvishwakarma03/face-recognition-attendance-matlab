function status = markAttendance(roll)

today = datestr(now,'yyyy-mm-dd');
attendanceFolder = 'attendance';

if ~exist(attendanceFolder,'dir')
    mkdir(attendanceFolder);
end

filePath = fullfile(attendanceFolder, [today,'.csv']);

% If file does not exist, create it
if ~exist(filePath,'file')
    fid = fopen(filePath,'w');
    fprintf(fid,'Roll,Time\n');
    fclose(fid);
end

data = readtable(filePath);

% If already marked
if any(strcmp(data.Roll, roll))
    status = "ALREADY_MARKED";
    return;
end

% Append new attendance
fid = fopen(filePath,'a');
fprintf(fid,'%s,%s\n', roll, datestr(now,'HH:MM:SS'));
fclose(fid);

status = "MARKED";

end
