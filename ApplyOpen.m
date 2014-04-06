function [ image ] = ApplyOpen( image )
%APPLYOPEN Summary of this function goes here
%   Detailed explanation goes here

persistent se;

if isempty(se)
   se = strel('disk', 5);
end

image = imopen(image, se);

end

