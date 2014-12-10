%% Find all the files of the lightfield, put them into one huge array
% find the folder
% folder = uigetdir();
folder = 'lightfields/pink_animal/';
if ~(folder==0)
    % get the names of all image files
    searchFor = strcat(folder, '/*.png');
    dirListing = dir(searchFor);
   
    % get number of images
    numFrames = length(dirListing);
   
    fileName = fullfile(folder,dirListing(1).name);
    img1 = imread(fileName);
    images = zeros([size(img1) numFrames]);

    for frame = 1:numFrames
        fileName = fullfile(folder,dirListing(frame).name)
        images(:,:,:,frame) = im2double(imread(fileName));
    end
end
    
%% Visualize lightfields as a movie
    for frame = 1:numFrames
        F(frame) = im2frame(images(:,:,:,frame));
    end
    movie(F);

%% Show EPI's
scanlines = [400 50];
for i=1:length(scanlines)
    scanline = scanlines(i);
    permuted = permute(images,[4 2 3 1]);

    figure((i-1)*3+1);
    img = images(:,:,:,60);
    imshow(img); hold on; plot([0 size(img,2)], [scanline scanline],'r','LineWidth',1);
    title(['Row #',num2str(scanline)]);

    figure((i-1)*3+2);
    imshow(permuted(:,:,:,scanline));
    title(['EPI #',num2str(scanline)]);
end

%% Show Fourier Transforms
figure();
imshow(logPowerSpec(permuted(:,:,:,scanlines(1))));
title(['Power spectrum of EPI #',num2str(scanlines(1))]);
figure();
imshow(logPowerSpec(permuted(:,:,:,scanlines(2))));
title(['Power spectrum of EPI #',num2str(scanlines(2))]);