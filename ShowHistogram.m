function ShowHistogram( image )
%SHOWHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

persistent iHistHandle;

if isempty(iHistHandle) 
    iHistHandle = figure(10101010);
end

set(0, 'currentfigure', iHistHandle);

ihist(image);

end

