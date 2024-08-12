%% training of network
% read and make image dataset
digitDatasetPath = fullfile('C:\Users\shido\OneDrive\Documents\utd\year3\spring2023\BMEN 4370.001\project\archive\brain_tumor_dataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% make image dataset to 200x200 grayscale
targetSize = [200,200];
augImds = augmentedImageDatastore(targetSize, imds, 'ColorPreprocessing', 'rgb2gray');

% split the data into training and validation sets
%[imdsTrain, imdsValidation] = splitEachLabel(augImds, 0.8, 'randomized');

% define layers
layers = [
    imageInputLayer([200 200 1])
	
    convolution2dLayer(3,16,Padding="same")
    batchNormalizationLayer
    reluLayer
	
    maxPooling2dLayer(2,Stride=2)
	
    convolution2dLayer(3,32,Padding="same")
    batchNormalizationLayer
    reluLayer
	
    maxPooling2dLayer(2,Stride=2)
	
    convolution2dLayer(3,64,Padding="same")
    batchNormalizationLayer
    reluLayer
	
    maxPooling2dLayer(2,Stride=2)
	
    convolution2dLayer(3,128,Padding="same")
    batchNormalizationLayer
    reluLayer
	
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

% training options
options = trainingOptions("sgdm", ...
    InitialLearnRate=0.001, ...
    MaxEpochs=8, ...
    Plots="training-progress");    

net = trainNetwork(augImds,layers,options);

%% classification of 5 images
% load 5 MRI images, resize, convert to grayscale
NT1 = imread("imagetovalidate\notumor1.jpg");
NT1 = imresize(NT1,targetSize);
NT1 = rgb2gray(NT1);

NT2 = imread("imagetovalidate\notumor2.jpg");
NT2 = imresize(NT2,targetSize);
NT2 = rgb2gray(NT2);

NT3 = imread("imagetovalidate\notumor3.jpg");
NT3 = imresize(NT3,targetSize);
NT3 = rgb2gray(NT3);

T1 = imread("imagetovalidate\tumor1.jpg");
T1 = imresize(T1,targetSize);
%T1 = rgb2gray(T1);

T2 = imread("imagetovalidate\tumor2.jpg");
T2 = imresize(T2,targetSize);
T2 = rgb2gray(T2);

% classify, display on figure
[Ypred, score] = classify(net,NT1);
figure,subplot(151),imshow(NT1),title(sprintf('Label: %s, Score: %.2f%%', Ypred, max(score)*100))

[Ypred, score] = classify(net,NT2);
subplot(152),imshow(NT2),title(sprintf('Label: %s, Score: %.2f%%', Ypred, max(score)*100))

[Ypred, score] = classify(net,NT3);
subplot(153),imshow(NT3),title(sprintf('Label: %s, Score: %.2f%%', Ypred, max(score)*100))

[Ypred, score] = classify(net,T1);
subplot(154),imshow(T1),title(sprintf('Label: %s, Score: %.2f%%', Ypred, max(score)*100))

[Ypred, score] = classify(net,T2);
subplot(155),imshow(T2),title(sprintf('Label: %s, Score: %.2f%%', Ypred, max(score)*100))
