function [ image ] = AddDiskBlur( image )
%ADDDISKBLUR Summary of this function goes here
%   Detailed explanation goes here

persistent h;

if isempty(h)
   h = fspecial('disk', 11);
end

image = imfilter(image, h);

end

