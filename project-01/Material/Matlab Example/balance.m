function [ balanced ] = balance(img)

choice = menu('Choose balancing method','Automatic (grey world assumption)','Manual white balancing');
avgRGB = shiftdim(mean(mean(img)),1);

if (choice == 1)
    grayValue = mean(avgRGB);
    scaleRGB = grayValue ./ avgRGB;
    
    scaleRGB = scaleRGB ./ scaleRGB(2);
    
    description = 'Gray world assumption';
else
    if (choice == 2)
        grayValue = mean(avgRGB);
        whitePixel = impixel(img);
        scaleRGB = grayValue ./ whitePixel;
        scaleRGB = scaleRGB ./ scaleRGB(2);
        description = 'Normalized scaling factors';
    end
end

balanced = img;
balanced(:,:,1) = balanced(:,:,1) * scaleRGB(1);
balanced(:,:,2) = balanced(:,:,2) * scaleRGB(2);
balanced(:,:,3) = balanced(:,:,3) * scaleRGB(3);

figure(2);
imshow(balanced);
title(description);