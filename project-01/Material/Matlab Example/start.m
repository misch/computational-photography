% Computational Photography Project 1
% Turned in by <Name>

%% Assignement 1

img = imread('imgs/rainbow.png');
img = im2double(img);

[gray inverted] = spanishCastle(img);

% Please show your images with imshow (instead of imwrite) and add titles
% to the (sub)figures if there are more then one.
figure(1);
imshow(gray);
%imwrite(grey,'imgs\rainbow_gray.png')
title('Gray-scale image');

figure(2)
imshow(inverted);
%imwrite(inverted,'imgs\rainbow_inv.png')
title('Inverted image');


%% Assignement 2.1

% Proceed similarly...

%% Assignement 2.2


%% Assignement 2.3


%% Assignement 2.4


%% Bonus
