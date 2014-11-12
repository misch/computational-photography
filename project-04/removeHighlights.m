function [out] = removeHighlights(image,mask)
% removeHighlights compresses highlights using a poisson solver.
% Input:
%   image:  MxNx3-matrix representing an RGB image that contains an
%   undesired highlight
%   mask:   MxN-matrix containing a binary mask where the region with pixel values of 0 
%           indicates the region that will be compressed

out = zeros(size(image));
alpha = 0.005;
beta = 0.4;
image = log(image);
threshold = 1e-6;
for i = 1:3
    gradX = imfilter(image(:,:,i), [-1 1], 'same');
    gradY = imfilter(image(:,:,i), [-1; 1], 'same');
    grad = zeros([size(gradY) 2]);
    grad(:,:,1) = gradX;
    grad(:,:,2) = gradY;
    
    gradient_magnitude = sqrt(grad(:,:,1).^2 + grad(:,:,2).^2);

    gradient_magnitude(gradient_magnitude<threshold) = threshold;
    
    compressed = zeros(size(grad));
    compressed(:,:,1) = alpha^beta * (gradient_magnitude.^(-beta) .* grad(:,:,1));
    compressed(:,:,2) = alpha^beta * (gradient_magnitude.^(-beta) .* grad(:,:,2));
    
    disp(['solve poisson equation for channel ',num2str(i),'/3',' ...']);
    out(:,:,i) = solvePoisson(image(:,:,i), compressed, mask);    
end
out = exp(out);
end