function [ points ] = ExtractSURF( image, mostStrongestCount )
%EXTRACTSURF Summary of this function goes here
%   Detailed explanation goes here

if size(image, 3) > 1
    image = rgb2gray(image);
end

points = detectSURFFeatures(image);

if nargin > 1
    points = points.selectStrongest(mostStrongestCount);
end

end

