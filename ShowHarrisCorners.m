function ShowHarrisCorners( image, cornerCountLimit )
%SHOWHARRISCORNERS Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
   cornerCountLimit = 200; 
end

if size(image, 3) > 1
    image = rgb2gray(image);
end

corners = corner(image, 'Harris', cornerCountLimit);

hold on;

plot(corners(:, 1), corners(:, 2), 'r*');

end

