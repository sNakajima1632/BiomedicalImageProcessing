%% 1 How to compute and didsplay a fourier spectrum

% Create a black 30x30 image. 
f = zeros(30,30);
% Produce a white rectangle. 
f(5:24,13:17) = 1;
imshow(f,'InitialMagnification','fit')	 

% Calculate the 2D DFT. There are real and 
% imaginary parts to F, so use abs to compute
% the magnitude.
F = fft2(f); F2 = abs(F);
imshow(F2,[],'InitialMagnification','fit')	 

% To create finer sampling of the FFT, you can 
% add zeros to f. Also note we use a power of
% 2, which improves computational efficiency. 
F = fft2(f,256,256); F2 = abs(F);
imshow(F2,[],'InitialMagnification','fit')	 

% The zero-frequency coefficient is displayed
% in the upper left corner. To display in the 
% center, you can use the function fftshift. 
F2 = fftshift(F); F2 = abs(F2);
imshow(F2,[],'InitialMagnification','fit')	 

% When using the FFT, high peaks can hide 
% detail. Reduce contrast by log compression. 
F2 = log(1+F2);
imshow(F2,[],'InitialMagnification','fit')	 

%% 2 Frequency domain versions of various spatial filter types

% Create spatial filtered image 
f = imread('US_contrast_agent.jpg');
h = fspecial('sobel');
sfi = imfilter(double(f),h,0,'conv');
imshow(sfi,[]);
 	 
% abs function gets correct magnitude
% when used on complex numbers 
sfim = abs(sfi); imshow(sfim,[]);	
 	 
% Threshold into a binary image 
imshow(sfim > 0.1*max(sfim(:)));


% Create frequency filtered image
f = imread('US_contrast_agent.jpg');
h = fspecial('sobel');
PQ = paddedsize(size(f));
F = fft2(double(f),PQ(1),PQ(2)); 
H = fft2(double(h),PQ(1),PQ(2));
F_fH = H.*F; ffi = ifft2(F_fH);
ffi = ffi(2:size(f,1)+1,2:size(f,2)+1);
imshow(ffi,[])

% abs function gets correct magnitude 
% when used on complex numbers 
ffim = abs(ffi); imshow(ffim,[]);

% Threshold into a binary image 
imshow(ffim > 0.1*max(ffim(:)));

%% 3 Frequency domain specific filters

% Lowpass
% Load digital image
mri = imread('Brain_MRI_noise.tif'); 
mri = double(mri);
figure, imshow(mri,[],'InitialMagnification','fit')
 
% Zeropad the spatial image 
PQ = paddedsize(size(mri));
 
% Create a GLPF with 5.0% bandwidth of the DFT
D0 = 0.05*PQ(1);
H = lpfilter('gaussian',PQ(1),PQ(2),D0);
 
% Calculate the discrete Fourier transform of the image
F = fft2(mri,size(H,1),size(H,2)); 
 
% Apply lowpass filter to the Fourier spectrum of the image 
LPFS_mri = H.*F; 
 
% Transform result to the spatial domain 
LPF_mri = real(ifft2(LPFS_mri));
 
% Crop the image to undo padding 
LPF_mri = LPF_mri(1:size(mri,1),1:size(mri,2));
 
% Display the blurred image 
figure, imshow(LPF_mri,[],'InitialMagnification','fit')
 
% Display the Fourier spectrum after centering
Fc = fftshift(F); Fcf = fftshift(LPFS_mri); 
S1 = log(1+abs(Fc)); S2 = log(1+abs(Fcf)); 
figure, imshow(S1,[],'InitialMagnification','fit')
figure, imshow(S2,[],'InitialMagnification','fit')


% highpass
% Load digital image
mri = imread('Brain_MRI_noise.tif'); 
mri = double(mri);
figure, imshow(mri,[],'InitialMagnification','fit')
 
% Zeropad the spatial image 
PQ = paddedsize(size(mri));
 
% Create a GHPF with a 5.0% bandwidth of the Fourier transform
D0 = 0.05*PQ(1);
H = 1-lpfilter('gaussian',PQ(1),PQ(2),D0);
 
% Calculate the discrete Fourier transform of the image
F = fft2(double(mri),size(H,1),size(H,2)); 
 
% Apply the highpass filter to the Fourier spectrum of the image 
HPFS_mri = H.*F; 
 
% Transform result to the spatial domain 
HPF_mri = real(ifft2(HPFS_mri));
 
% Crop the image to undo padding 
HPF_mri = HPF_mri(1:size(mri,1),1:size(mri,2));
 
