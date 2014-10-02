function [rMask gMask, bMask] = rgbMasks(size)
% Creates the R-, G- and B-Mask for RAW-images with the given input size

rMask = zeros(size);
gMask = zeros(size);
bMask = zeros(size);

rMask(1:2:end,1:2:end) = 1;

gMask(2:2:end,1:2:end) = 1;
gMask(1:2:end,2:2:end) = 1;

bMask(2:2:end,2:2:end) = 1;