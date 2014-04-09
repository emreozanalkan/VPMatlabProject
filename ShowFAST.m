function ShowFAST( image, mostStrongestCount )
%SHOWFAST Summary of this function goes here
%   Detailed explanation goes here

if size(image, 3) > 1
    image = rgb2gray(image);
end

corners = detectFASTFeatures(image);

if nargin > 1
    corners = corners.selectStrongest(mostStrongestCount);
end
    
hold on;

plot(corners);

end

