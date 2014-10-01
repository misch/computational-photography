% Computational Photography Project 1
% Turned in by <Name>

%% Assignement 1

img = imread('imgs/calanque.jpg');
img = im2double(img);

[gray inverted] = spanishCastle(img);

figure(1);
imshow(gray);
title('Gray-scale image');

figure(2)
imshow(inverted);
title('Inverted image');

% imwrite(gray,'imgs\gray.png')
% imwrite(inverted,'imgs\inv.png')

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

medianDemosaiced = demosaicMedian(img, [5 5]);
figure(3)
imshow(medianDemosaiced);
title('5x5 Median demosaicing')

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
img = im2double(imread('interior.jpg'));

balance(img);


%% Assignement 2.4


%% Bonus
