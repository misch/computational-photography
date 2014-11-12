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

%% Assignemnt 1.4 - Highlight removal
image = im2double(imread('imgs/highlightRemoval_input1.png'));
% image = imresize(image,0.25);
mask = im2double(imread('imgs/highlightRemoval_mask1.png'));
% mask = imresize(mask,0.25);
out = removeHighlights(image,mask);
figure(4);
imshow([image out]);
title('Highlight removal');