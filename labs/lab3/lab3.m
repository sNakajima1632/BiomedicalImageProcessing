clear;clc;close all;

%% 1.1
% Create binary mask
for i = 1:550 
    for j = 1:250 
        d = ((i - 100)^2 + (j - 125)^2)^(.5); 
        if (d > 80) 
            b(i,j) = 0; 
        else 
        b(i,j) = 1; 
        end
    end
end 
 
% Load medical image datasets and convert to grayscale
I1 = imread('BodyMRI.png');
I2 = imread('BodyPET.png');
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);
 
% Mathematical operations involving two images must be done between two 
% same-sized images
figure, subplot(2,2,1) 
imshow(I1) 
title('Original image I1') 
subplot(2,2,2)
imshow(I2) 
title('Original image I2') 
I = I1 + I2;        % Addition of two images 
subplot(2,2,3)
imshow(I) 
title('Addition of images, I1+I2') 
I = I1 - I2;        % Subtraction of two images 
subplot(2,2,4)
imshow(I) 
title('Subtraction of images, I1-I2') 
 
figure, subplot(2,2,1) 
imshow(I1) 
title('Original image I1')
I = I1 + 50; 
subplot(2,2,2) 
imshow(I) 
title('Brighter image I1'); 
I = I1 - 100; 
subplot(2,2,3) 
imshow(I) 
title('Darker image I1'); 

% Change data type before applying the image mask 
I = I1.*uint8(b);   
subplot(2,2,4) 
imshow(I) 
title('Masked Image I1') 


%% 1.2
I1 = imread('BodyMRI_noise1.png');
I2 = imread('BodyMRI_noise2.png');
I3 = imread('BodyMRI_noise3.png');
I4 = imread('BodyMRI_noise4.png');
I5 = imread('BodyMRI_noise5.png');

Iavg = I1/5 + I2/5 + I3/5 + I4/5 + I5/5;
figure, imshow(Iavg);


%% 1.3
% Load scanning electron microscopy image of red blood cells (RBC)
x = imread('RBC.jpg');
 
% Resize image 2x using bicubic interpolation
X = imresize(x,size(x)*2,'bicubic');
 
% Threshold image to help remove background signal
Xt = X.*uint8(X > 65);
 
% Load blurry RBC image, resize and threshold
xb = imread('RBC_blurry.jpg');
Xb = imresize(xb,size(xb)*2,'bicubic');
Xbt = Xb.*uint8(Xb > 65);
 
figure, subplot(2,4,1)
imshow(X), title('X')
subplot(2,4,2), imshow(Xb), title('Xb')
subplot(2,4,3), imshow(Xt), title('Xt')
subplot(2,4,4), imshow(Xbt), title('Xbt')
 
% Take complement of image X
cImgXt = not(Xt);
subplot(2,4,5), imshow(cImgXt), title('Complement of Xt')
 
% Take an exclusive OR (XOR) of images Xt and Xbt
XORImg = xor(Xt,Xbt);
subplot(2,4,6), imshow(XORImg), title('XOR of Xt and Xbt')
 
% Take an OR of images Xt and Xbt
ORImg = or(Xt,Xbt);
subplot(2,4,7), imshow(ORImg), title('OR of Xt and Xbt')
 
% Take AND of images Xt and Xbt
ANDImg = and(Xt,Xbt);
subplot(2,4,8), imshow(ANDImg), title('AND of Xt and Xbt')


%% exercise 2 part 2
btcimg = imread('BreastTumorCell.jpg');
btcNN = imresize(btcimg,size(btcimg)*3,"nearest");
btcBL = imresize(btcimg,size(btcimg)*3,"bilinear");
btcBC = imresize(btcimg,size(btcimg)*3,"bicubic");

% create binary mask
mask = zeros(size(btcNN));
[m,n] = size(btcimg);
for i = m:2*m
    for j = n:2*n
        mask(i,j) = 1;
    end
end

% apply mask on bicubic image
btcBCM = btcBC.*uint8(mask);

figure;
subplot(1,4,1), imshow(btcNN), title('nearest neighbor')
subplot(1,4,2), imshow(btcBL), title('bilinear')
subplot(1,4,3), imshow(btcBC), title('bicubic')
subplot(1,4,4), imshow(btcBCM), title('bicubic with mask')


%% exercise 2 part 3
x = load('mri');
X = squeeze(x.D);
y = X(:,:,15);

figure;
imshow(y), title('slice 15 of MRI');

% resize
ynew = imresize(y,size(y)*4,'bicubic');
figure;
imshow(ynew), title('x4 resize of MRI');

y1 = imnoise(ynew,'gaussian',0,0.005);   
y2 = imnoise(ynew,'gaussian',0,0.005); 
y3 = imnoise(ynew,'gaussian',0,0.005); 
y4 = imnoise(ynew,'gaussian',0,0.005); 
y5 = imnoise(ynew,'gaussian',0,0.005); 

figure, subplot(1,5,1), imshow(y1), title('noise 1');
subplot(1,5,2), imshow(y2), title('noise 2');
subplot(1,5,3), imshow(y3), title('noise 3');
subplot(1,5,4), imshow(y4), title('noise 4');
subplot(1,5,5), imshow(y5), title('noise 5');

% average
yAvg = y1/5 + y2/5 + y3/5 + y4/5 + y5/5;
figure, imshow(yAvg), title('averaged MRI')


%% exercise 2 part 1
I1 = imread('BodyMRI.png');
I2 = imread('BodyPET.png');

myImAddition(I1,I2);
myImSubtraction(I1,I2);
myImMultiplication(I1,I2);
myImComplement(I1);

function out = myImAddition(im1,im2)
    out = im1+im2;
    figure, imshow(out);
end

function out = myImSubtraction(im1,im2)
    out = im1-im2;
    figure, imshow(out);
end

function out = myImMultiplication(im1,im2)
    out = im1.*im2;
    figure, imshow(out);
end

function out = myImComplement(im1)
    out = bitcmp(im1);
    figure, imshow(out);
end