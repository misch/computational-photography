function [out] = bilinearInterpolatedColors(image, pixelCoordinates)
% Input:
%   image: A MxNx3-matrix representing an rgb image
%   pixelCoordinates: A 2xQ matrix with (unrounded) (x,y) pixel coordinates
%
% Output
%   out: A 3xQ matrix containing bilinearly interpolated RGB-color of the Q
%   input points

c_x = pixelCoordinates(1,:);
c_y = pixelCoordinates(2,:);

x0 = floor(c_x);
x1 = ceil(c_x);
y0 = floor(c_y);
y1 = ceil(c_y);

u = (c_x - x0);
v = (c_y - y0);

out = zeros(3,size(c_x,2));
for i = 1:size(c_x,2)
 c_1 = (1-u(i)).*image(y0(i),x0(i),:) + u(i).*image(y0(i),x1(i),:);
 c_0 = (1-u(i)).*image(y1(i),x0(i),:) + u(i)*image(y1(i),x1(i),:);
 out(:,i) = (1-v(i))*c_0 + v(i)*c_1;
%  out(:,i) = image(y0(i),x0(i));
end