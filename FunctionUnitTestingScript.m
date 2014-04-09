% Unit Testing for Functions
close all;
clear all;
clc;
return;
%% a) Add salt and pepper noise.

image = imread('fabric.png'); % eight.tif

noiseDensity = 0.1;

image = AddSaltAndPepperNoise(image, noiseDensity);

f = figure('Name','Salt And Pepper Noise', 'NumberTitle', 'off');

imshow(image);

%% (b) Show a logo at a corner of the input (ROI).
% http://www.mathworks.com/help/images/ref/imadd.html
% https://www.youtube.com/watch?v=avrGiTMWWiE
% http://myclassbook.wordpress.com/2013/05/21/addition-of-two-images-using-matlab-image-processing/
% https://answers.yahoo.com/question/index?qid=20111222051823AAx9Gxv
% http://www.mathworks.com/matlabcentral/fileexchange/28410-watermark-project-watermarking
% http://stackoverflow.com/questions/19805318/how-to-embed-a-watermark-inside-roi-in-matlab

image = imread('fabric.png');
%image = rgb2gray(image);

logo = imread('football.jpg');
%logo = imread('logo.tif');

imshow(image);

[y, x] = ginput(1);

x = round(x);
y = round(y);

logoWeight = 0.7;
logoScale = 0.5;

% image = AddLogo(image, logo);
% image = AddLogo(image, logo, x);
% image = AddLogo(image, logo, x, y);
% image = AddLogo(image, logo, x, y, logoWeight);

image = AddLogo(image, logo, x, y, logoWeight, logoScale);

imshow(image);

%% (c) Convert to a new colorspace.
% 'RGB'	R'G'B' Red Green Blue (ITU-R BT.709 gamma-corrected)
% 'YPbPr'	Luma (ITU-R BT.601) + Chroma
% 'YCbCr'/'YCC'	Luma + Chroma ("digitized" version of Y'PbPr)
% 'YUV'	NTSC PAL Y'UV Luma + Chroma
% 'YIQ'	NTSC Y'IQ Luma + Chroma
% 'YDbDr'	SECAM Luma + Chroma
% 'JPEGYCbCr'	JPEG-Y'CbCr Luma + Chroma
% 'HSV'/'HSB'	Hue Saturation Value/Brightness
% 'HSL'/'HLS'/'HSI'	Hue Saturation Luminance/Intensity
% 'XYZ'	CIE XYZ
% 'Lab'	CIE L*a*b* (CIELAB)
% 'Luv'	CIE L*u*v* (CIELUV)
% 'Lch'	CIE L*ch (CIELCH)

image = imread('fabric.png');

srcColorSpace = 'RGB';

destColorSpace = 'HSV';

image = ChangeColorSpace(image, srcColorSpace, destColorSpace);

imshow(image);

%% (d) Compute the histogram.
close all;
clear all;
clc;

image = imread('fabric.png');
%image = rgb2gray(image);

ShowHistogram(image);

histogram = CalculateHistogram(image);

%% (e) Equalize the histogram.

image = imread('fabric.png');
%image = rgb2gray(image);

image = EqualizeHistogram(image);

imshow(image);

%% (f) Apply morphological operations (Dilate, Erode, Open, Close).

image = imread('fabric.png');

% se1 = strel('square',11)      % 11-by-11 square
% se2 = strel('line',10,45)     % length 10, angle 45 degrees
% se3 = strel('disk',15)        % disk, radius 15
% se4 = strel('ball',15,5)      % ball, radius 15, height 5
% se = strel('disk', 2);
% image = imdilate(image, se);
% image = imerode(image, se);
% image = imopen(image, se);
% image = imclose(image, se);
% image = imdilate(image, se);

% image = ApplyDilate(image);
% image = ApplyErode(image);
% image = ApplyOpen(image);
% image = ApplyClose(image);

% image = ApplyMorphology(image);
% image = ApplyMorphology(image, 'erode');
% image = ApplyMorphology(image, 'erode', 'line');
% image= ApplyMorphology(image, 'open', 'disk', 5);
image= ApplyMorphology(image, 'close', 'ball', 15);

imshow(image);

%% (g) Blur.
% average   - Averaging filter
% disk      - Circular averaging filter (pillbox)
% gaussian  - Gaussian lowpass filter
% motion    - Approximates the linear motion of a camera
% h = fspecial('average', hsize) returns an averaging filter h of size hsize. The argument hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. The default value for hsize is [3 3].
% h = fspecial('disk', radius) returns a circular averaging filter (pillbox) within the square matrix of size 2*radius+1. The default radius is 5.
% h = fspecial('gaussian', hsize, sigma) returns a rotationally symmetric Gaussian lowpass filter of size hsize with standard deviation sigma (positive). hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. The default value for hsize is [3 3]; the default value for sigma is 0.5.
% h = fspecial('motion', len, theta) returns a filter to approximate, once convolved with an image, the linear motion of a camera by len pixels, with an angle of theta degrees in a counterclockwise direction. The filter becomes a vector for horizontal and vertical motions. The default len is 9 and the default theta is 0, which corresponds to a horizontal motion of nine pixels.
% h = fspecial('average', [11 11]);
% h = fspecial('disk', 11);
% h = fspecial('gaussian', [13 13], 3);
% h = fspecial('motion', 20, 0);


image = imread('fabric.png');

% image = AddAverageBlur(image);
% image = AddDiskBlur(image);
% image = AddGaussianBlur(image);
% image = AddMotionBlur(image);

% image = AddBlur(image);
% image = AddBlur(image, 'disk');
% image = AddBlur(image, 'gaussian', 13);
image = AddBlur(image, 'motion', 20, 45);

imshow(image);


%% h) Apply Sobel and Laplacian operators.

