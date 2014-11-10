%% Assignment 1.2 - Seamless cloning
source = im2double(imread('imgs/manyflyingCars.png'));
target = im2double(imread('imgs/lake.jpg'));
mask = im2double(imread('imgs/mask_manyCars.png'));

result = seamlessCloning(source,target,mask);
figure(1);
imshow([source target result]);
title('Seamless cloning');