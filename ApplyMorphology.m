function [ image ] = ApplyMorphology( image, method, structuringElement, param1, param2 )
%APPLYMORPHOLOGY Summary of this function goes here
%   Detailed explanation goes here
%
% Operations
% 'dilate'
% 'erode'
% 'open'
% 'close'
% Structuring Elements
% se1 = strel('square',11)      % 11-by-11 square
% se2 = strel('line', 10, 45)     % length 10, angle 45 degrees
% se3 = strel('disk', 15)        % disk, radius 15
% se4 = strel('ball', 15, 5)      % ball, radius 15, height 5

%
if nargin < 2
    method = 'dilate';
    structuringElement = 'disk';
    param1 = 15;
    param2 = -1;
elseif nargin < 3
    structuringElement = 'disk';
    param1 = 15;
    param2 = -1;
elseif nargin < 4
    if strcmp(structuringElement, 'square')
        param1 = 11;
        param2 = -1;
    elseif strcmp(structuringElement, 'disk')
        param1 = 15;
        param2 = -1;
    elseif strcmp(structuringElement, 'line')
        param1 = 10;
        param2 = 45;
    elseif strcmp(structuringElement, 'ball')
        param1 = 15;
        param2 = 5;
    else
        error('Wrong structuring element type.');
    end
elseif nargin < 5
    if strcmp(structuringElement, 'line')
        param2 = 45;
    elseif strcmp(structuringElement, 'ball')
        param2 = 5;
    end
end


%
se = 0;

if strcmp(structuringElement, 'square') || strcmp(structuringElement, 'disk')
    se = strel(structuringElement, param1);
elseif strcmp(structuringElement, 'line') || strcmp(structuringElement, 'ball')
    se = strel(structuringElement, param1, param2);
else
    error('Wrong structuring element type.');
end


%
if strcmp(method, 'dilate')
    image = imdilate(image, se);
elseif strcmp(method, 'erode')
    image = imerode(image, se);
elseif strcmp(method, 'open')
    image = imopen(image, se);
elseif strcmp(method, 'close')
    image = imclose(image, se);
else
    error('Wrong morphological operation type.');
end


end