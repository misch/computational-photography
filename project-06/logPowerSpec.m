function [logPowerSpec] = logPowerSpec(img)

imgFFT = fft2(img);
centeredFFT = fftshift(imgFFT);

logPowerSpec = log(1 + centeredFFT.*conj(centeredFFT));
logPowerSpec = (logPowerSpec-min(logPowerSpec(:)))/(max(logPowerSpec(:))-min(logPowerSpec(:)));