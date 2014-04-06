function [ image ] = ApplyClose( image )
%APPLYCLOSE Summary of this function goes here
%   Detailed explanation goes here

persistent se;

if isempty(se)
   se = strel('disk', 5);
end

image = imclose(image, se);

end

