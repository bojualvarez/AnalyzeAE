function varargout = AnalyzeAEI(varargin)
% ANALYZEAEI MATLAB code for AnalyzeAEI.fig
%      ANALYZEAEI, by itself, creates a new ANALYZEAEI or raises the existing
%      singleton*.
%
%      H = ANALYZEAEI returns the handle to a new ANALYZEAEI or the handle to
%      the existing singleton*.
%
%      ANALYZEAEI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZEAEI.M with the given input arguments.
%
%      ANALYZEAEI('Property','Value',...) creates a new ANALYZEAEI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeAEI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeAEI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeAEI

% Last Modified by GUIDE v2.5 09-Dec-2018 17:05:22
%% Table of Contents
%   @000 High Level Flags
%   @001 Initialization
%   @002 Opening Function
%   @003 Output Function
%   @004 Load Data

%% @000 High Level Flags
%   Define high level flags that can be easily modified for changes in
%   analysis
%% @001 Initialization
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeAEI_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeAEI_OutputFcn, ...
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

%% @002 Opening Function
% --- Executes just before AnalyzeAEI is made visible.
function AnalyzeAEI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeAEI (see VARARGIN)

% Choose default command line output for AnalyzeAEI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeAEI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% @003 Output Function
% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeAEI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% @004 Load Data
% Load AE data into the workspace

% --- Executes on button press in LoadData.
function LoadData_Callback(hObject, eventdata, handles)
% hObject    handle to LoadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[HF, LF, Parms] = LoadData();


% --- Executes during object creation, after setting all properties.
function LoadData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%% @005 Filter Data