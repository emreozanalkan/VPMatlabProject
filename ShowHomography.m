function ShowHomography( image1, image2 )
%SHOWHOMOGRAPHY Summary of this function goes here
%   Detailed explanation goes here

image1O = image1;
image2O = image2;

if size(image1, 3) > 1
    image1 = rgb2gray(image1);
end

if size(image2, 3) > 1
    image2 = rgb2gray(image2);
end

pointsImage1  = detectSURFFeatures(image1);
pointsImage2 = detectSURFFeatures(image2);

[featuresImage1,   validPointsImage1]  = extractFeatures(image1,  pointsImage1);
[featuresImage2, validPointsImage2]  = extractFeatures(image2, pointsImage2);

indexPairs = matchFeatures(featuresImage1, featuresImage2);

matchedImage1  = validPointsImage1(indexPairs(:, 1));
matchedImage2 = validPointsImage2(indexPairs(:, 2));

if length(matchedImage1) < 4 || length(matchedImage2) < 4
    error('Not enough match to find homograhpy :(');
end


% Rest of the code is written by Abinash Pant.
% -- Abinash Pant --

% [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedImage2, matchedImage1, 'projective');
% figure; showMatchedFeatures(image1, image2, matchedImage1, matchedImage2, 'montage');
% title('Matched inlier points');

o = image1O;
ao = image2O;
I = image1;

tx = estimateGeometricTransform(matchedImage1, matchedImage2, 'projective');

tao = [ao zeros(size(ao))];

aoo =  imref2d(size(tao)); 

ooo = imwarp(o, tx, 'OutputView', aoo);

mask = imwarp(ones(size(I)), tx , 'OutputView', aoo) >= 1;

%figure(s.MatchFig);

blend = vision.AlphaBlender('Operation', 'Binary mask', 'MaskSource', 'Input port');

mosaic = step(blend, tao, ooo, mask);

figure, imshow(mosaic);

% -- Abinash Pant --

end

