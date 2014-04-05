% Unit Testing for Functions
close all;
clear all;
clc;
return;
%% Add Salt And Pepper Noise Test

image = imread('fabric.png'); % eight.tif

noiseDensity = 0.1;

image = AddSaltAndPepperNoise(image, noiseDensity);

f = figure('Name','Salt And Pepper Noise', 'NumberTitle', 'off');

imshow(image);

%% Show a logo at a corner of the input (ROI)
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

%% Convert to a new colorspace.
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
















