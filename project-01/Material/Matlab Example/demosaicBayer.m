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

imtool(red_img);
out = zeros([size(img) 3]);