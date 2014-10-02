function [ balanced ] = balance(img)

choice = menu('Choose balancing method','Automatic (grey world assumption)','Manual white balancing');

if (choice == 1) % Gray world assumption
    avgRGB = shiftdim(mean(mean(img)),1);
    grayValue = mean(avgRGB);
    scaleRGB = grayValue ./ avgRGB;
else
    if (choice == 2) % Manual white balancing
        whitePixel = impixel(img);
        grayValue = mean(whitePixel);
        scaleRGB = grayValue ./ whitePixel;
    end
end

% Normalization
scaleRGB = scaleRGB ./ scaleRGB(2);

balanced = img;
balanced(:,:,1) = balanced(:,:,1) * scaleRGB(1);
balanced(:,:,2) = balanced(:,:,2) * scaleRGB(2);
balanced(:,:,3) = balanced(:,:,3) * scaleRGB(3);