% Project 05

% load source and target images
% source = im2double(imread('imgs/source.png'));
source = im2double(imread('imgs/rain.png'));
% source = source(:,1:300,:);
target = im2double(imread('imgs/thunder.jpg'));
target = imresize(target,[400,400]);

% sourcePoints: Nx2-matrix (N points with x- and y-coords)
% targetPoints: Nx2-matrix (N points with x- and y-coords)
% sourcePoints:
% [x1 y1
%  x2 y2
%  x3 y3]
% load('selectedPoints.mat');
[sourcePoints targetPoints] = cpselect(source,target,sourcePoints,targetPoints,'Wait',true);
% [sourcePoints targetPoints] = cpselect(source,target,'Wait',true);

% Get delaunay triangulation of the chosen points in the source image
delaunay_source = delaunay(sourcePoints(:,1),sourcePoints(:,2));

% Visualize delaunay triangulation
figure(1); imshow(source); hold on; triplot(delaunay_source,sourcePoints(:,1),sourcePoints(:,2));

frames = 20;

interpolated_images = zeros([size(source), frames]);
number_of_triangles = size(delaunay_source,1);
out_images = zeros([size(source) frames+1]);

currentFrame = 0;
for t = 0 : 1/frames:1
    currentFrame = currentFrame+1;
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
       
       % Calculate affine transformation
       source_part = [vert1_source 1; vert2_source 1; vert3_source 1]';
       interpolated_part = [vert1_interpolated 1; vert2_interpolated 1; vert3_interpolated 1]';
       target_part = [vert1_target 1; vert2_target 1; vert3_target 1]';
       T_interpolatedToSource = source_part * inv(interpolated_part);
       T_interpolatedToTarget = target_part * inv(interpolated_part);
       
       % put all pixel coordinates from the bounding box into a 2xN-matrix
       [x y] = meshgrid(minBound(1):maxBound(1),minBound(2):maxBound(2));
       pixel_coordinates = [x(:) y(:)]';
       
       % get the pixels that lie within the triangle
       mask = rasterize(interpolated_part(1:2,:),pixel_coordinates);
       pixelIndices = pixel_coordinates.*repmat(mask,2,1);
       pixelIndices = reshape(pixelIndices(pixelIndices>0),2,[]);
       
       % --> homogeneous coordinates
       pixelIndices = [pixelIndices; ones(1,size(pixelIndices,2))];
       
       % get corresponding pixels in source and target image (bilinear
       % interpolation)
       sourcePixels = T_interpolatedToSource * pixelIndices;
       targetPixels = T_interpolatedToTarget * pixelIndices;
       
       sourceCols = bilinearInterpolatedColors(source,sourcePixels);
       targetCols = bilinearInterpolatedColors(target,targetPixels);

       % blend colors
       blendedCols = (1-t)*sourceCols + t*targetCols;

       % put blended colors back to image using the above indices
       for j=1:size(pixelIndices,2)
        out_images(pixelIndices(2,j),pixelIndices(1,j),:,currentFrame) = blendedCols(:,j);
       end
    end
end

% Make movie
makeMovie = true;

if (makeMovie)
    out2 = out_images;
    out2(:,:,:,end+1:end+size(out_images,4)) = flipdim(out_images,4);
    mov = immovie(out2);
    movie2avi(mov,'morphingClouds.avi','compression','None','FPS',10);
end