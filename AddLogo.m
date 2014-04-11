function [ image ] = AddLogo( image, logo, x, y, logoWeight, logoScale )
%ADDLOGO Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    error('AddLogo: Too few arguments.');
elseif nargin < 3
    x = 1;
    y = 1;
    logoWeight = 1;
    logoScale = 0.5;
elseif nargin < 4
    y = 1;
    logoWeight = 1;
    logoScale = 0.5;
elseif nargin < 5
    logoWeight = 1;
    logoScale = 0.5;
elseif nargin < 6
    logoScale = 0.5;
end

logo = imresize(logo , logoScale); 

[iR, iC, iD] = size(image);
[lR, lC, lD] = size(logo);

if iD ~= lD
    error('AddLogo: Image dimension mismatch.');
end

x = x - 1;
y = y - 1;

if lR + x > iR || lC + y > iC
    error('AddLogo: Logo can not fit into image.');
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
            
            image(x + ii, y + jj) = ((1 - logoWeight) * image(x + ii, y + jj)) + ((logoWeight) * logo(ii, jj));
            
        end
        
    end
    
else
    
    for ii = 1 : lR
        
        for jj = 1 : lC
            
            image(x + ii, y + jj, 1) = ((1 - logoWeight) * image(x + ii, y + jj, 1)) + ((logoWeight) * logo(ii, jj, 1));
            image(x + ii, y + jj, 2) = ((1 - logoWeight) * image(x + ii, y + jj, 2)) + ((logoWeight) * logo(ii, jj, 2));
            image(x + ii, y + jj, 3) = ((1 - logoWeight) * image(x + ii, y + jj, 3)) + ((logoWeight) * logo(ii, jj, 3));
            
        end
        
    end
    
end

end

