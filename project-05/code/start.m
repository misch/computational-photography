% Project 05

% load source and target images
source = im2double(imread('imgs/source.png'));
source = source(:,1:300,:);
target = im2double(imread('imgs/target.png'));

% sourcePoints: Nx2-matrix (N points with x- and y-coords)
% targetPoints: Nx2-matrix (N points with x- and y-coords)
% sourcePoints:
% [x1 y1
%  x2 y2
%  x3 y3]
[sourcePoints targetPoints] =  cpselect(source,target,'Wait',true);

% Get delaunay triangulation of the chosen points in the source and target
% image
delaunay_source = delaunay(sourcePoints(:,1),sourcePoints(:,2));
delaunay_target = delaunay(targetPoints(:,1),targetPoints(:,2));

% Visualize delaunay triangulation
figure(1); imshow(source); hold on; triplot(delaunay_source,sourcePoints(:,1),sourcePoints(:,2));
figure(2); imshow(target); hold on; triplot(delaunay_target,targetPoints(:,1),targetPoints(:,2));

frames = 10;

interpolated_images = zeros([size(source), frames]);
number_of_triangles = size(delaunay_source,1);


for t = 0 : 1/frames:1
    interpolated_points = (1-t)*sourcePoints + t*targetPoints;
    for triangle = 1:number_of_triangles
       idx = delaunay_source(triangle,:);

       vert1_source = sourcePoints(idx(1),:);
       vert2_source = sourcePoints(idx(2),:);
       vert3_source = sourcePoints(idx(3),:);
       
       vert1_interpolated = interpolated_points(idx(1),:);
       vert2_interpolated = interpolated_points(idx(2),:);
       vert3_interpolated = interpolated_points(idx(3),:);
       
       vert1_target = targetPoints(idx(1),:);
       vert2_target = targetPoints(idx(2),:);
       vert3_target = targetPoints(idx(3),:);
       
       % Compute bounding box
       [minBound maxBound] = getBoundingBox(vert1_interpolated,vert2_interpolated,vert3_interpolated);

% mark triangle vertices with a red '+'
figure(1); 
plot(vert2(1),vert2(2),'+r'); hold on; plot(vert3(1),vert3(2),'+r');