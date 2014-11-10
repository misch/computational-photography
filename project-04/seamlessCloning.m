function [out] = seamlessCloning(source, target, mask)
% seamlesCloning performs seamless cloning using a poisson solver.
% Input:
%   source:  MxNx3-matrix representing an RGB image that should be cut and
%   pasted to a target image.
%   target: MxNx3-matrix representing an RGB image to which the source
%   should be copied
%   mask:   MxN-matrix containing a binary mask where the region with pixel values of 0 
%           indicates the region that will be copied from source to target



out = zeros(size(target));

for i = 1:3
    gradX = imfilter(source(:,:,i), [-1 1], 'same');
    gradY = imfilter(source(:,:,i), [-1; 1], 'same');
    grad = zeros([size(gradY) 2]);
    grad(:,:,1) = gradX;
    grad(:,:,2) = gradY;
    disp(['solve poisson equation for channel ',num2str(i),'/3',' ...']);
    out(:,:,i) = solvePoisson(target(:,:,i), grad, mask);    
end