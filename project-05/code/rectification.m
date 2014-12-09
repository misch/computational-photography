% Rectification
img = im2double(imread('imgs/house.png'));

figure(1);
imshow(img);

% Take bounding box of image as the rectangle
x_rect = [1 size(img,2) size(img,2) 1];
y_rect = [size(img,1) size(img,1) 1 1];

x_chosen = zeros(4,1);
y_chosen = zeros(4,1);

disp('Please choose 4 points that should be a rectangle. Start from the bottom left and go counterclock wise.');
disp('4----3');
disp('|    |');
disp('1----2');
for i = 1:4
    [x_chosen(i) y_chosen(i)] = ginput(1);
    hold on; plot(x_chosen(i), y_chosen(i),'+g','LineWidth',3);
end

% put points into nice form
chosenPoints = [x_chosen y_chosen]';
rectanglePoints = [x_rect; y_rect];

H = computeHomography(chosenPoints,rectanglePoints);
% H = inv(H);

% Compute bounding box
 minX = floor(min(chosenPoints(1,:)));
 maxX = ceil(max(chosenPoints(1,:)));
 minY = floor(min(chosenPoints(2,:)));
 maxY = ceil(max(chosenPoints(2,:)));

% put all pixel coordinates from the bounding box into a 2xN-matrix
[x y] = meshgrid(minX:maxX,minY:maxY);
pixel_coordinates = [x(:) y(:)]';

% homogeneous coords 
pixel_coordinates(3,:) = ones(1,size(pixel_coordinates,2));

transformed_points = H\pixel_coordinates;
projected_points = transformed_points ./ repmat(transformed_points(3,:),3,1);

x_proj = projected_points(1,:);
x_proj(x_proj>size(img,2)) = size(img,2);

y_proj = projected_points(2,:);
y_proj(y_proj>size(img,1)) = size(img,1);

projected_points(1,:) = x_proj;
projected_points(2,:) = y_proj;
projected_points(projected_points<1) = 1;

colors = bilinearInterpolatedColors(img,projected_points);
rectified = zeros(size(img));

for j=1:size(pixel_coordinates,2)
     rectified(pixel_coordinates(2,j),pixel_coordinates(1,j),:) = colors(:,j);
end

imtool(rectified);
