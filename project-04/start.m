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

%% Assignment 2.1 - Interface
image = im2double(imread('imgs/highlightRemoval_input1.png'));
fmask = zeros([size(image,1) size(image,2)]);
bmask = zeros([size(image,1) size(image,2)]);

figure(1); 
imshow(image);

% Foreground
drawMoreRegions = 1;
while (drawMoreRegions>0)
    h = imfreehand(gca,'closed',true);
    setColor(h,'red');
    drawMoreRegions = input('More foreground regions? [0=no, 1=yes] ');
    fmask = fmask + createMask(h);
end

% Background
drawMoreRegions = 1;
while (drawMoreRegions>0)
    h = imfreehand(gca,'closed',true);
    setColor(h,'blue');
    drawMoreRegions = input('More background regions? [0=no, 1=yes] ');
    bmask = bmask + createMask(h);
end
close(1);
