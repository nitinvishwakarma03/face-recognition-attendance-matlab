function trainCNNModel()

clc;
disp('----------------------------------');
disp('   TRAINING CNN MODEL (AUGMENTED)');
disp('----------------------------------');

datasetPath = 'dataset';

imds = imageDatastore(datasetPath, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% Check dataset
labelCount = countEachLabel(imds);
disp(labelCount);

if numel(unique(imds.Labels)) < 2
    error('At least 2 students required for CNN training.');
end

% Split data
[imdsTrain, imdsValidation] = splitEachLabel(imds, 0.8, 'randomized');

% Data Augmentation
augmenter = imageDataAugmenter( ...
    'RandRotation',[-15 15], ...
    'RandXTranslation',[-5 5], ...
    'RandYTranslation',[-5 5], ...
    'RandXScale',[0.9 1.1], ...
    'RandYScale',[0.9 1.1], ...
    'RandXReflection',true);

inputSize = [100 100 1];

augimdsTrain = augmentedImageDatastore(inputSize, imdsTrain, ...
    'DataAugmentation', augmenter);

augimdsValidation = augmentedImageDatastore(inputSize, imdsValidation);

numClasses = numel(categories(imds.Labels));

% Lightweight CNN for small data
layers = [
    imageInputLayer(inputSize)

    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    fullyConnectedLayer(32)
    reluLayer

    fullyConnectedLayer(numClasses)
    dropoutLayer(0.3)
    softmaxLayer
    classificationLayer
];

options = trainingOptions('adam', ...
    'InitialLearnRate',0.0005, ...
    'MaxEpochs',40, ...
    'MiniBatchSize',8, ...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(augimdsTrain, layers, options);

if ~exist('model','dir')
    mkdir('model');
end

save('model/cnnModel.mat','net');

disp('----------------------------------');
disp('✅ CNN Training Completed');
disp('----------------------------------');

end
