function [ image ] = ApplySharpen( image, radius, amount, threshold )
%APPLYSHARPEN Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    radius = 1;
    amount = 0.8;
    threshold = 0;
elseif nargin < 3
    amount = 0.8;
    threshold = 0;
elseif nargin < 4
    threshold = 0;
end

% persistent h;
% 
% if isempty(h)
%    h = fspecial('unsharp', 0.05);
% end
% 
% 
% image = imfilter(image, h);

image = imsharpen(image, 'Radius', radius, 'Amount', amount, 'Threshold', threshold);

end

