function [ image ] = AddGaussianBlur( image )
%ADDGAUSSIANBLUR Summary of this function goes here
%   Detailed explanation goes here

persistent h;

if isempty(h)
   h = fspecial('gaussian', [11 11], 3);
end

image = imfilter(image, h);

end

