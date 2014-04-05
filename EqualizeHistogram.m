function [ image ] = EqualizeHistogram( image )
%EQUALIZEHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

iDimension = size(image, 3);

if iDimension > 1
    
    image(:, :, 1) =  histeq(image(:, :, 1));
    image(:, :, 2) =  histeq(image(:, :, 2));
    image(:, :, 3) =  histeq(image(:, :, 3));
    
% HSV - Equalizing in V
%     image = rgb2hsv(image);
%     %     H=HSV(:,:,1);
%     %     S=HSV(:,:,2);
%     %     V=HSV(:,:,3);
%     
%     image(:, :, 3) = histeq(image(:, :, 3));
%     
%     image = hsv2rgb(image);
    
else
    image = histeq(image);
end

end

