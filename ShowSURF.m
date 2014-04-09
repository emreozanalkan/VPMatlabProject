function ShowSURF( image, mostStrongestCount )
%SHOWSURF Summary of this function goes here
%   Detailed explanation goes here

if size(image, 3) > 1
    image = rgb2gray(image);
end

points = detectSURFFeatures(image);

if nargin > 1
    points = points.selectStrongest(mostStrongestCount);
end
    
hold on;

plot(points);

end

