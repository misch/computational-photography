function out = tonemapBilateral(img, sigma_s, sigma_r, output_range)

threshold = 1e-5;
img(img<threshold)=threshold;
input_intensity = (1/61)*(img(:,:,1)*20+img(:,:,2)*40+img(:,:,3));

r = img(:,:,1)./input_intensity;
g = img(:,:,2)./input_intensity;
b = img(:,:,3)./input_intensity;

log_base = bfilt(log(input_intensity),sigma_s, sigma_r);
log_detail = log(input_intensity) - log_base;
imtool(exp(log_detail));

compressionfactor = log(output_range)/(max(log_base(:))-min(log_base(:)));
log_offset = -max(log_base(:)) * compressionfactor;
log_output_intensity = log_base * compressionfactor+log_offset+log_detail;
R_output = r.*exp(log_output_intensity);
G_output = g.*exp(log_output_intensity);
B_output = b.*exp(log_output_intensity);

out = zeros([size(R_output) 3]);
out(:,:,1) = R_output;
out(:,:,2) = G_output;
out(:,:,3) = B_output;