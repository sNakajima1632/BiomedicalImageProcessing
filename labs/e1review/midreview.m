clear;clc;close all;

%% q1
I = imread("kidney.tif");
I4 = imresize(I,1/4);
I8l = imresize(I4,8,"lanczos3");
I8b = imresize(I4,8,"bicubic");

figure,subplot(221);
imshow(I)
title("original")

subplot(222);
imshow(I4)
title("1/4 image")

subplot(223)
imshow(I8l)
title("2x lanczos3")

subplot(224)
imshow(I8b)
title("2x bicubic")

Itemp = imresize(I,1/4);
Itemp = imresize(Itemp,4,"lanczos3");
Ild = imsubtract(I,Itemp);

Itemp = imresize(I,1/4);
Itemp = imresize(Itemp,4,"bicubic");
I8bd = imsubtract(I,Itemp);

figure, subplot(121);
imshow(Ild)
title("lanczos3 difference")

subplot(122);
imshow(Ibd)
title("bicubic difference")

%% q2
I = imread("kidney.tif");
P = imPad_replicate(I,2,2);

figure
imshow(I)

function P = imPad_replicate(image, rows_to_pad, cols_to_pad)
    I = image;
    [m,n] = size(I);

    vertpadL = repmat(I(1:m,cols_to_pad:-1:1),1);
    vertpadR = repmat(I(1:m,n-cols_to_pad:n),1);

    P = cat(2,vertpadL,I);
    P = cat(P,vertpadR);

end