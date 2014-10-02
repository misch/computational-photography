function out = demosaicBayer( img )
% Input: M x N 2D matrix representing a color image using a Bayer pattern
%
% Output: M x N x 3 matrix representing a RGB color image. The image is
% demosaiced using Bilinear Filtering.

% Create r-, g-, and b-mask to filter out the separate colors from the RAW 
% input
[rMask gMask bMask] = rgbMasks(size(img));

% Filter out the separate color channels
red_img     = img   .* rMask;
green_img   = img   .* gMask;
blue_img    = img   .* bMask;

% Convolution of image with 3x3-matrix containing only 1's;
% Normalization (because not everywhere the same amount of non-zero pixels)
kernel = ones(3);
red_img_conv    =   conv2(red_img,kernel,'same')   ./ conv2(rMask,kernel,'same');
green_img_conv  =   conv2(green_img,kernel,'same') ./ conv2(gMask,kernel,'same');
blue_img_conv   =   conv2(blue_img,kernel,'same')  ./ conv2(bMask,kernel,'same');

% Add the interpolated color values to the holes in the image.
rNew = red_img      +  ~rMask .* red_img_conv;
gNew = green_img    +  ~gMask .* green_img_conv;
bNew = blue_img     +  ~bMask .* blue_img_conv;

% Fill the channels into the output image.
out = zeros([size(img) 3]);
out(:,:,1) = rNew; 
out(:,:,2) = gNew; 
out(:,:,3) = bNew;