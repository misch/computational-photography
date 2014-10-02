function out = gammaTransformation(img, gamma)

imgYUV = rgb2yuv(img);

imgYUV(:,:,1) = imgYUV(:,:,1).^gamma;

out = yuv2rgb(imgYUV);