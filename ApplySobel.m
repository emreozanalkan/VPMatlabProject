function [ image ] = ApplySobel( image )
%APPLYSOBEL Summary of this function goes here
%   Detailed explanation goes here
% 'sobel'     Sobel horizontal edge-emphasizing filter
% H = fspecial('sobel') returns 3-by-3 filter that emphasizes
%     horizontal edges utilizing the smoothing effect by approximating a
%     vertical gradient. If you need to emphasize vertical edges, transpose
%     the filter H: H'.

persistent h;

if isempty(h)
   h = fspecial('sobel');
end

image = imfilter(image, h);

end

