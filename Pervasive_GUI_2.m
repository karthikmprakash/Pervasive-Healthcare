function varargout = Pervasive_GUI_2(varargin)
% PERVASIVE_GUI_2 MATLAB code for Pervasive_GUI_2.fig
%      PERVASIVE_GUI_2, by itself, creates a new PERVASIVE_GUI_2 or raises the existing
%      singleton*.
%
%      H = PERVASIVE_GUI_2 returns the handle to a new PERVASIVE_GUI_2 or the handle to
%      the existing singleton*.
%
%      PERVASIVE_GUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERVASIVE_GUI_2.M with the given input arguments.
%
%      PERVASIVE_GUI_2('Property','Value',...) creates a new PERVASIVE_GUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pervasive_GUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pervasive_GUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pervasive_GUI_2

% Last Modified by GUIDE v2.5 22-Jun-2017 16:20:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pervasive_GUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Pervasive_GUI_2_OutputFcn, ...
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


% --- Executes just before Pervasive_GUI_2 is made visible.
function Pervasive_GUI_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pervasive_GUI_2 (see VARARGIN)

% Choose default command line output for Pervasive_GUI_2
handles.output = hObject;
% handles.initial_parameter=varargin{1};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pervasive_GUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pervasive_GUI_2_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
clear all;
clc;
global a b;
a=arduino('COM4','Uno');
% b=arduino('COM3','Mega2560');




function NameTag_Callback(hObject, eventdata, handles)
global Name;
Name=get(handles.NameTag,'String');
assignin('base','Name',Name);
guidata(hObject, handles);
function NameTag_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radiobutton1_Callback(hObject, eventdata, handles)
first1=get(handles.uibuttongroupgen,'SelectedObject');
 global gen;
 gen=get(first1,'String');
assignin('base','gen',gen);
guidata(hObject, handles);

function radiobutton2_Callback(hObject, eventdata, handles)
first2=get(handles.uibuttongroupgen,'SelectedObject');
global gen;
gen=get(first2,'String');
assignin('base','gen',gen);
guidata(hObject, handles);

function AgeTag_Callback(hObject, eventdata, handles)
global Age;
Age=get(handles.AgeTag,'String');
Age=str2double(Age);
assignin('base','Age',Age);
guidata(hObject, handles);

function AgeTag_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function SubmitTag_Callback(hObject, eventdata, handles)
global a b i Datetime tempavg SyVo DiVo Age gen LSV HSV HeartRate tempx TempF;


Age=round(Age/10);
   
switch gen
    case 'Male'
        switch Age
            case 1
                LSV=94;HSV=129;
            case 2
                LSV=90;HSV=137;
            case 3
                LSV=98;HSV=132;
            case 4
                LSV=91;HSV=125;
            case 5
                LSV=85;HSV=125;
            case 6
                LSV=78;HSV=112;
            case 7
                LSV=71;HSV=106;
            case 8
                LSV=71;HSV=106;
            otherwise 
               set(handles.AgeTag,'String','age is incorrect');
        end
case 'Female'
        switch Age
             case 1
                LSV=84;HSV=116;
            case 2
                LSV=81;HSV=112;
            case 3
                LSV=77;HSV=108;
            case 4
                LSV=74;HSV=105;
            case 5
                LSV=71;HSV=103;
            case 6
                LSV=69;HSV=100;
            case 7
                LSV=66;HSV=99;
            case 8
                LSV=66;HSV=99;
            otherwise 
               set(handles.AgeTag,'String','age is incorrect');
        end
    
end

assignin('base','LSV',LSV);
assignin('base','HSV',HSV);
ecgx=0;
ppgx=0;
tempx=0;

HeartRate=0 ;
tempavg=0;                            
tic
pause(5);
i=0;
while toc<20
     
    
    voltecg = readVoltage(a,'A0')
    ecgx=[ecgx,voltecg]; 
    drawnow;
    axes(handles.axes1);
    plot(ecgx);
    axis( [i-100 i+100 0 0.5])
    grid on;
    i=i+1;
end
tic
i=0;
while toc<20
    voltppg = readVoltage(a,'A1')
    ppgx=[ppgx, voltppg]; 
    drawnow;
    axes(handles.axes2);
    plot(ppgx);
    axis([i-100 i+100 0 5]);
    grid on;
    i=i+1;
end 
    tic
    i=0;
 while toc<20
    volt = readVoltage(a,'A2')
    analog=(volt/0.0048875);
    temp=analog*(0.48828125);
    TempF = 9/5*temp + 40; 
    tempx=[tempx, TempF]; 
    drawnow;
    axes(handles.axes3);
    plot(tempx);
    axis([i-100 i+100 60 105]);
    grid on;
    i=i+1;
 end
    assignin('base','ecgx',ecgx);
    assignin('base','ppgx',ppgx);
    assignin('base','tempx',TempF);
    

    

                     
beat=0;
y=max(ppgx);
for k = 2 : length(ppgx)-2;
    if(ppgx(k) > ppgx(k-1) && ppgx(k) > ppgx(k+1) && ppgx(k) > (0.65*y))
        beat=beat+1; 
    end
    
    
end

for k = 1 : length(tempx)-1
tempsmooth=smooth(tempx,5);
tempavg=mean(tempsmooth);
end

assignin('base','tempavg',tempavg);
assignin('base','beat',beat);
Datime=datetime('now');
Datetime=[Datime,datetime('now')];
HeartRate= beat*3;
SyVo= HeartRate*0.013*HSV;
DiVo=HeartRate*0.013*LSV;
  assignin('base','HeartRate',HeartRate);
  assignin('base','SyVo',SyVo);
  assignin('base','DiVo',DiVo);
  
set(handles.HR,'String',num2str(HeartRate));
set(handles.Temp,'String',num2str(TempF));
set(handles.SBP,'String',num2str(SyVo));
set(handles.DBP,'String',num2str(DiVo));

 if ~isempty(instrfind)
 fclose(instrfind);
 delete(instrfind);
 end

b=serial('COM3','BaudRate',9600);
fopen(b);
pause(2);
   fwrite(b,num2str(HeartRate));
   fwrite(b, num2str(tempavg));
   fwrite(b, num2str(SyVo));
   fwrite(b, num2str(DiVo));
 fclose(b);



guidata(hObject, handles);




function ClearTag_Callback(hObject, eventdata, handles)
set(handles.NameTag,'String','Enter Name');
set(handles.AgeTag,'String','Enter Age');
guidata(hObject, handles);


function LoadTag_Callback(hObject, eventdata, handles)
global Datetime HeartRate SyVo DiVo tempavg Name Age ;
T = table(Name,Age,Datetime',HeartRate',SyVo', DiVo', tempavg','Name','Age','Datetime','HeartRate','Systolic Pressure', 'Diastolic Pressure', 'Body Temperature');
filename = ['Patient.xlsx'];
writetable(T,filename)
guidata(hObject, handles);
