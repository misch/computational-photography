function [out] = adjustTone(input, model, detailScale)

size(input)
input_base = bfilt(input,2,0.08);
input_detail = input - input_base;

model_base = bfilt(model,2,0.08);

matched = histeq(input_base,imhist(model_base));

out = matched + detailScale * input_detail;