clear; clc; close all;

%% 1 histogram equilization
I1 = imread('Mammogram_dark.jpg');
I1 = rgb2gray(I1);
figure
subplot(221)
imagesc(I1,[0 255])
colormap(gray)
axis image, axis off

subplot(222)
imhist(I1)
axis square, grid on
ylabel('Count')
title('Histogram - Low Intensity Range')
 
I2 = imread('Mammogram_bright.jpg');
I2 = rgb2gray(I2);
subplot(223)
imagesc(I2,[0 255])
colormap(gray)
axis image, axis off

subplot(224)
imhist(I2)
axis square, grid on
ylabel('Count')
title('Histogram - High Intensity Range')

%% 2 low image intensity concentration
I1 = imread('Mammogram_dark.jpg');
I1 = rgb2gray(I1);

figure
subplot(221)
imagesc(I1,[0 255])
colormap(gray)
title('Original Image')
axis image, axis off

subplot(222)
imhist(I1)
axis square, grid on
ylabel('Count')
title('Original Histogram')

I1_eq = histeq(I1);
subplot(223)
imagesc(I1_eq,[0 255])
title('Equalized Image')
axis image, axis off

subplot(224)
imhist(I1_eq)
axis square, grid on
ylabel('Count')
title('Equalized Histogram')

%% 3 high image intensity concentration
I1 = imread('Mammogram_bright.jpg');
I1 = rgb2gray(I1);

figure
subplot(221)
imagesc(I1,[0 255])
colormap(gray)
title('Original Image')
axis image, axis off

subplot(222)
imhist(I1)
axis square, grid on
ylabel('Count')
title('Original Histogram')

I1_eq = histeq(I1);
subplot(223)
imagesc(I1_eq,[0 255])
title('Equalized Image')
axis image, axis off

subplot(224)
imhist(I1_eq)
axis square, grid on
ylabel('Count')
title('Equalized Histogram')

%% 4 histogram matching
I1 = imread('Mammogram_dark.jpg');
I1 = rgb2gray(I1);

figure
subplot(221)
imagesc(I1,[0 255])
colormap(gray)
title('Original Image')
axis image, axis off

subplot(222)
imhist(I1)
axis square, grid on
ylabel('Count')
title('Original Histogram')
 
p(1:256) = 1;
I1_eq2 = histeq(I1,p);
subplot(223), imagesc(I1_eq2,[0 255])
colormap gray, axis image, axis off
title('Equalized Image')

subplot(224), imhist(I1_eq2)
axis square, grid on
ylabel('Count')
title('Equalized Histogram')

% histogram matching
I1 = imread('Mammogram_dark.jpg');
I1 = rgb2gray(I1);
%p = manualhist;            %commented out for published page
p = twomodegauss(0.3, 0.2, 0.85, 0.01, 1, 3, 0.01);
close

figure, subplot(131), plot(p)
axis tight
title('Bimodal Function')

I1_mtch = histeq(I1,p);
subplot(132)
imhist(I1_mtch); 
title('Matched Histogram')

subplot(133)
imagesc(I1_mtch,[0 255])
colormap gray, axis image, axis off
title('Enhanced Image')

%% 5 exercise A
IA = imread("US_contrast_agent.jpg");
IA = im2gray(IA);

figure
subplot(121)
imshow(IA);
title('Original Image')

BinCount = zeros(1,256);
[m,n] = size(IA);

for i = 1:m
    for j = 1:n
        pixel_value = IA(i,j) + 1;
        BinCount(pixel_value) = BinCount(pixel_value) + 1;
    end
end

IntensityValue = linspace(0,255,256);
subplot(122)
bar(IntensityValue,BinCount)
axis([0 255 0 5000])
xlabel('Image intensity')
ylabel('Count')
title('Image Histogram')

%% 5 exercise B
IA = imread("US_contrast_agent.jpg");
IA = im2gray(IA);

figure,subplot(221)
imshow(IA)
title('Original Image')

L = 256;
BinCount = zeros(1,256);
[m,n] = size(IA);

