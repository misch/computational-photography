function filtered = tonemapGaussian(img, sigma, output_range)

threshold = 0.00001;
img(img<threshold)=threshold;
input_intensity = (1/61)*(img(:,:,1)*20+img(:,:,2)*40+img(:,:,3));

r = img(:,:,1)./input_intensity;
g = img(:,:,2)./input_intensity;
b = img(:,:,3)./input_intensity;
% kernel = fspecial('gaussian', ceil(1.5*sigma)*2+1,sigma);
kernel = fspecial('gaussian',21,8);
log_base = imfilter(log(input_intensity),kernel);
log_detail = log(input_intensity) - log_base;

compressionfactor = log(output_range)/(max(log_base(:))-min(log_base(:)));
log_offset = -max(log_base(:)) * compressionfactor;
log_output_intensity = log_base * compressionfactor+log_offset+log_detail;
R_output = r.*exp(log_output_intensity);
G_output = g.*exp(log_output_intensity);
B_output = b.*exp(log_output_intensity);

filtered = zeros([size(R_output) 3]);
filtered(:,:,1) = R_output;
filtered(:,:,2) = G_output;
filtered(:,:,3) = B_output;