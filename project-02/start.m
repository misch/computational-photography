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
img = hdrread('hdr-files/church.hdr');

tonemappedBilateral = tonemapBilateral(img,2,0.12,40);
tonemappedGaussian = tonemapGaussian(img,8,40);

%% Assignment 3 - Two-Scale Photographic Tone Adjustment
input = im2double(imread('imgs/toneAdjustment_sample_input.png'));
model = im2double(imread('imgs/toneAdjustment_sample_model.png'));

adjusted = adjustTone(input(:,:,1),model(:,:,1),4);
imtool(adjusted);
