function [out] = linearContrast(img,toMin, toMax)
% Changes contrast by linearly scaling the image brightness
% Input:    img - an MxNx3 matrix representing an RGB-image
%           toMin - a floating point number in [0,1] (< toMax)
%           toMax - a floating point number in [0,1] (> toMin)
%
% Output: an RGB image with linearly adjusted contrast

imgYUV = rgb2yuv(img);

% scale Y-channel to [0,1]
intervalLength = toMax - toMin;
scalingFactor = 1/intervalLength;

imgYUV(:,:,1) = imgYUV(:,:,1) - toMin;
imgYUV(:,:,1) = imgYUV(:,:,1) * scalingFactor;

out = yuv2rgb(imgYUV);