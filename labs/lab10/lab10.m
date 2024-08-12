%% part 1

net = googlenet;

I = imread("peppers.png");
inputSize = net.Layers(1).InputSize;
I = imresize(I,inputSize(1:2));

label = classify(net,I);
figure,subplot(131)
imshow(I)
title(string(label))

I = imread("test.jpg");
inputSize = net.Layers(1).InputSize;
I = imresize(I,inputSize(1:2));

label = classify(net,I);
subplot(132)
imshow(I)
title(string(label))

I = imread("hat.jpg");
inputSize = net.Layers(1).InputSize;
I = imresize(I,inputSize(1:2));

label = classify(net,I);
subplot(133)
imshow(I)
title(string(label))

lastLayer = net.Layers(end);

%% part 2

I = imread("test.jpg");     %test image
I = imresize(I, [227,227]);

[YPred,probs] = classify(trainedNetwork_1,I);
figure
imshow(I)
label = YPred;
title(string(label) + ", " + num2str(100*max(probs),3) + "%");

I = imread("hat.jpg");     %hat image
I = imresize(I, [227,227]);

[YPred,probs] = classify(trainedNetwork_1,I);
figure
imshow(I)
label = YPred;
title(string(label) + ", " + num2str(100*max(probs),3) + "%");
