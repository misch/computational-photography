function [out] = demosaicMedian(img, kernel_size)

% Linearly interpolate
imgBayer = demosaicBayer(img);

% Transform to YUV color space
imgYUV = rgb2yuv(imgBayer);

% Median filter U- and V-channels
uFiltered = medfilt2(imgYUV(:,:,2), kernel_size);
vFiltered = medfilt2(imgYUV(:,:,3), kernel_size);

% reshape the filtered values to a matrix
%
% u1 u2 u3 ... uN
% v1 v2 v3 ... vN
%
rowVecs = [ reshape(uFiltered,1, []); reshape(vFiltered, 1, [])];

% reshape the input image
imgReshaped = reshape(img,1,[]);

% If R-channel is known
rCoeffs = [-0.14713 0.615];
rValues = [ imgReshaped*rCoeffs(1); 
            imgReshaped*rCoeffs(2)];

B = rowVecs - rValues;
A = [-0.28886 0.436;
 -0.51499 -0.10001];

% Solution for G- and B- values can be used where R is known.
solutionRknown = A\B; % g1 g2 g3 ...
                      % b1 b2 b3 ...

% Reshape back to original image size with 2 channels
solutionRknown = reshape(shiftdim(solutionRknown,1), [size(uFiltered) 2]);
                      
% If G-channel is known
gCoeffs = [-0.28886 -0.51499];
gValues = [ imgReshaped*gCoeffs(1); 
            imgReshaped*gCoeffs(2)];

B = rowVecs - gValues;
A = [-0.14713 0.436;
      0.615 -0.10001];

% Solution for R- and B- values can be used where G is known.
solutionGknown = A\B; % r1 r2 r3 ...
                      % b1 b2 b3 ...
            
% Reshape back to original image size with 2 channels
solutionGknown = reshape(shiftdim(solutionGknown,1), [size(uFiltered) 2]);
            
% If B-channel is known
bCoeffs = [0.436; -0.10001];
bValues = [ imgReshaped*bCoeffs(1); 
            imgReshaped*bCoeffs(2)];

B = rowVecs - bValues;
A = [-0.14713 -0.28886;
      0.615 -0.51499];

% Solution for R- and G- values can be used where B is known.
solutionBknown = A\B; % r1 r2 r3 ...
                      % g1 g2 g3 ...

% Reshape back to original image size with 2 channels
solutionBknown = reshape(shiftdim(solutionBknown,1), [size(uFiltered) 2]);

% Create r-, g-, and b-mask to filter out the separate colors from the RAW 
% input
[rMask gMask bMask] = rgbMasks(size(img));

out = zeros(size(imgYUV));
out(:,:,1) = rMask .* img + gMask .* solutionGknown(:,:,1) + bMask .* solutionBknown(:,:,1);
out(:,:,2) = gMask .* img + rMask .* solutionRknown(:,:,1) + bMask .* solutionBknown(:,:,2);
out(:,:,3) = bMask .* img + rMask .* solutionRknown(:,:,2) + gMask .* solutionGknown(:,:,2);