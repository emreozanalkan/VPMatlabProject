function [ image ] = ChangeColorSpace( image, srcColorSpace, destColorSpace )
%CHANGECOLORSPACE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    error('Too few arguments.');
elseif nargin < 3
    destColorSpace = 'RGB';
end

colorSpaceCommand = strcat(srcColorSpace, '->', destColorSpace);

image = colorspace(colorSpaceCommand, image);

end

