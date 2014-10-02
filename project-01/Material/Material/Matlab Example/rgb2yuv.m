function [ img_yuv ] = rgb2yuv( img_rgb )
%RGB2YUV convertes an RGB image into a YUV image
%   Detailed explanation goes here...



disp('rgb2yuv was called');
% Convert the RGB colors to YUV color space. This is implemented by interpreting the
% RGB colors of each pixel as a column vector. You multiply the RGB vector by a spe-
% cific transformation matrix to obtain the corresponding YUV vector. You can find the
% transformation matrix here http://en.wikipedia.org/wiki/YUV. Your implementa-
% tion should avoid using a for loop over all image pixels. Instead, reorganize the input
% image such that the conversion can be done with a single matrix product that converts
% the whole image at once! Hint: Use the Matlab shiftdim and reshape functions.

img_yuv = img_rgb;

end

