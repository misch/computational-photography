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