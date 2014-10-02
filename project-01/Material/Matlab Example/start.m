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
% imwrite(img,'imgs\input.png');

demosaiced = demosaicBayer(img);
figure(2);
imshow(demosaiced);
title('Bayer Demosaicing (Bilinear Filtering)');
% imwrite(demosaiced,'imgs\demosaiced_linear.png');

%% Assignement 2.2
img = im2double(imread('black and white raw.tif'));

imgBayer = demosaicBayer(img);
figure(1);
imshow(imgBayer);
title('linear');
% imwrite(imgBayer,'imgs\black_and_white_demosaiced_linear.png');

imgMedian = demosaicMedian(img, [5 5]);

figure(2);
imshow(imgMedian);
title('median');
imwrite(imgMedian,'imgs\black_and_white_demosaiced_median_filtered.png');

%% Assignement 2.3
img = im2double(imread('interior.jpg'));

balance(img);


%% Assignement 2.4
img = im2double(imread('imgs/castle.jpg'));
img2_gray = im2double(imread('imgs/airport.jpg'));
img2 = zeros([size(img2_gray) 3]);
img2(:,:,1) = img2_gray; img2(:,:,2) = img2_gray; img2(:,:,3) = img2_gray;

contrasted = linearContrast(img2, 0.3, 0.7);
figure(1);
imshow([img2 contrasted]);
% imwrite(img2, 'imgs\linearContrast_input2.png');
% imwrite(contrasted, 'imgs\linearContrast_output2.png');

gammaCorrected = gammaTransformation(img2, 4);
figure(2);
imshow([img2 gammaCorrected]);
% imwrite(gammaCorrected, 'imgs\gammaContrast_output2.png');

% Plot
inputYUV = rgb2yuv(img2);
inputIntensity = inputYUV(:,:,1);
inputIntensity = sort(reshape(inputIntensity,[],1));

outputYUV = rgb2yuv(gammaCorrected);
outputIntensity = outputYUV(:,:,1);
outputIntensity = sort(reshape(outputIntensity,[],1));
figure(3);
plot(inputIntensity, outputIntensity);
xlabel('Input intensity'); ylabel('Output intensity');

%% Bonus