for i = 1:m
    for j = 1:n
        pixel_value = IA(i,j) + 1;
        BinCount(pixel_value) = BinCount(pixel_value) + 1;
    end
end

subplot(222)
bar(IntensityValue,BinCount)
axis([0 255 0 5000])
xlabel('Image intensity')
ylabel('Count')
title('Image Histogram')

% CDF
sk = zeros(1,length(BinCount));
sk(1) = (L-1)*BinCount(1)/m/n;
for i = 2:length(BinCount)
    sk(i) = sum(BinCount(1:i)/m/n)*(L-1);
end

% apply CDF on image
IB = uint8(zeros(m,n));
for i = 1:m
    for j = 1:n
        pixel_value = IA(i,j) + 1;
        IB(i,j) = round(sk(pixel_value));
    end
end

subplot(223)
imshow(IB);
title('Histogram Matched Image');

% histogram of new image
BinCount = zeros(1,256);
for i = 1:m
    for j = 1:n
        pixel_value = IB(i,j) + 1;
        BinCount(pixel_value) = BinCount(pixel_value) + 1;
    end
end

subplot(224)
bar(IntensityValue,BinCount)
axis([0 255 0 5000])
xlabel('Image intensity')
ylabel('Count')
title('Image Histogram')


%% required functions
function p = manualhist
% MANUALHIST Generates a bimodal histogram interactively.
%   P = MANUALHIST generates a bimodal histogram using
%   TWOMODEGAUSS(m1, sig1, m2, sig2, A1, A2, k). m1 and m2 are the means %   of the two modes and must be in the range [0, 1]. sig1 and sig2 are    %   the standard deviations of the two modes. A1 and A2 are amplitude    %   values, and k is an offset value that raises the "floor" of the       %   histogram. The number of elements in the histogram vector P is 256    %   and sum(P) is normalized to 1. MANUALHIST repeatedly prompts for the %   parameters and plots the resulting histogram until the user types an %   'x' to quit, and then it returns the last histogram computed. A good %    set of starting values is: 0.3, 0.2, 0.85, 0.01, 1, 3, 0.01
%
% Initialize
repeats = true;
quitnow = 'x';
% Compute a default histogram in case the user quits before 
%   estimating at least one histogram.
p = twomodegauss(0.3, 0.1, 0.7, 0.1, 1, 1, 0.0);
% Cycle until an x is input.
while repeats
    s = input('Enter m1, sig1, m2, sig2, A1, A2, k OR x to quit:', 's');
    if s == quitnow
        break
    end
    % Convert the input string to a vector of numerical values and            
    % verify the number of inputs.
    v = str2num(s);
    if numel(v) ~= 7
        disp('Incorrect number of inputs.')
        continue
    end
    p = twomodegauss(v(1), v(2), v(3), v(4), v(5), v(6), v(7));
    % Start a new figure and scale the axes.  Specifying only xlim leaves  
    % ylim on auto.
    figure, plot(p)
    xlim([0 255])
end
end

function p = twomodegauss(m1, sig1, m2, sig2, A1, A2, k)
% TWOMODEGAUSS Generates a bimodal Gaussian function.
%   P = TWOMODEGAUSS(M1, SIG1, M2, SIG2, A1, A2, K) generates a bimodal, 
%   Gaussian-like function in the interval [0, 1]. P is a 256-element    %   vector normalized so that SUM(P) equals 1. The mean and standard     %   deviation of the modes are (M1, SIG1) and (M2, SIG2), respectively.    %   A1 and A2 are the amplitude values of the two modes. Since the output %   is normalized, only the relative values of A1 and A2 are important. K %   is an offset value that raises the "floor" of the function. 
 
c1 = A1*(1/((2*pi)^0.5)*sig1);
k1 = 2*(sig1^2);
c2 = A2*(1/((2*pi)^0.5)*sig2);
k2 = 2*(sig2^2);
z = linspace(0,1,256);
p = k + c1*exp(-((z-m1).^2)./k1) + c2*exp(-((z-m2).^2)./k2);
p = p./sum(p(:));

end