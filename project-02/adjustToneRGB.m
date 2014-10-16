function [out] = adjustToneRGB(input, model, detailScale)

yuv_input = rgb2yuv(input);
yuv_model = rgb2yuv(model);

y_adjusted = adjustTone(yuv_input(:,:,1),yuv_model(:,:,1),detailScale);

out = zeros(size(input));
out(:,:,1) = y_adjusted;
out(:,:,2) = yuv_input(:,:,2);
out(:,:,3) = yuv_input(:,:,3);

out = yuv2rgb(out);