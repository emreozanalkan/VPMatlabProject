function varargout = VPMatlabProject(varargin)
% VPMATLABPROJECT MATLAB code for VPMatlabProject.fig
%      VPMATLABPROJECT, by itself, creates a new VPMATLABPROJECT or raises the existing
%      singleton*.
%
%      H = VPMATLABPROJECT returns the handle to a new VPMATLABPROJECT or the handle to
%      the existing singleton*.
%
%      VPMATLABPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VPMATLABPROJECT.M with the given input arguments.
%
%      VPMATLABPROJECT('Property','Value',...) creates a new VPMATLABPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VPMatlabProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VPMatlabProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VPMatlabProject

% Last Modified by GUIDE v2.5 11-Apr-2014 16:14:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VPMatlabProject_OpeningFcn, ...
                   'gui_OutputFcn',  @VPMatlabProject_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before VPMatlabProject is made visible.
function VPMatlabProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VPMatlabProject (see VARARGIN)

clc;

% Choose default command line output for VPMatlabProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

loadProblemFace(handles);

% Add Salt And Pepper Noise
global addSaltAndPepperNoise;
global saltAndPepperNoiseDensity;
addSaltAndPepperNoise = false;
saltAndPepperNoiseDensity = 0.05;
% Add Logo
global addLogo;
global logoImage;
global logoWeight;
global logoScale;
addLogo = false;
logoImage = [];
logoWeight = 1.0;
logoScale = 0.5;
% Compute Histogram
global computeHistogram;
computeHistogram = false;
% Equalize Histogram
global equalizeHistogram;
equalizeHistogram = false;
% Morphology
global applyMorphology;
global morphologyMethod;
global morphologyStructuringElement;
global morphologyStructuringElementSize;
global morphologyStructuringElementAngleRadius;
applyMorphology = false;
morphologyMethod = 'dilate';
morphologyStructuringElement = 'disk';
morphologyStructuringElementSize = 5;
morphologyStructuringElementAngleRadius = 0;
% Add Blur
global addBlur;
global blurOperation;
global blurKernelSize;
global blurSigmaThetaSize;
addBlur = false;
blurOperation = 'disk';
blurKernelSize = 5;
blurSigmaThetaSize = 1;
% Apply Sobel and Laplacian
global applySobel;
global applyLaplacian;
applySobel = false;
applyLaplacian = false;
% Sharpen Image
global applySharpen;
global sharpenRadius;
global sharpenAmount;
global sharpenThreshold;
applySharpen = false;
sharpenRadius = 1;
sharpenAmount = 0.8;
sharpenThreshold = 0;
% Canny Edge
global applyCannyEdge;
global cannyEdgeThreshold;
applyCannyEdge = false;
cannyEdgeThreshold = 0.2;
% Hough Lines and Circles
global extractHoughLines;
global extractHoughCircles;
extractHoughLines = false;
extractHoughCircles = false;
% Find Contours
global findCountours;
findCountours = false;
% Shape descriptors
global applyBoundingBox;
global applyBoundingCircle;
applyBoundingBox = false;
applyBoundingCircle = false;
% Harris Corner
global extractHarris;
global harrisCornerCount;
extractHarris = false;
harrisCornerCount = 200;
% Extract FAST
global extractFAST;
global fastMostStrongestCount;
extractFAST = false;
fastMostStrongestCount = 10;
% Extract SURF
global extractSURF;
global surfMostStrongestCount;
extractSURF = false;
surfMostStrongestCount = 10;
% Find Matches
global findMatchesFirstImage;
global findMatchesSecondImage;
findMatchesFirstImage = [];
findMatchesSecondImage = [];
% Camera Calibration
global fundementalMatrixFirstImage;
global fundementalMatrixSecondImage;
fundementalMatrixFirstImage = [];
fundementalMatrixSecondImage = [];
% Draw Epipolar Lines
global epipolarLinesFirstImage;
global epipolarLinesSecondImage;
epipolarLinesFirstImage = [];
epipolarLinesSecondImage = [];
% Compute Homography
global homographyFirstImage;
global homographySecondImage;
homographyFirstImage = [];
homographySecondImage = [];

% UIWAIT makes VPMatlabProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function loadProblemFace(handles)

persistent problem;

if isempty(problem)
    problem = imread('problem.png');
end

axes(handles.axesImageInput);
imshow(problem);

axes(handles.axesImageOutput);
imshow(problem);

% --- Outputs from this function are returned to the command line.
function varargout = VPMatlabProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonOpenCamera.
function buttonOpenCamera_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOpenCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myVideo = 0;

