%% Assignment 1.2 - Seamless cloning
source = im2double(imread('imgs/manyflyingCars.png'));
target = im2double(imread('imgs/lake.jpg'));
mask = im2double(imread('imgs/mask_manyCars.png'));

result = seamlessCloning(source,target,mask);
figure(1);
imshow([source target result]);
title('Seamless cloning');

%% Assignment 1.3 - Gradient mixing
background = im2double(imread('imgs/gradMix_background1.png'));
background = imresize(background,0.25);
foreground = im2double(imread('imgs/gradMix_foreground1.png'));
foreground = imresize(foreground,0.25);
out = gradientMixing(background,foreground);
figure(2);
imshow([background foreground out]);
title('Gradient mixing');