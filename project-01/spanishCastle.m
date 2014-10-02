function [grey inverted] = spanishCastle( img )
%SPANISHCASTLE creates the greyscale and inverted image of the input
%   Input
%   - img: an RGB color image
%   Output
%   - grey: the greyscale image of the inupt image
%   - inverted: the inverted color image of the input

% Convert the RGB colors to YUV color space.
img_yuv = rgb2yuv( img );

% Use the input Y channel to form the grey image.
grey = img_yuv(:,:,1);

% set Y channel to 0.6
inverted = img_yuv;
inverted(:,:,1) = 0.6;

% convert back to rgb and invert RGB colors
inverted = 1 - yuv2rgb(inverted);

end

