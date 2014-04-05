function [ histogram ] = CalculateHistogram( image )
%CALCULATEHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

histogram = ihist(image);

end

