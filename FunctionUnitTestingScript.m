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

% image = AddBlur(image);
% image = AddBlur(image, 'disk');
% image = AddBlur(image, 'gaussian', 13);
image = AddBlur(image, 'motion', 20, 45);

imshow(image);


%% h) Apply Sobel and Laplacian operators.

image = imread('fabric.png');