image = imread('fabric.png');

% image = ApplySobel(image);
image = ApplyLaplacian(image);

imshow(image);

%% i) Sharpen by applying a kernel.

image = imread('fabric.png');

image = ApplySharpen(image);

imshow(image);

%% (j) Edge detection using Canny.

image = imread('fabric.png');
%image = rgb2gray(image);

threshold = 0.1; % default []
sigma = sqrt(16); % default 2

image = ApplyCannyEdge(image);
%image = ApplyCannyEdge(image, threshold, sigma);

imshow(image);

%% k) Extract lines and circles using Hough transform.
% http://www.mathworks.com/help/images/ref/hough.html
% http://www.mathworks.com/help/images/ref/houghlines.html
% http://www.mathworks.com/help/images/ref/imfindcircles.html
% Hough                          - Hough transform class
% hough                          - Hough transform.
% houghlines                     - Extract line segments based on Hough transform.
% houghpeaks                     - Identify peaks in Hough transform.
% imfindcircles                  - Find circles using Circular Hough Transform.

close all;
clear all;
clc;

% LINES
% image = imread('fabric.png');
% image = imread('circuit.tif');

image = imread('/Users/emreozanalkan/Desktop/barcode.jpg');

imshow(image);

% lines = CalculateHoughLines(image);

maxLineCount = 100;

ShowHoughLines(image, maxLineCount);


% % CIRCLES
% % radius or radius range % maybe minRadius maxRadius ?
% % 
% image = imread('tire.tif');
% 
% imshow(image);
% 
% ShowHoughCircles(image);

%% (l) Find contours of connected objects and draw them.

close all;
clear all;
clc;

image = imread('fabric.png');

imshow(image);

contourLevels = 1;

ShowContours(image, contourLevels);

%contour(image);

%% (m) Apply components' shape descriptors (bounding box, minimum en- closing circle).
% http://stackoverflow.com/questions/15251045/matlab-find-the-contour-and-straighten-a-nearly-rectangular-image
% http://stackoverflow.com/questions/15301626/choosing-isolines-from-matlab-contour-function
% http://www.mathworks.com/matlabcentral/answers/87597-rectangle-around-the-object-bounding-box
% http://www.mathworks.com/help/images/ref/regionprops.html
% http://stackoverflow.com/questions/10140068/bounding-box-using-matlab-for-the-image
% http://stackoverflow.com/questions/14447813/bounding-box-in-matlab-regionprops
% http://nf.nci.org.au/facilities/software/Matlab/toolbox/images/regionprops.html

