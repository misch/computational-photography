function [out] = rightShift(img,pixels)

if (pixels == 0)
    out = img;
end

if (pixels > size(img,2))
   out = zeros(size(img)); 
   return;
end

out = [zeros(size(img,1),pixels,size(img,3)) img(:,1:end-pixels,:)];