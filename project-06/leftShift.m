function [out] = leftShift(img,pixels)

if (pixels == 0)
    out = img;
end

if (pixels > size(img,2))
   out = zeros(size(img)); 
   return;
end

out = [img(:,pixels+1:end,:) zeros(size(img,1),pixels,size(img,3))];