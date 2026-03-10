function recognizeCNN()

clc;
disp('----------------------------------');
disp('      STARTING ATTENDANCE (CNN)');
disp('----------------------------------');

load('model/cnnModel.mat');

cam = webcam;
faceDetector = vision.CascadeObjectDetector();

fig = figure('Name','CNN Attendance System');

while ishandle(fig)

    img = snapshot(cam);
    bbox = step(faceDetector, img);

    if ~isempty(bbox)

        face = imcrop(img, bbox(1,:));

        if size(face,3) == 3
            face = rgb2gray(face);
        end

        face = imresize(face,[100 100]);
        face = im2single(face);

        [label, scores] = classify(net, face);

        confidence = max(scores) * 100;

        disp(['Confidence: ', num2str(confidence), '%']);


        roll = char(label);

        if confidence > 70

            img = insertShape(img,'Rectangle',bbox(1,:), ...
                'Color','green','LineWidth',3);

            img = insertText(img,[bbox(1,1) bbox(1,2)-30], ...
                sprintf('%s (%.2f%%)', roll, confidence), ...
                'FontSize',18,'BoxColor','green');

            status = markAttendance(roll);

            if strcmp(status,'MARKED')
                disp('✅ Attendance Marked Successfully');
            else
                disp('⚠ Attendance Already Marked Today');
            end

            pause(2);
            break;

        else

            img = insertShape(img,'Rectangle',bbox(1,:), ...
                'Color','red','LineWidth',3);

            img = insertText(img,[bbox(1,1) bbox(1,2)-30], ...
                'Unknown','FontSize',18,'BoxColor','red');

            disp('❌ Unknown Person');
        end
    end

    imshow(img);
    drawnow;

end

clear cam;
close(fig);

disp('Attendance Stopped Successfully');

end
