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

logoScale = 0.5;

image = AddLogo(image, logo, x, y, logoScale);

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












