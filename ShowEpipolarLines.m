function ShowEpipolarLines( image1, image2  )
%SHOWEPIPOLARLINES Summary of this function goes here
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

[fLMedS, inliers] = estimateFundamentalMatrix(matchedImage1, matchedImage2);%, 'NumTrials', 4000);

epiLines1 = epipolarLine(fLMedS', matchedImage2(inliers, :).Location);

points1 = lineToBorderPoints(epiLines1, size(image1));

figure, imshow(image1);

hold on;

line(points1(:, [1,3])', points1(:, [2,4])');

[isIn, epipole] = isEpipoleInImage(fLMedS, size(image1));

if isIn
    plot_circle(epipole, 10, 'fillcolor', 'r', 'LineWidth', 2);
end


epiLines2 = epipolarLine(fLMedS, matchedImage1(inliers, :).Location);

points2 = lineToBorderPoints(epiLines2, size(image2));

figure, imshow(image2);

hold on;

line(points2(:, [1,3])', points2(:, [2,4])');

[isIn,epipole] = isEpipoleInImage(fLMedS, size(image2))

if isIn
    plot_circle(epipole, 10, 'fillcolor', 'r', 'LineWidth', 2);
end

truesize;

end

