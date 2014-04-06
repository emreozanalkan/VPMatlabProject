function [ image ] = AddMotionBlur( image )
%ADDMOTIONBLUR Summary of this function goes here
%   Detailed explanation goes here

persistent h;

if isempty(h)
   h = fspecial('motion', 20, 0);
end

image = imfilter(image, h);

end

