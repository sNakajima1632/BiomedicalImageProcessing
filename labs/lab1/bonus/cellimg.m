clear;clc;close all;

%% RGB of top left 3x3
cells = imread('cells.jpg');
%display the original image
imtool(cells);
%display the top 3x3 pixels
imtool(cells(1:3,1:3,:),'InitialMagnification','fit');

%% enhance image
%reduce atmospheric haze
cellsEnhanced = imreducehaze(cells);
imtool(cellsEnhanced);
%adjust the haze-reduced image based on RGB values
cellsEnhanced = imadjust(cellsEnhanced, [0.999 0.999 0.1; 0.9999 0.9999 0.4], []);
imtool(cellsEnhanced);

%% gray scale
%convert to gray-scale image
cellsGray = rgb2gray(cellsEnhanced);
%display only intensity from 0 to 35
imtool(cellsGray, 'DisplayRange', [0 35]);

%% threshold binary
%lowpass filter of cutoff intensity at 150
cellsGray(cellsGray > 150) = 0;
%highpass filter of cutoff intensity at 20
cellsThresh = cellsGray > 20;

imtool(cellsThresh);

%% imfuse
%only keep objects with are of more than 100 pixels
cellsBlue = bwareaopen(cellsThresh,100);
imtool(cellsBlue);

%overlay the binary blue sections onto the original image
cellsBoth = imfuse(cells,cellsBlue,'blend');
imtool(cellsBoth);