function ShowShapeDescriptors( image, showAsCircle )
%SHOWSHAPEDESCRIPTORS Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    showAsCircle = false;
end

image = im2bw(image);

image = imfill(image, 'holes');

image = bwlabel(image);

hold on;

rp = regionprops(image, 'BoundingBox');

boundingBoxCount = length(rp);

for ii = 1 : boundingBoxCount
    
    if showAsCircle
        rectangle('Position', rp(ii).BoundingBox, 'Linewidth', 3, 'EdgeColor', 'r', 'Curvature', [1 1]);
    else
        rectangle('Position', rp(ii).BoundingBox, 'Linewidth', 3, 'EdgeColor', 'r');
    end
    
end

end

