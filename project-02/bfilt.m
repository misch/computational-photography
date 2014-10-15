% bfilt - Bilateral Filtering
%
% out = bfilt(im, sigma_s, sigma_r) applies bilateral filtering to the gray
% scale input image im.
%
% Parameters:
%   im:         an MxN matrix representing a gray scale image
%   sigma_s:    the standard deviation of the spatial filter kernel
%   (2D gaussian)
%   sigma_r:    the standard deviation of the range kernel (1D gaussian)
function out = bfilt(im, sigma_s, sigma_r)
    kernel_size = ceil(1.5 * sigma_s);
    
    % Spatial filter kernel: 2D Gaussian
    [X_diff, Y_diff] = meshgrid(-kernel_size:kernel_size,-kernel_size:kernel_size);
    spatial_kernel = exp(-(X_diff.^2 + Y_diff.^2) / (2*sigma_s^2));
    
    out = zeros(size(im));
    
    h = waitbar(0,'Bilateral Filtering');
    for x = 1:size(im,1)
       for y = 1:size(im,2)

          % Extract the current local region
          x_min = max(x-kernel_size,1);
          x_max = min(x+kernel_size,size(im,1));  
          y_min = max(y-kernel_size,1);
          y_max = min(y+kernel_size,size(im,2));
          avg_region = im(x_min:x_max,y_min:y_max);
          
          % In case that the current pixel is too close to the image
          % boundary, the spatial kernel is cropped
          used_spatial_kernel = spatial_kernel((x_min:x_max)-x+kernel_size+1, (y_min:y_max)-y+kernel_size+1);
          
          % Range kernel: 1D Gaussian applied to difference in intensity
          range_kernel = exp(-(avg_region-im(x,y)).^2 / (2*sigma_r^2));
          
          % Combine spatial and range filter kernel to obtain the
          % bilateral filter kernel.
          bilateral_kernel = used_spatial_kernel .* range_kernel;
          
          % Apply the filter to the current pixel, normalize
          normalization = 1/sum(sum(bilateral_kernel));
          out(x,y) = sum(sum(avg_region .* bilateral_kernel  ))*normalization; 
       end
       waitbar(x/size(im,1));
    end
    close(h);