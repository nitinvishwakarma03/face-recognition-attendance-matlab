function registerStudent()

clc;
disp('----------------------------------');
disp('      STUDENT REGISTRATION');
disp('----------------------------------');

name = input('Enter Student Name: ','s');
roll = input('Enter Roll Number (Format: 0201MT221038): ','s');

% Validate Roll Number
if ~validateRoll(roll)
    disp('❌ Invalid Roll Number Format!');
    return;
end

% Create Student Folder
projectFolder = fileparts(mfilename('fullpath'));
studentFolder = fullfile(projectFolder,'dataset',roll);


if ~exist(studentFolder, 'dir')
    mkdir(studentFolder);
else
    disp('⚠ Student already exists. Images may be overwritten.');
end

disp('Choose Image Input Method:');
disp('1. Capture from Webcam');
disp('2. Upload from Gallery');

choice = input('Enter choice (1 or 2): ');

faceDetector = vision.CascadeObjectDetector();

% ----------------------------------
% OPTION 1: WEBCAM CAPTURE
% ----------------------------------
if choice == 1
    
    cam = webcam;
    disp('📷 Capturing 20 Images...');
    
    count = 0;
    maxImages = 20;
    
    while count < maxImages
        
        img = snapshot(cam);
        bbox = step(faceDetector, img);
        
        if ~isempty(bbox)
            
            face = imcrop(img, bbox(1,:));
            grayFace = rgb2gray(face);
            resizedFace = imresize(grayFace, [100 100]);
            
            filename = fullfile(studentFolder, ...
                sprintf('%s_%02d.jpg', roll, count+1));
            
            imwrite(resizedFace, filename);
            
            count = count + 1;
            
            imshow(resizedFace);
            title(['Captured Image: ', num2str(count)]);
            
            pause(0.4);
        end
    end
    
    clear cam;
    
% ----------------------------------
% OPTION 2: UPLOAD FROM GALLERY
% ----------------------------------
elseif choice == 2
    
    [files, path] = uigetfile({'*.jpg;*.png'}, ...
        'Select Student Images', 'MultiSelect', 'on');
    
    if isequal(files,0)
        disp('No images selected.');
        return;
    end
    
    if ischar(files)
        files = {files}; % convert single file to cell
    end
    
    for i = 1:length(files)
        
        img = imread(fullfile(path, files{i}));
        bbox = step(faceDetector, img);
        
        if ~isempty(bbox)
            
            face = imcrop(img, bbox(1,:));
            grayFace = rgb2gray(face);
            resizedFace = imresize(grayFace, [100 100]);
            
            filename = fullfile(studentFolder, ...
                sprintf('%s_%02d.jpg', roll, i));
            
            imwrite(resizedFace, filename);
        end
    end
    
    disp('Images uploaded and processed successfully.');
    
else
    disp('Invalid Choice.');
    return;
end

disp('----------------------------------');
disp(['✅ Registration Completed for ', name]);
disp('----------------------------------');

end
