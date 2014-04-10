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

% Last Modified by GUIDE v2.5 10-Apr-2014 23:18:43

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
    stop(handles.myTimer);
    delete(handles.myTimer);
    stop(handles.myVideo);
    delete(handles.myVideo);
catch
    display('Error occured while cleaning up');
end

loadProblemFace(handles);

function ShowImage(~, ~, myVideo, handles)
%function ShowImage(obj, event, myVideo, handles)

trigger(myVideo);

image = getdata(myVideo, 1);

axes(handles.axesImageInput);
imshow(image);

axes(handles.axesImageOutput);
imshow(image);
