%% Assignment 2.1/2.2 - Bilateral Filtering

load jerry.mat;

sigma_s = 4;
sigma_r = 0.1;

filtered = bfilt(jerry,sigma_s,sigma_r);

figure(1);
imshow(jerry);
title('Input image');

figure(2);
imshow(filtered);
title(['Bilateral filtered: \sigma_s = ', num2str(sigma_s) , ', \sigma_s = ', num2str(sigma_r)]);
