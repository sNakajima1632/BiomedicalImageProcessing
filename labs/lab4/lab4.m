clear;clc;close all;

%% 1 photographic negative
I = imread('Brain_MRI.jpg');
figure, subplot(121), imshow(I), title('Original Image')
J = imcomplement(I);
subplot(122), imshow(J), title('Photographic Negative');

%% 2 gamma transformations
x = 0:0.01:1;
g = [0.3,0.6,1,1.4,2.8];
for a = 1:length(g)
    y(:,a) = imadjust(x,[],[],g(a));
end
figure, plot(x,y)
title('gamma Transformation Functions')
xlabel('Input intensity value')
ylabel('output intensity value')
legend(['\gamma = ' num2str(g(1))],['\gamma = ' num2str(g(2))], ...
    ['\gamma = ' num2str(g(3))],['\gamma = ' num2str(g(4))], ...
    ['\gamma = ' num2str(g(5))],'Location','Northwest');
axis image, grid on

I = imread('Brain_MRI.jpg');
J1 = imadjust(I,[],[],1.0); 
figure, subplot(131), imshow(J1), title('Original, \gamma = 1')
J2 = imadjust(I,[],[],0.3); 
subplot(132), imshow(J2), title('\gamma = 0.3')
J3 = imadjust(I,[],[],2.8); 
subplot(133), imshow(J3), title('\gamma = 2.8')

%% 3 logarithmic transformations
clear;
x = 0:0.01:1;
c = [0.5,1.0,2.0,3.0];
for a = 1:length(c)
    y(:,a) = min(c(a)*log(1+x),1);
end
figure, plot(x,x), hold on, plot(x,y)
title('Logarithm Transformation Functions')
xlabel('Input intensity value')
ylabel('Output intensity value')
legend('Original',['\it c = ' num2str(c(1))],['\it c = ' num2str(c(2))],...
    ['\it c = ' num2str(c(3))],['\it c = ' num2str(c(4))],'Location','Northwest');
axis image, grid on

I = imread('Brain_MRI.jpg');
figure, subplot(221), imshow(I), title('Original')
I2 = im2double(I);
J1 = 0.5*log(1 + I2);
subplot(222), imshow(J1), title('\it c = 0.5')
J2 = 2.0*log(1 + I2);
subplot(223), imshow(J2), title('\it c = 2.0')
J3 = 3.0*log(1 + I2);
subplot(224), imshow(J3), title('\it c = 3.0')

%% 4 contrast stretching transformations
clear;
x = 0:0.01:1;
m = 0.5;
E = [2,4,6,8];
for r = 1:length(E)
    y(:,r) = 1./(1+(m./(double(x)+eps)).^E(r));
end
figure, plot(x,y)
title('Contrast Stretching Transformation Functions')
xlabel('Input intensity value')
ylabel('Output intensity value')
legend(['\it E = ' num2str(E(1))],['\it E = ' num2str(E(2))],...
    ['\it E = ' num2str(E(3))],['\it E = ' num2str(E(4))],'Location','Northwest');
axis image, grid on

I = imread('Brain_MRI.jpg');
figure, subplot(221), imshow(I), title('Original')
I2 = im2double(I);
M = mean(I2(:));
C1 = 1./(1+(M./(I2+eps)).^2);
subplot(222), imshow(C1), title('\it E = 2')
C2 = 1./(1+(M./(I2+eps)).^4);
subplot(223), imshow(C2), title('\it E = 4')
C3 = 1./(1+(M./(I2+eps)).^6);
subplot(224), imshow(C3), title('\it E = 6')

I = imread('Brain_MRI.jpg');
figure, subplot(221), imshow(I), title('Original')
I2 = im2double(I);
E = 4;
C1 = 1./(1+(0.1./(I2+eps)).^E);
subplot(222), imshow(C1), title('\it m = 0.1')
C2 = 1./(1+(0.3./(I2+eps)).^E);
subplot(223), imshow(C2), title('\it m = 0.3')
C3 = 1./(1+(0.5./(I2+eps)).^E);
subplot(224), imshow(C3), title('\it m = 0.5')


%% 5 gray level slicing
clc, clear, close all
I = imread('Brain_MRI.jpg');
%A = input('Enter a low threshold value for A: ');
A = 100;
%B = input('Enter a low threshold value for B: ');
B = 200;
[row,col] = size(I);
I2 = uint8(zeros(row,col));
for i = 1:row
    for j = 1:col
        if (I(i,j)>A) && (I(i,j)<B)
            I2(i,j) = 255;
        else
            I2(i,j) = 0;
        end
    end
end
I3 = uint8(zeros(row,col));
for i = 1:row
    for j = 1:col
        if (I(i,j)>A) && (I(i,j)<B)
            I3(i,j) = 255;
        else
            I3(i,j) = I(i,j);
        end
    end
end
figure, subplot(131), imshow(I), title('Original')
subplot(132), imshow(I2), title('Intensity Sliced w/o Background')
subplot(133), imshow(I3), title('Intensity Sliced w Background')

%% lab exercise a
clc;clear;close all;

I = imread('Xray_BoneFracture.jpg');
I = rgb2gray(I);
figure, subplot(131), imshow(I), title('Original')

% log transformation
I1 = im2double(I);
J1 = 1.25*log(1 + I1);
subplot(132), imshow(J1), title('\it c = 1.25')

% contrast stretching transformation
M = 0.9;
C1 = 1./(1+(M./(I1+eps)).^5);
subplot(133), imshow(C1), title('\it M = 0.9, E = 5')

%% lab exercise b
clc;clear;close all;

I = imread('Xray_BoneFracture.jpg');
I = rgb2gray(I);
figure, subplot(131), imshow(I), title('Original')

A = 205;
B = 225;
[row,col] = size(I);
I2 = uint8(zeros(row,col));
for i = 1:row
    for j = 1:col
        if (I(i,j)>A) && (I(i,j)<B)
            I2(i,j) = 255;
        else
            I2(i,j) = 0;
        end
    end
end
I3 = uint8(zeros(row,col));
for i = 1:row
    for j = 1:col
        if (I(i,j)>A) && (I(i,j)<B)
            I3(i,j) = 255;
        else
            I3(i,j) = I(i,j)./2;
        end
    end
end
subplot(132), imshow(I2), title('Intensity Sliced w/o Background')
subplot(133), imshow(I3), title('Intensity Sliced w Background Reduced')
