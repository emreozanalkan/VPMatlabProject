function [ lines ] = CalculateHoughLines( image, maxLineCount, minLineLength, threshold, fillGap )
%CALCULATEHOUGHLINES Summary of this function goes here
%   Detailed explanation goes here
% maxLines
% NUMPEAKS 
%     specifies the maximum number of peaks to identify. PEAKS is 
%     a Q-by-2 matrix, where Q can range from 0 to NUMPEAKS. Q holds
%     the row and column coordinates of the peaks. If NUMPEAKS is 
%     omitted, it defaults to 1.

% threshold
% 'Threshold' Nonnegative scalar.
%                 Values of H below 'Threshold' will not be considered
%                 to be peaks. Threshold can vary from 0 to Inf.
%     
%                 Default: 0.5*max(H(:))

% FillGap
% 'FillGap'   Positive real scalar.
%                 When houghlines finds two line segments associated
%                 with the same Hough transform bin that are separated
%                 by less than 'FillGap' distance, houghlines merges
%                 them into a single line segment.
%  
%                 Default: 20
%
% MinLength
%     'MinLength' Positive real scalar.
%                 Merged line segments shorter than 'MinLength'
%                 are discarded.
%  
%                 Default: 40

if nargin < 2
    maxLineCount = 1;
    minLineLength = 40;
    threshold = 0;
    fillGap = 20;
elseif nargin < 3
    minLineLength = 40;
    threshold = 0;
    fillGap = 20;
elseif nargin < 4
    threshold = 0;
    fillGap = 20;
elseif nargin < 5
    fillGap = 20;
end

if size(image, 3) > 1
    image = im2double(image);
    image = rgb2gray(image);
end

image = edge(image, 'canny');

[H, T, R] = hough(image);

if nargin < 4
    threshold = ceil(0.5 * max(H(:)));
end

P  = houghpeaks(H, maxLineCount, 'threshold', threshold);

lines = houghlines(image, T, R, P, 'FillGap', fillGap, 'MinLength', minLineLength);

end

