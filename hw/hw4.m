clear;clc;close all;

I = imread('HW4_TestImage.tif');
I = double(I);
% will not be padding image because the outermost border
% of image are all zeros.

%% Q1 arithmetic mean
% 3x3
h3 = ones(3,3) * 1/9;

[M,N] = size(I);
imout = zeros(M,N);

imout = imfilter(I,h3);

figure,imshow(imout)

% 7x7
h7 = ones(7,7) * 1/49;
imout = imfilter(I,h7);

figure,imshow(imout)

% 9x9
h9 = ones(9,9) * 1/81;
imout = imfilter(I,h9);

figure,imshow(imout)

%% Q2 geometric mean
% 3x3;
for i = 2:M-1
    for j = 2:N-1
        product = prod(I(i-1:i+1,j-1:j+1),'all');
        imout(i,j) = nthroot(product,9);
    end
end
figure,imshow(imout);

% 7x7
for i = 4:M-3
    for j = 4:N-3
        product = prod(I(i-3:i+3,j-3:j+3),'all');
        imout(i,j) = nthroot(product,49);
    end
end
figure,imshow(imout);

% 9x9
for i = 5:M-4
    for j = 5:N-4
        product = prod(I(i-4:i+4,j-4:j+4),'all');
        imout(i,j) = nthroot(product,81);
    end
end
figure,imshow(imout);

%% Q3 harmonic mean
% 3x3
for i = 2:M-1
    for j = 2:N-1
        numerator = prod(I(i-1:i+1,j-1:j+1),'all')*9;
        denominator = sum(I(i-1:i+1,j-1:j+1),'all');
        imout(i,j) = numerator/denominator;
    end
end
figure,imshow(imout);

% 7x7
for i = 4:M-3
    for j = 4:N-3
        numerator = prod(I(i-3:i+3,j-3:j+3),'all')*49;
        denominator = sum(I(i-3:i+3,j-3:j+3),'all');
        imout(i,j) = numerator/denominator;
    end
end
figure,imshow(imout);

% 9x9
for i = 5:M-4
    for j = 5:N-4
        numerator = prod(I(i-4:i+4,j-4:j+4),'all')*81;
        denominator = sum(I(i-4:i+4,j-4:j+4),'all');
        imout(i,j) = numerator/denominator;
    end
end
figure,imshow(imout);

%% Q1 median
% 3x3
for i = 2:M-1
    for j = 2:N-1
        I3 = I(i-1:i+1,j-1:j+1);
        imout(i,j) = median(I3(:));
    end
end
figure,imshow(imout);

% 7x7
for i = 4:M-3
    for j = 4:N-3
        I7 = I(i-3:i+3,j-3:j+3);
        imout(i,j) = median(I7(:));
    end
end
figure,imshow(imout);

% 9x9
for i = 5:M-4
    for j = 5:N-4
        I9 = I(i-4:i+4,j-4:j+4);
        imout(i,j) = median(I9(:));
    end
end
figure,imshow(imout);