try
    % For windows
    myVideo = videoinput('winvideo', 1);
catch
    try
        % For macs.
        myVideo = videoinput('macvideo', 1);
    catch
        errordlg('No webcam available');
    end
end

handles.myVideo = myVideo;
% Set parameters for video
% Acquire only one frame each time
set(myVideo,'FramesPerTrigger',1);
% Go on forever until stopped
set(myVideo,'TriggerRepeat',Inf);
% Get a grayscale image
set(myVideo, 'ReturnedColorSpace', 'rgb');
triggerconfig(myVideo, 'Manual');

% set up timer object
%TimerData=timer('TimerFcn', {@FrameRateDisplay, vid},'Period',1/NumberFrameDisplayPerSecond,'ExecutionMode','fixedRate','BusyMode','drop');
myTimer = timer('TimerFcn', {@ShowImage, myVideo, handles},'Period', 0.001,'ExecutionMode','fixedRate', 'BusyMode', 'drop');

handles.myTimer = myTimer;

% Update handles structure
guidata(hObject, handles);

try
    start(myVideo);
    pause(1);
    start(myTimer);
catch
    display('Error occured while starting camera or timer');
    stop(myTimer);
    stop(myVideo);
    delete(myTimer);
    delete(myVideo);
end


% --- Executes on button press in buttonCloseCamera.
function buttonCloseCamera_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCloseCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Clean up everything
try
    display('Cleaning up...');
    
    if ~isempty(handles.myTimer)
        stop(handles.myTimer);
        delete(handles.myTimer);
    end
    if ~isempty(handles.myVideo)
        stop(handles.myVideo);
        delete(handles.myVideo);
    end
catch
    display('Error occured while cleaning up');
end

%loadProblemFace(handles);

handles.myTimer = 0;
handles.myVideo = 0;
guidata(hObject, handles);

function ShowImage(~, ~, myVideo, handles)

trigger(myVideo);

image = getdata(myVideo, 1);

axes(handles.axesImageInput);
imshow(image);

% IMAGE PROCESSING PART

% Add Salt And Pepper Noise
global addSaltAndPepperNoise;
global saltAndPepperNoiseDensity;
% Add Logo
global addLogo;
global logoImage;
global logoWeight;
global logoScale;
% Compute Histogram
global computeHistogram;
% Equalize Histogram
global equalizeHistogram;
% Apply Morphology
global applyMorphology;
global morphologyMethod;
global morphologyStructuringElement;
global morphologyStructuringElementSize;
global morphologyStructuringElementAngleRadius;
% Add Blur
global addBlur;
global blurOperation;
global blurKernelSize;
global blurSigmaThetaSize;
% Apply Sobel and Laplacian
global applySobel;
global applyLaplacian;
% Sharpen Image
global applySharpen;
global sharpenRadius;
global sharpenAmount;
global sharpenThreshold;
% Apply Canny Edge
global applyCannyEdge;
global cannyEdgeThreshold;
% Hough Lines and Circles
global extractHoughLines;
global extractHoughCircles;
% Find Contours
global findCountours;
% Shape Descriptors
global applyBoundingBox;
global applyBoundingCircle;
% Extract Harris
global extractHarris;
global harrisCornerCount;
% Extract FAST
global extractFAST;
global fastMostStrongestCount;
% Extract SURF
global extractSURF;
global surfMostStrongestCount;


if addSaltAndPepperNoise
    image = AddSaltAndPepperNoise(image, saltAndPepperNoiseDensity);
end

if addLogo
    image = AddLogo(image, logoImage, 1, 1, logoWeight, logoScale);
end

if computeHistogram
    ShowHistogram(image);
end

if equalizeHistogram
    image = EqualizeHistogram(image);
end

if applyMorphology
    image = ApplyMorphology(image, morphologyMethod, morphologyStructuringElement, morphologyStructuringElementSize, morphologyStructuringElementAngleRadius);
end

if addBlur
    image = AddBlur(image, blurOperation, blurKernelSize, blurSigmaThetaSize);
end

if applySobel
    image = ApplySobel(image);
end

if applyLaplacian
    image = ApplyLaplacian(image);
end

if applySharpen
    image = ApplySharpen(image, sharpenRadius, sharpenAmount, sharpenThreshold);
end

if applyCannyEdge
    image = ApplyCannyEdge(image, cannyEdgeThreshold);
end

if extractHoughLines
    ShowHoughLines(image);
end

if extractHoughCircles
    ShowHoughCircles(image);
