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
img = im2double(imread('imgs/cow.jpg'));

[fmask bmask] = getMasksFromUser(img);

% get all pixel colors in a 3 x (#pixels) array
colors = reshape(shiftdim(img,2),3,size(img,1)*size(img,2));
% get all pixel coordinates in a 2 x (#pixels) array
x = zeros(size(img,1),size(img,2),2);
[x(:,:,1) x(:,:,2)] = meshgrid(1:size(img,2),1:size(img,1));
x = reshape(shiftdim(x,2),2,size(img,1)*size(img,2));
% get the foreground and background masks in a 1 x (#pixels) array
fmask = reshape(fmask,1,size(img,1)*size(img,2));
bmask = reshape(bmask,1,size(img,1)*size(img,2));
% get the indices of the foreground and background pixels
[tt ttt findices] = intersect(x', (x.*[fmask; fmask])', 'rows');
[tt ttt bindices] = intersect(x', (x.*[bmask; bmask])', 'rows');
% extract only labeled foreground and background pixels
fcolors = colors(:,findices);
bcolors = colors(:,bindices);


% Fit Gaussian mixture model with 3 components
backgroundModel = gmdistribution.fit(bcolors',2);
foregroundModel = gmdistribution.fit(fcolors',2);

backgroundpdf = pdf(backgroundModel,reshape(img,size(img,1)*size(img,2),[]));
foregroundpdf = pdf(foregroundModel,reshape(img,size(img,1)*size(img,2),[]));

background2d = reshape(backgroundpdf,size(img,1),size(img,2));
foreground2d = reshape(foregroundpdf,size(img,1),size(img,2));
figure();
imshow([background2d foreground2d]);
title('Background- and foreground probabilities');

% Visualize mean
onlyOnes = ones(50,50,3);
meanColorB = backgroundModel.mu;
meanColorF = foregroundModel.mu;


onlyOnes = ones(100,100,3);

col1 = meanColorB(1,:);
col2 = meanColorB(2,:);

b1 = onlyOnes; b1(:,:,1) = col1(1); b1(:,:,2) = col1(2); b1(:,:,3) = col1(3);
b2 = onlyOnes; b2(:,:,1) = col2(1); b2(:,:,2) = col2(2); b2(:,:,3) = col2(3);

col1 = meanColorF(1,:);
col2 = meanColorF(2,:);

f1 = onlyOnes; f1(:,:,1) = col1(1); f1(:,:,2) = col1(2); f1(:,:,3) = col1(3);
f2 = onlyOnes; f2(:,:,1) = col2(1); f2(:,:,2) = col2(2); f2(:,:,3) = col2(3);

figure();
imshow([b1 b2]);
title('Means of background colors');

figure();
imshow([f1 f2]);
title('Means of foreground colors');
