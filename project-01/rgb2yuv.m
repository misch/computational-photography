function [ img_yuv ] = rgb2yuv( img_rgb )
%RGB2YUV convertes an RGB image into a YUV image

% Task:
% Convert the RGB colors to YUV color space. This is implemented by interpreting the
% RGB colors of each pixel as a column vector. You multiply the RGB vector by a spe-
% cific transformation matrix to obtain the corresponding YUV vector. You can find the
% transformation matrix here http://en.wikipedia.org/wiki/YUV. Your implementa-
% tion should avoid using a for loop over all image pixels. Instead, reorganize the input
% image such that the conversion can be done with a single matrix product that converts
% the whole image at once! Hint: Use the Matlab shiftdim and reshape functions.

% The conversion-matrix: 
% Y'                        R
% U  = conversoin_matrix  * G
% V                         B
conversion_matrix = [.299, .587, .114;
                     -.14713, -.28886, .436;
                     .615, -.51499, -.10001];

% shift dimensions such that it's easy to make a matrix out of the
% rgb-values:
% from M x N x channels ---> channels x M x N
shifted_dim = shiftdim(img_rgb,2);

% reshape the matrix such that there are always 3 numers in one column,
% perform rgb -> yuv conversion
% 
%                       r1 r2 r3 r4 ...
% conversion-matrix  *  g1 g2 g3 g4 ...
%                       b1 b2 b3 b4 ...
img_yuv = conversion_matrix * reshape(shifted_dim,3,[]);

% reshape the matrix back to the original (dimension-shifted) image
img_yuv = reshape(img_yuv, size(shifted_dim));

% shift back the dimensions
img_yuv = shiftdim(img_yuv,1);

end

