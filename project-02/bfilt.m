function out = bfilt(im, sigma_s, sigma_r)
    kernel_size = ceil(1.5 * sigma_s);
    window_size = 2*kernel_size + 1;
    
    [X_diff, Y_diff] = meshgrid(-kernel_size:kernel_size,-kernel_size:kernel_size);
    
    spatial_kernel = exp(-(0.5/sigma_s^2)*(X_diff.^2 + Y_diff.^2)) ./ (2*pi*sigma_s^2);
    
    gauss_filtered = im;
    for x = 1:size(im,1)
       for y = 1:size(im,2)
          x_min = max(x-kernel_size,1);
          x_max = min(x+kernel_size,size(im,1));
          
          y_min = max(y-kernel_size,1);
          y_max = min(y+kernel_size,size(im,2));
          avg_region = double(im(x_min:x_max,y_min:y_max));
          used_spatial_kernel = spatial_kernel((x_min:x_max)-x+kernel_size+1, (y_min:y_max)-y+kernel_size+1);
          gauss_filtered(x,y) = sum(sum(avg_region .* used_spatial_kernel  )); 
       end
    end
out = gauss_filtered;