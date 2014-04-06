function [ image ] = ApplyErode( image )
%APPLYERODE Summary of this function goes here
%   Detailed explanation goes here

persistent se;

if isempty(se)
   se = strel('disk', 5);
end

image = imerode(image, se);

end

