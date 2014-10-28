%% Assignment 2.1/2.2 - Bilateral Filtering

load jerry.mat;

sigma_s = 4;
sigma_r = 0.1;

filtered = bfilt(jerry,sigma_s,sigma_r);

figure(1);
imshow(jerry);
title('Input image');

figure(2);
imshow(filtered);
title(['Bilateral filtered: \sigma_s = ', num2str(sigma_s) , ', \sigma_s = ', num2str(sigma_r)]);

%% Assignment 2.3/ - Tone mapping using bilateral filtering
img = hdrread('hdr-files/sunset.hdr');

tonemappedBilateral = tonemapBilateral(img,3,0.12,20);
% tonemappedGaussian = tonemapGaussian(img,5,10);

figure(1);
imshow(tonemappedBilateral);
title('Tonemapping using Bilateral and Gaussian Filtering');

%% Assignment 3 - Two-Scale Photographic Tone Adjustment
input = im2double(imread('imgs/rock.png'));
model = im2double(imread('imgs/winterstorm.png'));

adjusted = adjustTone(rgb2gray(input),rgb2gray(model),4);
adjusted2 = adjustToneRGB(input,model,4);

figure(1);
imshow(adjusted);

figure(2);
imshow(adjusted2);
