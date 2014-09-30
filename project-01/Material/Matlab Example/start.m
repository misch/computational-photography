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
img = imread('foliage_raw.tiff');

% Convert to double and normalize values to [0,1]
img = double(img)/double(max(max(img)));

figure(1);
imshow(img);
title('Input image (gray-scale)');

demosaiced = demosaicBayer(img);
figure(2);
imshow(demosaiced);
title('Bayer Demosaicing (Bilinear Filtering)');

%% Assignement 2.2
img = im2double(imread('black and white raw.tif'));

imgBayer = demosaicBayer(img);
figure(1);
imshow(imgBayer);
title('linear');

imgMedian = demosaicMedian(img, [5 5]);

figure(2);
imshow(imgMedian);
title('median');

%% Assignement 2.3


%% Assignement 2.4


%% Bonus
