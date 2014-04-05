function [ image ] = AddLogo( image, logo, x, y, logoScale )
%ADDLOGO Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    error('Too few arguments.');
elseif nargin < 3
    x = 1;
    y = 1;
    logoScale = 0.5;
elseif nargin < 4
    y = 1;
    logoScale = 0.5;
elseif nargin < 5
    logoScale = 0.5;
end

logo = imresize(logo , logoScale); 

[iR, iC, iD] = size(image);
[lR, lC, lD] = size(logo);

if iD ~= lD
    error('Image dimension mismatch.');
end

x = x - 1;
y = y - 1;

if lR + x > iR || lC + y > iC
    error('Logo can not fit into image.');
end

if isa(logo, 'logical')
    if isa(image, 'double')
        logo = im2double(logo);
    elseif isa(image, 'uint8')
        logo = im2uint8(logo);
    end
end

if iD == 1
    
    for ii = 1 : lR
        
        for jj = 1 : lC
            
            image(x + ii, y + jj) = logo(ii, jj);
            
        end
        
    end
    
else
    
    for ii = 1 : lR
        
        for jj = 1 : lC
            
            image(x + ii, y + jj, 1) = logo(ii, jj, 1);
            image(x + ii, y + jj, 2) = logo(ii, jj, 2);
            image(x + ii, y + jj, 3) = logo(ii, jj, 3);
            
        end
        
    end
    
end

end