% Display the blurred image 
figure, imshow(HPF_mri,[],'InitialMagnification','fit')
 
% Display the Fourier spectrum after centering. Use abs to compute 
% the magnitude and log to brighten display 
Fc = fftshift(F); Fcf = fftshift(HPFS_mri); 
S1 = log(1+abs(Fc)); S2 = log(1+abs(Fcf)); 
figure, imshow(S1,[],'InitialMagnification','fit')
figure, imshow(S2,[],'InitialMagnification','fit') 


% notch
% Load and display the original digital image
img = imread('Mammo_BCa.tif'); img = double(img);
figure, imshow(img,[],'InitialMagnification','fit')
 
% Generate periodic noise and display the noisy image
noise = zeros(size(img));
for i = 1:size(img,2)
    noise(:,i) = mean(img(:))*sin((0:size(img,1)-1) ...
        /size(img,1)*200*pi); 
end
imgn = img + noise;
figure, imshow(imgn,[],'InitialMagnification','fit')
 
% Determine padding for Fourier transform 
PQ = paddedsize(size(imgn));
 
% Calculate the DFT of the original and noisy images
FO = fft2(img,PQ(1),PQ(2));
Fo = fftshift(FO); So = log(1+abs(Fo));
figure, imshow(So,[],'InitialMagnification','fit') 
 
FN = fft2(imgn,PQ(1),PQ(2));
Fn = fftshift(FN); Sn = log(1+abs(Fn)); 
figure, imshow(Sn,[],'InitialMagnification','fit') 
 
% Create notch filters corresponding to extra spectral bands
H1 = ones(PQ(1),PQ(2)); H2 = H1;
H1(190:210,:) = 0; H2(815:835,:) = 0; 
 
% Apply the notch filters to the noisy image 
FN_FILT = FN.*H1.*H2; 
Fn_filt = fftshift(FN_FILT);
Sf = log(1+abs(Fn_filt)); 
figure, imshow(Sf,[],'InitialMagnification','fit') 
 
% Convert the result to the spatial domain 
ImgFilt = real(ifft2(FN_FILT));
 
% Crop the image to undo padding 
ImgFilt = ImgFilt(1:size(imgn,1),1:size(imgn,2));
figure, imshow(uint8(ImgFilt),[],'InitialMagnification','fit')


%% 4 exercise

% Load and display the original digital image
img = imread('Xray_Bone_Noise.tif'); img = double(img);
figure, imshow(img,[],'InitialMagnification','fit')
title('Original image')

% Determine padding for Fourier transform 
PQ = paddedsize(size(img));
 
% Calculate the DFT of the noisy image
FN = fft2(img,PQ(1),PQ(2));
Fn = fftshift(FN); Sn = log(1+abs(Fn)); 
figure, imshow(Sn,[],'InitialMagnification','fit') 
title('Original image frequency')


% part A

% Create a GLPF with 5.0% bandwidth of the DFT
D0 = 0.05*PQ(1);
H = lpfilter('gaussian',PQ(1),PQ(2),D0);

% Apply lowpass filter to the Fourier spectrum of the image 
LPFS_bone = H.*FN; 

% Transform result to the spatial domain 
LPF_bone = real(ifft2(LPFS_bone));

% Crop the image to undo padding 
LPF_bone = LPF_bone(1:size(img,1),1:size(img,2));

% Display the blurred image 
figure, imshow(LPF_bone,[],'InitialMagnification','fit')
title('Solution to A')


% part B

% Create a GHPF with a 2.0% bandwidth of the Fourier transform
D0 = 0.02*PQ(1);
H = 1-lpfilter('gaussian',PQ(1),PQ(2),D0);

% Create a GLPF with 10.0% bandwidth of the DFT
D0 = 0.1*PQ(1);
H1 = lpfilter('gaussian',PQ(1),PQ(2),D0);

% Apply highpass+lowpass filter to the Fourier spectrum of the image 
LPFS_bone = H.*FN.*H1;
Fn_filt = fftshift(LPFS_bone);
Sf = log(1+abs(Fn_filt));
figure, imshow(Sf,[],'InitialMagnification','fit')
title('Filtered Frequency')

% Transform result to the spatial domain
LPF_bone = real(ifft2(LPFS_bone));

% Crop the image to undo padding
LPF_bone = LPF_bone(1:size(img,1),1:size(img,2));

% Display the highpass image
figure, imshow(LPF_bone,[],'InitialMagnification','fit')
title('Solution to B')
