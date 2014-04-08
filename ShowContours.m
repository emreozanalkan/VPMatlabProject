function ShowContours( image, contourLevels )
%FINDCONTOURS Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    contourLevels = 1;
end

if size(image, 3) > 1
    image = rgb2gray(image);
end

imcontour(image, contourLevels);

end

