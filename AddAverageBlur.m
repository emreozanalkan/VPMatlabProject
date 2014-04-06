function [ image ] = AddAverageBlur( image )
%ADDAVERAGEBLUR Summary of this function goes here
%   Detailed explanation goes here

persistent h;

if isempty(h)
   h = fspecial('average', [11 11]);
end

image = imfilter(image, h);

end