imtool close all;
close all;
clear all;
clc;

image = imread('fabric.png');

imshow(image);

% ShowShapeDescriptors(image); % Rectangle
ShowShapeDescriptors(image, true); % Circle

%% (n) Extract corners using Harris and apply non-maximal suppression.
% http://www.mathworks.com/help/vision/ref/detectharrisfeatures.html
% http://www.mathworks.com/help/images/ref/corner.html
% http://www.csse.uwa.edu.au/~pk/research/matlabfns/Spatial/harris.m
% https://github.com/gokhanozbulak/Harris-Detector
% http://matlabcorner.wordpress.com/2012/11/17/does-harris-corner-detector-finds-corners-intuitive-explanation-to-harris-corner-detector/
% http://areshmatlab.blogspot.fr/2010/04/corner-detection-using-harris.html

close all;
clear all;
clc;

image = imread('fabric.png');

imshow(image);

maxCornerLimit = 10000;

% ShowHarrisCorners(image, maxCornerLimit);

ShowHarrisCorners(image);

%% (o) Extract FAST, SURF, and SIFT

image = imread('fabric.png');

% % FAST
% % http://www.edwardrosten.com/work/fast.html
% % http://www.mathworks.com/matlabcentral/fileexchange/13006-fast-corner-detector
% % http://www.mathworks.com/help/vision/feature-detection-extraction-and-matching.html
% % http://www.mathworks.com/help/vision/ref/detectharrisfeatures.html#btolyhy-7
% % http://matlabtricks.com/post-27/experiment-on-the-fast-corner-detector
% % http://compgroups.net/comp.soft-sys.matlab/fast-corner-detector/387318
% % http://compgroups.net/comp.soft-sys.matlab/fast-corner-detector/387318
% % http://matlabcorner.wordpress.com/2012/11/17/does-harris-corner-detector-finds-corners-intuitive-explanation-to-harris-corner-detector/
% % http://www.mathworks.com/help/vision/ref/detectfastfeatures.html
% % http://www.mathworks.com/help/vision/ref/detectsurffeatures.html
% % http://stackoverflow.com/questions/9211916/sift-implementation-in-matlab-tutorial
% % http://www.mathworks.com/matlabcentral/fileexchange/43723-sift-scale-invariant-feature-transform-algorithm
% 
% %imageGray = rgb2gray(image);
% 
% %corners = ExtractFAST(image);
% 
% imshow(image);
% 
% %hold on;
% 
% %plot(corners);
% 
% % ShowFAST(image, 10);
% ShowFAST(image);


% SURF

% imshow(image);
% 
% hold on;
% 
% ShowSURF(image, 10);


% SIFT
% http://www.mathworks.com/matlabcentral/fileexchange/43723-sift-scale-invariant-feature-transform-algorithm
% http://stackoverflow.com/questions/9211916/sift-implementation-in-matlab-tutorial
% http://robots.stanford.edu/cs223b04/project9.html
% http://www.mathworks.com/matlabcentral/fileexchange/18441-siftgpu-sift-enabled-on-gpu

imshow(image);

image = rgb2gray(image);
% SIFT NOT IMPLEMENTED
%isift(image);


%% p) Find matches between two different views.

image1 = imread('AT3_1m4_01.tif');
image2 = imread('AT3_1m4_02.tif');
%image2 = imread('AT3_1m4_03.tif');
%image2 = imread('AT3_1m4_04.tif');
%image2 = imread('AT3_1m4_05.tif');
%image2 = imread('AT3_1m4_06.tif');
%image2 = imread('fabric.png');

ShowMatches(image1, image2);









