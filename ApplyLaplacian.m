function [ image ] = ApplyLaplacian( image )
%APPLYLAPLACIAN Summary of this function goes here
%   Detailed explanation goes here
% 'laplacian' filter approximating the 2-D Laplacian operator
%  H = fspecial('laplacian',ALPHA) returns a 3-by-3 filter
%     approximating the shape of the two-dimensional Laplacian
%     operator. The parameter ALPHA controls the shape of the
%     Laplacian and must be in the range 0.0 to 1.0.
%     The default ALPHA is 0.2.
% H = fspecial('log',HSIZE,SIGMA) returns a rotationally symmetric
%     Laplacian of Gaussian filter of size HSIZE with standard deviation
%     SIGMA (positive). HSIZE can be a vector specifying the number of rows
%     and columns in H or a scalar, in which case H is a square matrix.
%     The default HSIZE is [5 5], the default SIGMA is 0.5.

persistent h;

if isempty(h)
   h = fspecial('laplacian');
end

image = imfilter(image, h);

end

