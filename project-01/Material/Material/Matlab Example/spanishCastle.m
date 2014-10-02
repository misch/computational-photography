function [grey inverted] = spanishCastle( img )
%SPANISHCASTLE creates the greyscale and inverted image of the input
%   Input
%   - img: an RGB color image
%   Output
%   - grey: the greyscale image of the inupt image
%   - inverted: the invertet color image of the input



% replace the following example code with yours!
disp('spanishCastle was called');

% Convert the RGB colors to YUV color space.
img_yuv = rgb2yuv( img );

% Use the input Y channel to form the grey image.
grey = imread('imgs/castle_grey.jpg');

% To obtain the inverted image, set the Y channel to 0.6 for all pixels,
% convert back to RGB, and invert the RGB colors by taking one minus the
% RGB values. The result is the inverted image.
inverted = imread('imgs/castle_inverted.jpg');


end

