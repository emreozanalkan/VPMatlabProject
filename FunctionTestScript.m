% Unit Testing for Functions

%% Add Salt And Pepper Noise Test

image = imread('fabric.png'); % imread('eight.tif');

noiseDensity = 0.1;

image = AddSaltAndPepperNoise(image, noiseDensity);

f = figure('Name','Salt And Pepper Noise', 'NumberTitle', 'off');

imshow(image);

%% 

%%