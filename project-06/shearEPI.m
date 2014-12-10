function [sheared] = shearEPI(epi,center,shear)

    sheared = zeros(size(epi));

    for i = -center+1:size(sheared,1)-center
        if (i<0)
            sheared(center+i,:,:) = rightShift(epi(center+i,:,:),-i*shear);
        else
            sheared(center+i,:,:) = leftShift(epi(center+i,:,:),i*shear);
        end
    end
end