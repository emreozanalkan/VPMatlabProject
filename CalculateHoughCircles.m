function [ centers, radii ] = CalculateHoughCircles( image, radius )
%CALCULATEHOUGHCIRCLES Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    radius = [15 45];
end

if length(radius) < 2
    radius = [radius 3 * radius];
end

[centers, radii] = imfindcircles(image, radius);

end

