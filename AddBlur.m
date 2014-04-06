function [ image ] = AddBlur( image, operation, param1, param2 )
%ADDBLUR Summary of this function goes here
%   Detailed explanation goes here
% average   - Averaging filter
% disk      - Circular averaging filter (pillbox)
% gaussian  - Gaussian lowpass filter
% motion    - Approximates the linear motion of a camera
%
% h = fspecial('average', hsize) returns an averaging filter h of size hsize. The argument hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. The default value for hsize is [3 3].
% h = fspecial('disk', radius) returns a circular averaging filter (pillbox) within the square matrix of size 2*radius+1. The default radius is 5.
% h = fspecial('gaussian', hsize, sigma) returns a rotationally symmetric Gaussian lowpass filter of size hsize with standard deviation sigma (positive). hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. The default value for hsize is [3 3]; the default value for sigma is 0.5.
% h = fspecial('motion', len, theta) returns a filter to approximate, once convolved with an image, the linear motion of a camera by len pixels, with an angle of theta degrees in a counterclockwise direction. The filter becomes a vector for horizontal and vertical motions. The default len is 9 and the default theta is 0, which corresponds to a horizontal motion of nine pixels.
%
% h = fspecial('average', [11 11]);
% h = fspecial('disk', 11);
% h = fspecial('gaussian', [13 13], 3);
% h = fspecial('motion', 20, 0);

%
if nargin < 2
    operation = 'average';
    param1 = 11;
    param2 = -1;
elseif nargin < 3
    if strcmp(operation, 'average')
        param1 = 11;
        param2 = -1;
    elseif strcmp(operation, 'disk')
        param1 = 11;
        param2 = -1;
    elseif strcmp(operation, 'gaussian')
        param1 = 13;
        param2 = 3;
    elseif strcmp(operation, 'motion')
        param1 = 20;
        param2 = 0;
    else
        error('Wrong blur operation type.');
    end
elseif nargin < 4
    if strcmp(operation, 'average')
        param2 = -1;
    elseif strcmp(operation, 'disk')
        param2 = -1;
    elseif strcmp(operation, 'gaussian')
        param2 = 3;
    elseif strcmp(operation, 'motion')
        param2 = 0;
    else
        error('Wrong blur operation type.');
    end
end


%
h = 0;

if strcmp(operation, 'average')
    h = fspecial('average', [param1 param1]);
elseif strcmp(operation, 'disk')
    h = fspecial('disk', param1);
elseif strcmp(operation, 'gaussian')
    h = fspecial('gaussian', [param1 param1], param2);
elseif strcmp(operation, 'motion')
    h = fspecial('motion', param1, param2);
else
    error('Wrong blur operation type.');
end


%
image = imfilter(image, h);


end

