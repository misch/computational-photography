function [out] = solvePoisson(target, gradient, mask)
% solvePoisson solves the poisson equation using Gauss-Seidel iterations.
% Input:
%   target:  MxN-matrix containing a grayscale target image to which the
%   gradients should be fitted
%   gradient: MxNx2-matrix containing the gradient field that should be
%   fitted to the target.
%               - x-direction (horizontal): gradient(:,:,1)
%               - y-direction (vertical):   gradient(:,:,2)
%
%   mask: MxN-matrix containing a binary mask that indicates which indicates the boundary conditions. A
%   pixel value of 1 means that the corresponding pixel value is fixed. A
%   pixel value of 0 means that the value will be found through
%   optimization (solving poisson equation)
%
%   It is assumed that target, gradient and mask have the same resolution.

out = target;

% For the unknown pixels, perform Gauss-Seidel iterations
iterations = 100;

% I and J contain the x- and y-coordinates of the pixels that are 0 in the
% mask.
[I,J] = find(mask(:,:)==0);
neighborhoodSize = 4;

h = waitbar(0,'Gauss-Seidel...');

for iter=1:iterations
    for k=1:length(I) 
        i = I(k);
        j = J(k); 
        sumFq = out(i+1,j) + out(i-1,j) + out(i,j+1) + out(i,j-1);
        sumVpq = gradient(i-1,j,2) - gradient(i,j,2) + gradient(i,j-1,1) - gradient(i,j,1);
        
        out(i,j) = (sumFq + sumVpq)/neighborhoodSize;
    end
    waitbar(iter/iterations)
end

close(h);