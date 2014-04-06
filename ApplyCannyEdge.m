function [ image ] = ApplyCannyEdge( image, threshold, sigma )
%APPLYCANNYEDGE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    threshold = [];
    sigma = sqrt(2);
elseif nargin < 3
    sigma = sqrt(2);
end

if size(image, 3) > 1
    image = rgb2gray(image);
end

image = edge(image, 'canny', threshold, sigma);

end

