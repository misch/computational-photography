function [out] = computeHomography(pointSet1, pointSet2)
% Input
%   pointSet1: A 2x4 matrix containing (x,y)-pixel coordinates of 4 points
%   pointSet2: A 2x4 matrix containing (x,y)-pixel coordinates of 4 points
%
% Output
%   out: a 3x3 matrix that represents the homography that maps pointSet1 to
%   pointSet2

out = zeros(3);

u_constraints = [-pointSet1; -ones(1,4); zeros(3,4); repmat(pointSet2(1,:),2,1).*pointSet1; pointSet2(1,:)]';
v_constraints = [zeros(3,4); -pointSet1; -ones(1,4); repmat(pointSet2(2,:),2,1).*pointSet1; pointSet2(2,:)]';

A = [u_constraints; v_constraints; zeros(1,8) 1];
size(A)
b = [zeros(8,1);1];

H = A\b;

out = reshape(H,3,3)';