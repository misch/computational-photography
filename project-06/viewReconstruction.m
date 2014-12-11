%% Linear Interpolation
% load 'pink_animal.mat';
EPIs = permute(images,[4 2 3 1]);

for k = 1:5
    finalImgSize = [size(images,1),size(images,2),size(images,3)];
    finalImg = zeros(finalImgSize);

    cameraView1 = 60;
    cameraView2 = cameraView1 + k;
    numEPIs = size(EPIs,4);
    for i = 1:numEPIs
        finalImg(i,:,:) = 0.5*(EPIs(cameraView1,:,:,i) + EPIs(cameraView2,:,:,i));
    end
    figure(k);
    imshow(finalImg);
    titleStr = sprintf('Linear Interpolation of the views %d and %d',cameraView1,cameraView2);
    title(titleStr);
%     imwrite(finalImg,sprintf('LinearInterpolation%d_%d.png',cameraView1,cameraView2));
end

%% Sheared Interpolation
shearedEPIs = zeros(size(EPIs));
center = 60;
k = 4;
shear = 20;

for nEPI = 1:size(EPIs,4)
    shearedEPIs(:,:,:,nEPI) = shearEPI(EPIs(:,:,:,nEPI),center,shear);
end

cameraView1 = center - floor(k/2);
cameraView2 = center + ceil(k/2);
numEPIs = size(EPIs,4);

for i = 1:numEPIs
    finalImg(i,:,:) = 0.5*(shearedEPIs(cameraView1,:,:,i) + shearedEPIs(cameraView2,:,:,i));
end

figure();
imshow(finalImg);
titleStr1 = sprintf('Sheared interpolation of views %d and %d',cameraView1, cameraView2);
titleStr2 = sprintf('%d pixels shear',shear);
title([{titleStr1, titleStr2}]);