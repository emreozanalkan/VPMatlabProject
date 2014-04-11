function ShowHistogram( image )
%SHOWHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here

persistent iHistHandle;

if isempty(iHistHandle) || ~ishandle(iHistHandle)
    iHistHandle = figure(10101010);
end

% if ~ishandle(iHistHandle)
%     iHistHandle = figure(10101010);
% end

set(0, 'currentfigure', iHistHandle);

ihist(image);

drawnow;

end

