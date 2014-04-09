function ShowMatches( image1, image2 )
%SHOWMATCHES Summary of this function goes here
%   Detailed explanation goes here

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

figure;
showMatchedFeatures(image1, image2, matchedImage1, matchedImage2, 'montage');
title('Putatively matched points (including outliers)');

end

