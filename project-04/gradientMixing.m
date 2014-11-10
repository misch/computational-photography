function [out] = gradientMixing(background, foreground)
% gradientMixing performs gradient mixing using a poisson solver
% Input:
%   background: An MxNx3-matrix representing an RGB image that should be in
%   the background.
%   foreground: An MxNx3-matrix representing an RGB image that should be in
%   the foreground.

out = zeros(size(background));

mask = zeros([size(background,1) size(background,2)]);
mask(1:end,[1 end]) = 1;
mask([1 end], 1:end) = 1;

for i = 1:3
    gradXbackground = imfilter(background(:,:,i), [-1 1], 'same');
    gradYbackground = imfilter(background(:,:,i), [-1; 1], 'same');
    
    gradXforeground = imfilter(foreground(:,:,i), [-1 1], 'same');
    gradYforeground = imfilter(foreground(:,:,i), [-1; 1], 'same');

    
    gradX = zeros(size(gradXforeground));
    gradY = zeros(size(gradYforeground));
   
    gradX(abs(gradXbackground)>abs(gradXforeground)) = gradXbackground(abs(gradXbackground)>abs(gradXforeground));
    gradX(abs(gradXbackground)<=abs(gradXforeground)) = gradXforeground(abs(gradXbackground)<=abs(gradXforeground));
    
    gradY(abs(gradYbackground)>abs(gradYforeground)) = gradYbackground(abs(gradYbackground)>abs(gradYforeground));
    gradY(abs(gradYbackground)<=abs(gradYforeground)) = gradYforeground(abs(gradYbackground)<=abs(gradYforeground));
    
    grad = zeros([size(gradYforeground) 2]);
    grad(:,:,1) = gradX;
    grad(:,:,2) = gradY;

    out(:,:,i) = solvePoisson(background(:,:,i), grad, mask); 
end
    
    
    