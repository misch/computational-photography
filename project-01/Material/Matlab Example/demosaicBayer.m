function out = demosaicBayer( img )
% Input: M x N 2D matrix representing a color image using a Bayer pattern
%
% Output: M x N x 3 matrix representing an RGB color image

% Create r-, g-, and b-mask to filter out the separate colors from the RAW
% input
rMask = zeros(size(img));
gMask = zeros(size(img));
bMask = zeros(size(img));

rMask(1:2:end,1:2:end) = 1;

gMask(2:2:end,1:2:end) = 1;
gMask(1:2:end,2:2:end) = 1;

bMask(2:2:end,2:2:end) = 1;

red_img = img .* rMask;
green_img = img .* gMask;
blue_img = img .* bMask;

conv_matrix = ones(3,3);
red_img_conv = conv2(red_img,conv_matrix,'same');
green_img_conv = conv2(green_img,conv_matrix,'same');
blue_img_conv = conv2(blue_img,conv_matrix,'same');

red_img_conv_normalized = red_img_conv ./ conv2(rMask,conv_matrix,'same');
green_img_conv_normalized = green_img_conv ./ conv2(gMask,conv_matrix,'same');
blue_img_conv_normalized = blue_img_conv ./ conv2(bMask,conv_matrix,'same');

rNew = red_img + ~rMask .* red_img_conv_normalized;
gNew = green_img + ~gMask .* green_img_conv_normalized;
bNew = blue_img + ~bMask .* blue_img_conv_normalized;

img_new1 = zeros([size(img) 3]);
img_new2 = img_new1;
% img_new(:,:,1) = red_img; img_new(:,:,2) = green_img; img_new(:,:,3) = blue_img;
% img_new(:,:,1) = red_img_conv; img_new(:,:,2) = green_img_conv; img_new(:,:,3) = blue_img_conv;
img_new1(:,:,1) = red_img_conv_normalized; img_new1(:,:,2) = green_img_conv_normalized; img_new1(:,:,3) = blue_img_conv_normalized;
img_new2(:,:,1) = rNew; img_new2(:,:,2) = gNew; img_new2(:,:,3) = bNew;
imtool(img_new2);

out = zeros([size(img) 3]);