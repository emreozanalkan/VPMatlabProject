function [ image ] = AddSaltAndPepperNoise( image, noiseDensity )
%ADDSALTANDPEPPERNOISE Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    noiseDensity = 0.05;
end

image = imnoise(image, 'salt & pepper', noiseDensity);

end
