function [minimum,maximum] = getBoundingBox(vert1, vert2, vert3)
% Computes a bounding box of the triangle given by vert1, vert2 and vert3
% Input:
%   vert1: 1x2-vector containing (x,y) pixel coordinates of first triangle
%   vertex
%   vert2: 1x2-vector containing (x,y) pixel coordinates of 2nd triangle
%   vertex
%   vert3: 1x2-vector containing(x,y) pixel cooridnates of 3rd triangle
%   vertex
%
% Output:
%   min: 1x2-vector containing the minimum (x,y) pixel coordinates of the
%   axis aligned bounding box
%   max: 1x2-vector containing the maximum (x,y) pixel coordinates of the
%   axis aligned bounding box
minimum = zeros(1,2);
maximum = zeros(1,2);

for i = 1:2
    minimum(i) = floor(min([vert1(i),vert2(i),vert3(i)]));
    maximum(i) = ceil(max([vert1(i),vert2(i),vert3(i)]));
end