end

if findCountours
    ShowContours(image);
end

if applyBoundingBox
    ShowShapeDescriptors(image, false);
end

if applyBoundingCircle
    ShowShapeDescriptors(image, true);
end

if extractHarris
    ShowHarrisCorners(image, harrisCornerCount);
end

if extractFAST
    ShowFAST(image, fastMostStrongestCount);
end

if extractSURF
    ShowSURF(image, surfMostStrongestCount);
end

axes(handles.axesImageOutput);
imshow(image);


% --- Executes on button press in checkboxAddSaltAndPepper.
function checkboxAddSaltAndPepper_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxAddSaltAndPepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxAddSaltAndPepper
global addSaltAndPepperNoise;
global saltAndPepperNoiseDensity;

addSaltAndPepperNoise = get(handles.checkboxAddSaltAndPepper, 'Value');
saltAndPepperNoiseDensity = get(handles.sliderSaltAndPepperNoiseDensity, 'Value');


% --- Executes on slider movement.
function sliderSaltAndPepperNoiseDensity_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSaltAndPepperNoiseDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global saltAndPepperNoiseDensity;
saltAndPepperNoiseDensity = get(handles.sliderSaltAndPepperNoiseDensity, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderSaltAndPepperNoiseDensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSaltAndPepperNoiseDensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'));
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonAddLogo.
function pushbuttonAddLogo_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonAddLogo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global logoImage;

logoImage = imread(filename);


% --- Executes on button press in checkboxAddLogo.
function checkboxAddLogo_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxAddLogo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxAddLogo

global addLogo;
global logoImage;
global logoWeight;
global logoScale;

logoWeight = get(handles.sliderLogoWeight, 'Value');
logoScale = get(handles.sliderLogoScale, 'Value');

if isempty(logoImage)
    msgbox('Please select logo first');
    set(handles.checkboxAddLogo, 'Value', 0);
else
    addLogo = ~addLogo;
end


% --- Executes on slider movement.
function sliderLogoWeight_Callback(hObject, eventdata, handles)
% hObject    handle to sliderLogoWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global logoWeight;

logoWeight = get(handles.sliderLogoWeight, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderLogoWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderLogoWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderLogoScale_Callback(hObject, eventdata, handles)
% hObject    handle to sliderLogoScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global logoScale;

logoScale = get(handles.sliderLogoScale, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderLogoScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderLogoScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxComputeHistogram.
function checkboxComputeHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxComputeHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxComputeHistogram


global computeHistogram;
computeHistogram = get(handles.checkboxComputeHistogram, 'Value');


% --- Executes on button press in checkboxEqualizeHistogram.
function checkboxEqualizeHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxEqualizeHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxEqualizeHistogram

global equalizeHistogram;
equalizeHistogram = get(handles.checkboxEqualizeHistogram, 'Value');


% --- Executes on selection change in popupmenuMorphologyOperation.
function popupmenuMorphologyOperation_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuMorphologyOperation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuMorphologyOperation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuMorphologyOperation

global morphologyMethod;

val = get(hObject, 'Value');
string_list = get(hObject, 'String');
morphologyMethod = string_list{val}; % convert from cell array to 


% --- Executes during object creation, after setting all properties.
function popupmenuMorphologyOperation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuMorphologyOperation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuStructuringElement.
function popupmenuStructuringElement_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuStructuringElement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuStructuringElement contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuStructuringElement

global morphologyStructuringElement;

val = get(hObject, 'Value');
string_list = get(hObject, 'String');
morphologyStructuringElement = string_list{val}; % convert from cell array to 


% --- Executes during object creation, after setting all properties.
function popupmenuStructuringElement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuStructuringElement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxApplyMorphology.
function checkboxApplyMorphology_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApplyMorphology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApplyMorphology

global applyMorphology;
applyMorphology = get(handles.checkboxApplyMorphology, 'Value');


% --- Executes on slider movement.
function sliderAngleRadius_Callback(hObject, eventdata, handles)
% hObject    handle to sliderAngleRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global morphologyStructuringElementAngleRadius;

morphologyStructuringElementAngleRadius = floor(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderAngleRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderAngleRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSESize_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSESize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global morphologyStructuringElementSize;

morphologyStructuringElementSize = floor(get(hObject, 'Value'));

if ~mod(morphologyStructuringElementSize, 2)
    morphologyStructuringElementSize = morphologyStructuringElementSize + 1;
end


% --- Executes during object creation, after setting all properties.
function sliderSESize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSESize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxAddBlur.
function checkboxAddBlur_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxAddBlur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxAddBlur

global addBlur; 
addBlur = get(hObject, 'Value');


% --- Executes on selection change in popupmenuAddBlurOperations.
function popupmenuAddBlurOperations_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAddBlurOperations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAddBlurOperations contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAddBlurOperations

global blurOperation;

val = get(hObject, 'Value');
string_list = get(hObject, 'String');
blurOperation = string_list{val}; % convert from cell array to 


% --- Executes during object creation, after setting all properties.
function popupmenuAddBlurOperations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuAddBlurOperations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sliderBlurKernelSize_Callback(hObject, eventdata, handles)
% hObject    handle to sliderBlurKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global blurKernelSize;

blurKernelSize = floor(get(hObject, 'Value'));

if ~mod(blurKernelSize, 2)
    blurKernelSize = blurKernelSize + 1;
end




% --- Executes during object creation, after setting all properties.
function sliderBlurKernelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderBlurKernelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSigmaTheta_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSigmaTheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global blurSigmaThetaSize;

blurSigmaThetaSize = get(hObject, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderSigmaTheta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSigmaTheta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxApplySobel.
function checkboxApplySobel_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApplySobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApplySobel

global applySobel;

applySobel = get(hObject, 'Value');


% --- Executes on button press in checkboxApplyLaplacian.
function checkboxApplyLaplacian_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApplyLaplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApplyLaplacian

global applyLaplacian;

applyLaplacian = get(hObject, 'Value');


% --- Executes on button press in checkboxSharpenImage.
function checkboxSharpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxSharpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxSharpenImage

global applySharpen;

applySharpen = get(hObject, 'Value');


% --- Executes on slider movement.
function sliderSharpenRadius_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSharpenRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global sharpenRadius;

sharpenRadius = get(hObject, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderSharpenRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSharpenRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSharpeningStrength_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSharpeningStrength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global sharpenAmount;

sharpenAmount = get(hObject, 'Value');



% --- Executes during object creation, after setting all properties.
function sliderSharpeningStrength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSharpeningStrength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSharpenThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSharpenThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


global sharpenThreshold;

sharpenThreshold = get(hObject, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderSharpenThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSharpenThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxApplyCannyEdge.
function checkboxApplyCannyEdge_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApplyCannyEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApplyCannyEdge

global applyCannyEdge;

applyCannyEdge = get(hObject, 'Value');


% --- Executes on slider movement.
function sliderCannyEdgeThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCannyEdgeThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global cannyEdgeThreshold;

cannyEdgeThreshold = get(hObject, 'Value');


% --- Executes during object creation, after setting all properties.
function sliderCannyEdgeThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCannyEdgeThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxExtractHoughLines.
function checkboxExtractHoughLines_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExtractHoughLines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxExtractHoughLines

global extractHoughLines;
extractHoughLines = get(hObject, 'Value');


% --- Executes on button press in checkboxExtractHoughCircles.
function checkboxExtractHoughCircles_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExtractHoughCircles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxExtractHoughCircles

global extractHoughCircles;
extractHoughCircles = get(hObject, 'Value');


% --- Executes on button press in checkboxFindContours.
function checkboxFindContours_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFindContours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFindContours

global findCountours;
findCountours = get(hObject, 'Value');


% --- Executes on button press in checkboxBoundingBox.
function checkboxBoundingBox_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxBoundingBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxBoundingBox

global applyBoundingBox;

applyBoundingBox = get(hObject, 'Value');


% --- Executes on button press in checkboxBoundingCircle.
function checkboxBoundingCircle_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxBoundingCircle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxBoundingCircle

global applyBoundingCircle;

applyBoundingCircle = get(hObject, 'Value');


% --- Executes on button press in checkboxExtractHarrisCorners.
function checkboxExtractHarrisCorners_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExtractHarrisCorners (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxExtractHarrisCorners

global extractHarris;

extractHarris = get(hObject, 'Value');


% --- Executes on slider movement.
function sliderHarrisCornerCount_Callback(hObject, eventdata, handles)
% hObject    handle to sliderHarrisCornerCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global harrisCornerCount;

harrisCornerCount = floor(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderHarrisCornerCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderHarrisCornerCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkboxExtractFAST.
function checkboxExtractFAST_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExtractFAST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxExtractFAST

% Extract FAST
global extractFAST;

extractFAST = get(hObject, 'Value');


% --- Executes on button press in checkboxExtractSURF.
function checkboxExtractSURF_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExtractSURF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxExtractSURF

global extractSURF;

extractSURF = get(hObject, 'Value');


% --- Executes on slider movement.
function sliderFASTMostStrongestCount_Callback(hObject, eventdata, handles)
% hObject    handle to sliderFASTMostStrongestCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global fastMostStrongestCount;

fastMostStrongestCount = floor(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderFASTMostStrongestCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderFASTMostStrongestCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSURFMostStrongestCount_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSURFMostStrongestCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


global surfMostStrongestCount;

surfMostStrongestCount = floor(get(hObject, 'Value'));


% --- Executes during object creation, after setting all properties.
function sliderSURFMostStrongestCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSURFMostStrongestCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonFindMatchesFirstImage.
function pushbuttonFindMatchesFirstImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFindMatchesFirstImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global findMatchesFirstImage;

findMatchesFirstImage = imread(filename);


% --- Executes on button press in pushbuttonFindMatchesSecondImage.
function pushbuttonFindMatchesSecondImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFindMatchesSecondImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global findMatchesSecondImage;

findMatchesSecondImage = imread(filename);


% --- Executes on button press in pushbuttonFindMatches.
function pushbuttonFindMatches_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFindMatches (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global findMatchesFirstImage;
global findMatchesSecondImage;

if isempty(findMatchesFirstImage) || isempty(findMatchesSecondImage)
    msgbox('First or Second match image is empty.');
    return;
end

ShowMatches(findMatchesFirstImage, findMatchesSecondImage);


% --- Executes on button press in pushbuttonCalibrateCamera.
function pushbuttonCalibrateCamera_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalibrateCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CameraCalibration();

% --- Executes on button press in pushbuttonFundementalMatrixFirstImage.
function pushbuttonFundementalMatrixFirstImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFundementalMatrixFirstImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global fundementalMatrixFirstImage;

fundementalMatrixFirstImage = imread(filename);


% --- Executes on button press in pushbuttonFundementalMatrixSecondImage.
function pushbuttonFundementalMatrixSecondImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFundementalMatrixSecondImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global fundementalMatrixSecondImage;

fundementalMatrixSecondImage = imread(filename);


% --- Executes on button press in pushbuttonCalculateFundementalMatrix.
function pushbuttonCalculateFundementalMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCalculateFundementalMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fundementalMatrixFirstImage;
global fundementalMatrixSecondImage;

if isempty(fundementalMatrixFirstImage) || isempty(fundementalMatrixSecondImage)
    msgbox('First or Second match image is empty.');
    return;
end

F = ComputeFundementalMatrix(fundementalMatrixFirstImage, fundementalMatrixSecondImage);

display(F);


% --- Executes on button press in pushbuttonDrawEpipolarLinesFirstImage.
function pushbuttonDrawEpipolarLinesFirstImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDrawEpipolarLinesFirstImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global epipolarLinesFirstImage;

epipolarLinesFirstImage = imread(filename);

% --- Executes on button press in pushbuttonDrawEpipolarLinesSecondImage.
function pushbuttonDrawEpipolarLinesSecondImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDrawEpipolarLinesSecondImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global epipolarLinesSecondImage;

epipolarLinesSecondImage = imread(filename);


% --- Executes on button press in pushbuttonDrawEpipolarLines.
function pushbuttonDrawEpipolarLines_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDrawEpipolarLines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global epipolarLinesFirstImage;
global epipolarLinesSecondImage;

if isempty(epipolarLinesFirstImage) || isempty(epipolarLinesSecondImage)
    msgbox('First or Second match image is empty.');
    return;
end

ShowEpipolarLines(epipolarLinesFirstImage, epipolarLinesSecondImage);


% --- Executes on button press in pushbuttonHomographyFirstImage.
function pushbuttonHomographyFirstImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHomographyFirstImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global homographyFirstImage;

homographyFirstImage = imread(filename);


% --- Executes on button press in pushbuttonHomographySecondImage.
function pushbuttonHomographySecondImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHomographySecondImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, isCanceled] = imgetfile;

if isCanceled
    return;
end

global homographySecondImage;

homographySecondImage = imread(filename);


% --- Executes on button press in pushbuttonComputeHomography.
function pushbuttonComputeHomography_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonComputeHomography (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global homographyFirstImage;
global homographySecondImage;

if isempty(homographyFirstImage) || isempty(homographySecondImage)
    msgbox('First or Second match image is empty.');
    return;
end

ShowHomography(homographyFirstImage, homographySecondImage);
