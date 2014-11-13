function [fmask bmask] = getMasksFromUser(image)

fmask = zeros([size(image,1) size(image,2)]);
bmask = zeros([size(image,1) size(image,2)]);
figure(1); 
imshow(image);
% Foreground
drawMoreRegions = 1;
while (drawMoreRegions>0)
    h = imfreehand(gca,'closed',true);
    setColor(h,'red');
    drawMoreRegions = input('More foreground regions? [0=no, 1=yes] ');
    fmask = fmask + createMask(h);
end

% Background
drawMoreRegions = 1;
while (drawMoreRegions>0)
    h = imfreehand(gca,'closed',true);
    setColor(h,'blue');
    drawMoreRegions = input('More background regions? [0=no, 1=yes] ');
    bmask = bmask + createMask(h);
end
close(1);