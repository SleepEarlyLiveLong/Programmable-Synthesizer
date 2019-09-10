function varargout = MyPiano(varargin)
% MYPIANO MATLAB code for MyPiano.fig
%      MYPIANO, by itself, creates a new MYPIANO or raises the existing
%      singleton*.
%
%      H = MYPIANO returns the handle to a new MYPIANO or the handle to
%      the existing singleton*.
%
%      MYPIANO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYPIANO.M with the given input arguments.
%
%      MYPIANO('Property','Value',...) creates a new MYPIANO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyPiano_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyPiano_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyPiano

% Last Modified by GUIDE v2.5 17-Mar-2019 15:00:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyPiano_OpeningFcn, ...
                   'gui_OutputFcn',  @MyPiano_OutputFcn, ...
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


% --- Executes just before MyPiano is made visible.
function MyPiano_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyPiano (see VARARGIN)

% Choose default command line output for MyPiano
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% % add path
% addpath('src\');

% UIWAIT makes MyPiano wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clc;
set(gcf,'name','Synthesizer ');
global signal;
signal.x=[];
signal.fs=8000;
signal.noteamp = 1;
signal.dur=0.6;       % 时间默认为0.6s
signal.h_t=[];        % 时域图形句柄
signal.h_f=[];        % 频域图形句柄
signal.color=[0,0,1]; % 颜色默认为蓝
signal.linestyle = '-';
signal.linewidth = 0.5;
signal.marker = 'none';
signal.markeredgecolor = 'auto';
signal.markerfacecolor = 'none';
signal.markersize = 6;
global control;
control.notegroup = 4;                  % 默认是小字一组
control.timber = '4seg_envelopes_sine';                     % 默认是 4seg_envelopes_sine
% 新窗口变量
global midisignal;
midisignal.fs=44100;
midisignal.y=[];
midisignal.len=[];
midisignal.t=[];
midisignal.filename=[];
midisignal.timber = 4;    %默认用四段包络正弦波 4seg_envelopes_sine

% 初始化操作
set(handles.edit_notegroup,'string','小字一组');
set(handles.edit_tone,'string',control.timber);
set(handles.edit_turation,'string',num2str(signal.dur));
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));
set(handles.edit_markersize,'string','(Value)');
% 最开始高音段是可见的
set(handles.threelinedoctave,'enable','on');
set(handles.fourlinedoctave,'enable','on');
set(handles.fivelinedoctave,'enable','on');


% --- Outputs from this function are returned to the command line.
function varargout = MyPiano_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton_C.
function pushbutton_C_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=32.703;
    case 2              %大字组
        f=65.406;
    case 3              %小字组
        f=130.813;
    case 4              %小字一组
        f=261.626;
    case 5              %小字二组
        f=523.251; 
    case 6              %小字三组
        f=1046.502;
    case 7              %小字四组
        f=2093.005;
    case 8              %小字五组
        f=4186.009;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);    

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_D.
function pushbutton_D_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=36.708;
    case 2              %大字组
        f=73.416;
    case 3              %小字组
        f=146.832;
    case 4              %小字一组
        f=293.665;
    case 5              %小字二组
        f=587.33; 
    case 6              %小字三组
        f=1174.659;
    case 7              %小字四组
        f=2349.318;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法

% --- Executes on button press in pushbutton_E.
function pushbutton_E_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=41.203;
    case 2              %大字组
        f=41.203;
    case 3              %小字组
        f=164.814;
    case 4              %小字一组
        f=329.628;
    case 5              %小字二组
        f=659.255; 
    case 6              %小字三组
        f=1318.51;
    case 7              %小字四组
        f=2637.02;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_F.
function pushbutton_F_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=43.654;
    case 2              %大字组
        f=87.307;
    case 3              %小字组
        f=174.614;
    case 4              %小字一组
        f=349.228;
    case 5              %小字二组
        f=698.456; 
    case 6              %小字三组
        f=1396.913;
    case 7              %小字四组
        f=2793.826;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_G.
function pushbutton_G_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=48.999;
    case 2              %大字组
        f=97.999;
    case 3              %小字组
        f=195.998;
    case 4              %小字一组
        f=391.995;
    case 5              %小字二组
        f=783.991; 
    case 6              %小字三组
        f=1567.982;
    case 7              %小字四组
        f=3135.963;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_A.
function pushbutton_A_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=27.5;
    case 1              %大字一组
        f=55;
    case 2              %大字组
        f=110;
    case 3              %小字组
        f=220;
    case 4              %小字一组
        f=440;
    case 5              %小字二组
        f=880; 
    case 6              %小字三组
        f=1760;
    case 7              %小字四组
        f=3520;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_B.
function pushbutton_B_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=30.868;
    case 1              %大字一组
        f=61.735;
    case 2              %大字组
        f=123.471;
    case 3              %小字组
        f=246.942;
    case 4              %小字一组
        f=493.883;
    case 5              %小字二组
        f=987.767; 
    case 6              %小字三组
        f=1975.533;
    case 7              %小字四组
        f=3951.066;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_Caddhalf.
function pushbutton_Caddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=34.648;
    case 2              %大字组
        f=69.296;
    case 3              %小字组
        f=138.591;
    case 4              %小字一组
        f=277.183;
    case 5              %小字二组
        f=554.365; 
    case 6              %小字三组
        f=1108.731;
    case 7              %小字四组
        f=2217.461;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_Daddhalf.
function pushbutton_Daddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Daddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=38.891;
    case 2              %大字组
        f=77.782;
    case 3              %小字组
        f=155.563;
    case 4              %小字一组
        f=311.127;
    case 5              %小字二组
        f=622.254; 
    case 6              %小字三组
        f=1244.508;
    case 7              %小字四组
        f=2489.016;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_Faddhalf.
function pushbutton_Faddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Faddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=46.249;
    case 2              %大字组
        f=92.499;
    case 3              %小字组
        f=184.997;
    case 4              %小字一组
        f=369.994;
    case 5              %小字二组
        f=739.989; 
    case 6              %小字三组
        f=1479.978;
    case 7              %小字四组
        f=2959.955;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_Gaddhalf.
function pushbutton_Gaddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Gaddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=0;
    case 1              %大字一组
        f=51.913;
    case 2              %大字组
        f=103.826;
    case 3              %小字组
        f=207.652;
    case 4              %小字一组
        f=415.305;
    case 5              %小字二组
        f=830.609; 
    case 6              %小字三组
        f=1661.219;
    case 7              %小字四组
        f=3322.438;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --- Executes on button press in pushbutton_Aaddhalf.
function pushbutton_Aaddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Aaddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %大字二组
        f=29.135;
    case 1              %大字一组
        f=58.27;
    case 2              %大字组
        f=116.541;
    case 3              %小字组
        f=233.082;
    case 4              %小字一组
        f=466.164;
    case 5              %小字二组
        f=932.328; 
    case 6              %小字三组
        f=1864.655;
    case 7              %小字四组
        f=3729.31;
    case 8              %小字五组
        f=0;
end    

t=0:1/signal.fs:signal.dur;
x = notesynth(f,signal.dur,signal.fs,signal.noteamp,control.timber);       

sound(x);
axes(handles.axes_time);
signal.h_t=drawxt(t,x,signal.color,signal.linestyle,signal.linewidth,...
    signal.marker,signal.markeredgecolor,signal.markerfacecolor,...
    signal.markersize);
axes(handles.axes_freq);
[~,signal.h_f]=drawfft(x,signal.fs,signal.dur,signal.color,...
    signal.linestyle,signal.linewidth,signal.marker,...
    signal.markeredgecolor,signal.markerfacecolor,signal.markersize);
set(handles.edit_Value,'String',num2str(f));       %注意set函数的用法


% --------------------------------------------------------------------
function showgrid_OffCallback(hObject, eventdata, handles)
% hObject    handle to showgrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_time);
grid off;
axes(handles.axes_freq);
grid off;

% --------------------------------------------------------------------
function showgrid_OnCallback(hObject, eventdata, handles)
% hObject    handle to showgrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_time);
grid on;
axes(handles.axes_freq);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             菜单开始                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% 菜单 - 开始 - 打开文件 %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function readmidifile_Callback(hObject, eventdata, handles)
% hObject    handle to readmidifile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('mymidi.fig');


% --------------------------------------------------------------------
function work1_Callback(hObject, eventdata, handles)
% hObject    handle to work1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% initialize matrix:
% M就是数组note，用户只需确定其前6列，分别是：
% 音轨  声道  音符编号  力度  音符开始时间   音符结束时间
% [track chan   nn       vel      t1             t2        msgNum1 msgNum2]
N = 21;        % 音符数目
M = zeros(N,6);

M(:,1) = 1;         % 音轨1
M(:,2) = 1;         % 声道1
M(:,3) = (70:90)';  % 音符(只能取0-127)中央C：第60号
M(:,4) = round(linspace(60,120,N))';  % 设置每个音符的响度：60->120
M(:,5) = (0.5:0.5:10.5)';  % 每个音符的开始时间
M(:,6) = M(:,5) + 1.5;    % 每个音符的结束时间

midi_new = matrix2midi(M);
writemidi(midi_new, 'work1.mid');

% --------------------------------------------------------------------
function work2_Callback(hObject, eventdata, handles)
% hObject    handle to work2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% initialize matrix:
N = 200;
M = zeros(N,6);

M(:,1) = 1;         % 音轨1
M(:,2) = 1;         % 声道1

M(:,3) = 30 + round(60*rand(N,1));  % 音符号：随意取
M(:,4) = 60 + round(40*rand(N,1));  % 响度：随意取

M(:,5) = 10 * rand(N,1);     % 开始时间
M(:,6) = M(:,5) + .2;        % 结束时间

midi_new = matrix2midi(M);
writemidi(midi_new, 'work2.mid');

%%%%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 色彩 %%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.color = [1,0,0];
set(signal.h_t,'color',signal.color);
set(signal.h_f,'color',signal.color);

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.color = [0,1,0];
set(signal.h_t,'color',signal.color);
set(signal.h_f,'color',signal.color);

% --------------------------------------------------------------------
function bule_Callback(hObject, eventdata, handles)
% hObject    handle to bule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.color = [0,0,1];
set(signal.h_t,'color',signal.color);
set(signal.h_f,'color',signal.color);

% --------------------------------------------------------------------
function others_Callback(hObject, eventdata, handles)
% hObject    handle to others (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.color = uisetcolor;
set(signal.h_t,'color',signal.color);
set(signal.h_f,'color',signal.color);

%%%%%%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 线型 %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function solidline_Callback(hObject, eventdata, handles)
% hObject    handle to solidline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linestyle = '-';
set(signal.h_t,'linestyle',signal.linestyle);
set(signal.h_f,'linestyle',signal.linestyle);

% --------------------------------------------------------------------
function dashedline_Callback(hObject, eventdata, handles)
% hObject    handle to dashedline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linestyle = '--';
set(signal.h_t,'linestyle',signal.linestyle);
set(signal.h_f,'linestyle',signal.linestyle);

% --------------------------------------------------------------------
function dottedline_Callback(hObject, eventdata, handles)
% hObject    handle to dottedline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linestyle = ':';
set(signal.h_t,'linestyle',signal.linestyle);
set(signal.h_f,'linestyle',signal.linestyle);

% --------------------------------------------------------------------
function dashdotline_Callback(hObject, eventdata, handles)
% hObject    handle to dashdotline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linestyle = '-.';
set(signal.h_t,'linestyle',signal.linestyle);
set(signal.h_f,'linestyle',signal.linestyle);

% --------------------------------------------------------------------
function linenone_Callback(hObject, eventdata, handles)
% hObject    handle to linenone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linestyle = 'none';
set(signal.h_t,'linestyle',signal.linestyle);
set(signal.h_f,'linestyle',signal.linestyle);

%%%%%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 线宽 %%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function linewidthdefault_Callback(hObject, eventdata, handles)
% hObject    handle to linewidthdefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.linewidth = 0.5;
set(signal.h_t,'linewidth',signal.linewidth);
set(signal.h_f,'linewidth',signal.linewidth);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));


% --------------------------------------------------------------------
function linewidthadd_Callback(hObject, eventdata, handles)
% hObject    handle to linewidthadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if signal.linewidth < 5
    signal.linewidth = signal.linewidth + 1;
else
    q = warndlg('警告！线宽过宽，不建议继续增加。','警告');
    if strcmp(q,'Yes')
        close;
    end
end
set(signal.h_t,'linewidth',signal.linewidth);
set(signal.h_f,'linewidth',signal.linewidth);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));

% --------------------------------------------------------------------
function linewidthminus_Callback(hObject, eventdata, handles)
% hObject    handle to linewidthminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if signal.linewidth > 1
    signal.linewidth = signal.linewidth - 1;
else
    q = errordlg('错误！线宽应当为正值。','错误');
    if strcmp(q,'Yes')
        close;
    end
end
set(signal.h_t,'linewidth',signal.linewidth);
set(signal.h_f,'linewidth',signal.linewidth);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));

%%%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 标记点型 %%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function circle_Callback(hObject, eventdata, handles)
% hObject    handle to circle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'o';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function plussign_Callback(hObject, eventdata, handles)
% hObject    handle to plussign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = '+';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function asterisk_Callback(hObject, eventdata, handles)
% hObject    handle to asterisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = '*';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function cross_Callback(hObject, eventdata, handles)
% hObject    handle to cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'x';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function square_Callback(hObject, eventdata, handles)
% hObject    handle to square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 's';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function diamond_Callback(hObject, eventdata, handles)
% hObject    handle to diamond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'd';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function upwardtriangle_Callback(hObject, eventdata, handles)
% hObject    handle to upwardtriangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = '^';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function downwardtriangle_Callback(hObject, eventdata, handles)
% hObject    handle to downwardtriangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'v';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function righttriangle_Callback(hObject, eventdata, handles)
% hObject    handle to righttriangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = '>';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function lefttriangle_Callback(hObject, eventdata, handles)
% hObject    handle to lefttriangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = '<';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function fivepointedstar_Callback(hObject, eventdata, handles)
% hObject    handle to fivepointedstar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'p';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function sixpointedstar_Callback(hObject, eventdata, handles)
% hObject    handle to sixpointedstar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'h';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string',num2str(signal.markersize));

% --------------------------------------------------------------------
function markernone_Callback(hObject, eventdata, handles)
% hObject    handle to markernone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.marker = 'none';
set(signal.h_t,'marker',signal.marker);
set(signal.h_f,'marker',signal.marker);
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string','(Value)');

%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 标记点边缘色 %%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function markeredgecolorauto_Callback(hObject, eventdata, handles)
% hObject    handle to markeredgecolorauto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markeredgecolor = 'auto';
set(signal.h_t,'markeredgecolor',signal.markeredgecolor);
set(signal.h_f,'markeredgecolor',signal.markeredgecolor);

% --------------------------------------------------------------------
function markeredgecolornone_Callback(hObject, eventdata, handles)
% hObject    handle to markeredgecolornone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markeredgecolor = 'none';
set(signal.h_t,'markeredgecolor',signal.markeredgecolor);
set(signal.h_f,'markeredgecolor',signal.markeredgecolor);

% --------------------------------------------------------------------
function markeredgecolorothers_Callback(hObject, eventdata, handles)
% hObject    handle to markeredgecolorothers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markeredgecolor = uisetcolor;
set(signal.h_t,'markeredgecolor',signal.markeredgecolor);
set(signal.h_f,'markeredgecolor',signal.markeredgecolor);

%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 标记点表面色 %%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function markerfacecolorauto_Callback(hObject, eventdata, handles)
% hObject    handle to markerfacecolorauto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markerfacecolor = 'auto';
set(signal.h_t,'markerfacecolor',signal.markerfacecolor);
set(signal.h_f,'markerfacecolor',signal.markerfacecolor);

% --------------------------------------------------------------------
function markerfacecolornone_Callback(hObject, eventdata, handles)
% hObject    handle to markerfacecolornone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markerfacecolor = 'none';
set(signal.h_t,'markerfacecolor',signal.markerfacecolor);
set(signal.h_f,'markerfacecolor',signal.markerfacecolor);

% --------------------------------------------------------------------
function markerfacecolorothers_Callback(hObject, eventdata, handles)
% hObject    handle to markerfacecolorothers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markerfacecolor = uisetcolor;
set(signal.h_t,'markerfacecolor',signal.markerfacecolor);
set(signal.h_f,'markerfacecolor',signal.markerfacecolor);

%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 标记点尺寸 %%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function markersizedefault_Callback(hObject, eventdata, handles)
% hObject    handle to markersizedefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.markersize = 6;
set(signal.h_t,'markersize',signal.markersize);
set(signal.h_f,'markersize',signal.markersize);
if ~strcmpi(get(handles.edit_marker,'string'),'none')
    set(handles.edit_markersize,'string',num2str(signal.markersize));
else
    set(handles.edit_markersize,'string','(Value)');
end

% --------------------------------------------------------------------
function markersizeadd_Callback(hObject, eventdata, handles)
% hObject    handle to markersizeadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if ~strcmpi(signal.marker,'none')    % 标记点有形状
    if signal.markersize <= 15
    signal.markersize = signal.markersize + 2;
    else
        q = warndlg('警告！标记点尺寸过大，不建议再增加。','警告');
        if strcmp(q,'Yes')
            close;
        end
    end
else
    q=warndlg('警告！此时标记点无形状。','警告');
    if strcmpi(q,'Yes')
        close;
    end
end
set(signal.h_t,'markersize',signal.markersize);
set(signal.h_f,'markersize',signal.markersize);
if ~strcmpi(get(handles.edit_marker,'string'),'none')
    set(handles.edit_markersize,'string',num2str(signal.markersize));
else
    set(handles.edit_markersize,'string','(Value)');
end

% --------------------------------------------------------------------
function markersizeminus_Callback(hObject, eventdata, handles)
% hObject    handle to markersizeminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if ~strcmpi(signal.marker,'none')    % 标记点有形状
    if signal.markersize > 2
    signal.markersize = signal.markersize - 2;
    else
        q = errordlg('错误！标记点尺寸应为正数。','错误');
        if strcmp(q,'Yes')
            close;
        end
    end
else
    q=warndlg('警告！此时标记点无形状。','警告');
    if strcmpi(q,'Yes')
        close;
    end
end
set(signal.h_t,'markersize',signal.markersize);
set(signal.h_f,'markersize',signal.markersize);
if ~strcmpi(get(handles.edit_marker,'string'),'none')
    set(handles.edit_markersize,'string',num2str(signal.markersize));
else
    set(handles.edit_markersize,'string','(Value)');
end

%%%%%%%%%%%%%%%%%%%%% 菜单 - 设置 - 恢复默认 %%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function settodefault_Callback(hObject, eventdata, handles)
% hObject    handle to settodefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
% 全部设置为默认参数
signal.color=[0,0,1]; 
signal.linestyle = '-';
signal.linewidth = 0.5;
signal.dur=0.6;
signal.marker = 'none';
signal.markeredgecolor = 'auto';
signal.markerfacecolor = 'none';
signal.markersize = 6;
global control;
% 全部设置为默认参数
control.notegroup = 4;                  % 默认是小字一组
control.timber = 'noenvelope_sine';     % 默认是无包络正弦
set(signal.h_t,'color',signal.color,'linestyle',signal.linestyle,...
    'linewidth',signal.linewidth,'marker',signal.marker,...
    'markeredgecolor',signal.markeredgecolor,...
    'markerfacecolor',signal.markerfacecolor,'markersize',signal.markersize);
set(signal.h_f,'color',signal.color,'linestyle',signal.linestyle,...
    'linewidth',signal.linewidth,'marker',signal.marker,...
    'markeredgecolor',signal.markeredgecolor,...
    'markerfacecolor',signal.markerfacecolor,'markersize',signal.markersize);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_markersize,'string','(Value)');
set(handles.edit_turation,'string',num2str(signal.dur));
set(handles.edit_notegroup,'string','小字一组');
set(handles.edit_tone,'string',control.timber);

%%%%%%%%%%%%%%%%%%%%% 菜单 - 帮助 - 版本说明 %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function VERSION_Callback(hObject, eventdata, handles)
% hObject    handle to VERSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hs = msgbox({'软件版本说明:';'';'Version: 1.0 ';'';...
             'Author: Chen Tianyang';'';...
             'Data:2018-04-14';''},'Version Information');
%改变字体大小
ht = findobj(hs, 'Type', 'text');
set(ht,'FontSize',12);
%改变对话框大小
set(hs, 'Resize', 'on'); 

%%%%%%%%%%%%%%%%%%%%% 菜单 - 帮助 - 使用说明 %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function USERGUIDE_Callback(hObject, eventdata, handles)
% hObject    handle to USERGUIDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hs = msgbox({'软件使用帮助:';...
            '这是一款简易的电子音合成软件，具有如下功能：';'';...
            '1. 读取并播放一段语音信号；';...
            '2. 绘制读入语音信号的语谱图；';...
            '3. 判断信号中各音节的起讫点；';...
            '4. 提取语音信号的特征量；';...
            '4. 滑动游标对感兴趣的信号段进行上述处理。';'';...
            '其中，语音特征量有：';...
            '        短时能量';'        短时平均幅度';'        短时过零率';...
            '        基音频率';'';...
            '软件还展示了用以计算基音频率的多种函数波形，包括：';
            '        修正短时自相关函数';...
            '        修正短时平均幅度差函数';...
            '        短时自相关函数';...
            '        短时平均幅度差函数';...
            '        修正短时自相关函数/平均幅度差函数';'';...
            },'UserGuide');
%改变字体大小
ht = findobj(hs, 'Type', 'text');
set(ht,'FontSize',12);
%改变对话框大小
set(hs, 'Resize', 'on'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             菜单结束                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% 菜单 - 音调 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function greatoctavetwo_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctavetwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 0;         % 代表大字二组
set(handles.pushbutton_C,'enable','off','string','C2');
set(handles.pushbutton_D,'enable','off','string','D2');
set(handles.pushbutton_E,'enable','off','string','E2');
set(handles.pushbutton_F,'enable','off','string','F2');
set(handles.pushbutton_G,'enable','off','string','G2');
set(handles.pushbutton_A,'enable','on','string','A2');
set(handles.pushbutton_B,'enable','on','string','B2');
set(handles.pushbutton_Caddhalf,'enable','off','string','C#2');
set(handles.pushbutton_Daddhalf,'enable','off','string','D#2');
set(handles.pushbutton_Faddhalf,'enable','off','string','F#2');
set(handles.pushbutton_Gaddhalf,'enable','off','string','G#2');
set(handles.pushbutton_Aaddhalf,'enable','on','string','A#2');
set(handles.edit_notegroup,'string','大字二组');

% --------------------------------------------------------------------
function greatoctaveone_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctaveone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 1;          % 代表大字一组
set(handles.pushbutton_C,'enable','on','string','C1');
set(handles.pushbutton_D,'enable','on','string','D1');
set(handles.pushbutton_E,'enable','on','string','E1');
set(handles.pushbutton_F,'enable','on','string','F1');
set(handles.pushbutton_G,'enable','on','string','G1');
set(handles.pushbutton_A,'enable','on','string','A1');
set(handles.pushbutton_B,'enable','on','string','B1');
set(handles.pushbutton_Caddhalf,'enable','on','string','C#1');
set(handles.pushbutton_Daddhalf,'enable','on','string','D#1');
set(handles.pushbutton_Faddhalf,'enable','on','string','F#1');
set(handles.pushbutton_Gaddhalf,'enable','on','string','G#1');
set(handles.pushbutton_Aaddhalf,'enable','on','string','A#1');
set(handles.edit_notegroup,'string','大字一组');

% --------------------------------------------------------------------
function greatoctave_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 2;          % 代表大字组
set(handles.pushbutton_C,'enable','on','string','C');
set(handles.pushbutton_D,'enable','on','string','D');
set(handles.pushbutton_E,'enable','on','string','E');
set(handles.pushbutton_F,'enable','on','string','F');
set(handles.pushbutton_G,'enable','on','string','G');
set(handles.pushbutton_A,'enable','on','string','A');
set(handles.pushbutton_B,'enable','on','string','B');
set(handles.pushbutton_Caddhalf,'enable','on','string','C#');
set(handles.pushbutton_Daddhalf,'enable','on','string','D#');
set(handles.pushbutton_Faddhalf,'enable','on','string','F#');
set(handles.pushbutton_Gaddhalf,'enable','on','string','G#');
set(handles.pushbutton_Aaddhalf,'enable','on','string','A#');
set(handles.edit_notegroup,'string','大字组');

% --------------------------------------------------------------------
function unaccentedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to unaccentedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 3;         % 代表小字组
set(handles.pushbutton_C,'enable','on','string','c');
set(handles.pushbutton_D,'enable','on','string','d');
set(handles.pushbutton_E,'enable','on','string','e');
set(handles.pushbutton_F,'enable','on','string','f');
set(handles.pushbutton_G,'enable','on','string','g');
set(handles.pushbutton_A,'enable','on','string','a');
set(handles.pushbutton_B,'enable','on','string','b');
set(handles.pushbutton_Caddhalf,'enable','on','string','c#');
set(handles.pushbutton_Daddhalf,'enable','on','string','d#');
set(handles.pushbutton_Faddhalf,'enable','on','string','f#');
set(handles.pushbutton_Gaddhalf,'enable','on','string','g#');
set(handles.pushbutton_Aaddhalf,'enable','on','string','a#');
set(handles.edit_notegroup,'string','小字组');

% --------------------------------------------------------------------
function onelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to onelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 4;        % 代表小字一组
set(handles.pushbutton_C,'enable','on','string','c1');
set(handles.pushbutton_D,'enable','on','string','d1');
set(handles.pushbutton_E,'enable','on','string','e1');
set(handles.pushbutton_F,'enable','on','string','f1');
set(handles.pushbutton_G,'enable','on','string','g1');
set(handles.pushbutton_A,'enable','on','string','a1');
set(handles.pushbutton_B,'enable','on','string','b1');
set(handles.pushbutton_Caddhalf,'enable','on','string','c#1');
set(handles.pushbutton_Daddhalf,'enable','on','string','d#1');
set(handles.pushbutton_Faddhalf,'enable','on','string','f#1');
set(handles.pushbutton_Gaddhalf,'enable','on','string','g#1');
set(handles.pushbutton_Aaddhalf,'enable','on','string','a#1');
set(handles.edit_notegroup,'string','小字一组');

% --------------------------------------------------------------------
function twolinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to twolinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 5;        % 代表小字二组
set(handles.pushbutton_C,'enable','on','string','c2');
set(handles.pushbutton_D,'enable','on','string','d2');
set(handles.pushbutton_E,'enable','on','string','e2');
set(handles.pushbutton_F,'enable','on','string','f2');
set(handles.pushbutton_G,'enable','on','string','g2');
set(handles.pushbutton_A,'enable','on','string','a2');
set(handles.pushbutton_B,'enable','on','string','b2');
set(handles.pushbutton_Caddhalf,'enable','on','string','c#2');
set(handles.pushbutton_Daddhalf,'enable','on','string','d#2');
set(handles.pushbutton_Faddhalf,'enable','on','string','f#2');
set(handles.pushbutton_Gaddhalf,'enable','on','string','g#2');
set(handles.pushbutton_Aaddhalf,'enable','on','string','a#2');
set(handles.edit_notegroup,'string','小字二组');

% --------------------------------------------------------------------
function threelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to threelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 6;         % 代表小字三组
set(handles.pushbutton_C,'enable','on','string','c3');
set(handles.pushbutton_D,'enable','on','string','d3');
set(handles.pushbutton_E,'enable','on','string','e3');
set(handles.pushbutton_F,'enable','on','string','f3');
set(handles.pushbutton_G,'enable','on','string','g3');
set(handles.pushbutton_A,'enable','on','string','a3');
set(handles.pushbutton_B,'enable','on','string','b3');
set(handles.pushbutton_Caddhalf,'enable','on','string','c#3');
set(handles.pushbutton_Daddhalf,'enable','on','string','d#3');
set(handles.pushbutton_Faddhalf,'enable','on','string','f#3');
set(handles.pushbutton_Gaddhalf,'enable','on','string','g#3');
set(handles.pushbutton_Aaddhalf,'enable','on','string','a#3');
set(handles.edit_notegroup,'string','小字三组');

% --------------------------------------------------------------------
function fourlinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to fourlinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 7;        % 代表小字四组
set(handles.pushbutton_C,'enable','on','string','c4');
set(handles.pushbutton_D,'enable','on','string','d4');
set(handles.pushbutton_E,'enable','on','string','e4');
set(handles.pushbutton_F,'enable','on','string','f4');
set(handles.pushbutton_G,'enable','on','string','g4');
set(handles.pushbutton_A,'enable','on','string','a4');
set(handles.pushbutton_B,'enable','on','string','b4');
set(handles.pushbutton_Caddhalf,'enable','on','string','c#4');
set(handles.pushbutton_Daddhalf,'enable','on','string','d#4');
set(handles.pushbutton_Faddhalf,'enable','on','string','f#4');
set(handles.pushbutton_Gaddhalf,'enable','on','string','g#4');
set(handles.pushbutton_Aaddhalf,'enable','on','string','a#4');
set(handles.edit_notegroup,'string','小字四组');

% --------------------------------------------------------------------
function fivelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to fivelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 8;          % 代表小字五组
set(handles.pushbutton_C,'enable','on','string','c5');
set(handles.pushbutton_D,'enable','off','string','d5');
set(handles.pushbutton_E,'enable','off','string','e5');
set(handles.pushbutton_F,'enable','off','string','f5');
set(handles.pushbutton_G,'enable','off','string','g5');
set(handles.pushbutton_A,'enable','off','string','a5');
set(handles.pushbutton_B,'enable','off','string','b5');
set(handles.pushbutton_Caddhalf,'enable','off','string','c#5');
set(handles.pushbutton_Daddhalf,'enable','off','string','d#5');
set(handles.pushbutton_Faddhalf,'enable','off','string','f#5');
set(handles.pushbutton_Gaddhalf,'enable','off','string','g#5');
set(handles.pushbutton_Aaddhalf,'enable','off','string','a#5');
set(handles.edit_notegroup,'string','小字五组');

%%%%%%%%%%%%%%%%%%%%%%%%%%% 菜单 - 音色 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function noenvelope_sine_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = 'noenvelope_sine';
set(handles.edit_tone,'string',control.timber);
% 只要不是karplus-strong，高音段都是可见的
set(handles.threelinedoctave,'enable','on');
set(handles.fourlinedoctave,'enable','on');
set(handles.fivelinedoctave,'enable','on');
% --------------------------------------------------------------------
function noenvelope_saw_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_saw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = 'noenvelope_saw';
set(handles.edit_tone,'string',control.timber);
% 只要不是karplus-strong，高音段都是可见的
set(handles.threelinedoctave,'enable','on');
set(handles.fourlinedoctave,'enable','on');
set(handles.fivelinedoctave,'enable','on');
% --------------------------------------------------------------------
function noenvelope_square_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = 'noenvelope_square';
set(handles.edit_tone,'string',control.timber);
% 只要不是karplus-strong，高音段都是可见的
set(handles.threelinedoctave,'enable','on');
set(handles.fourlinedoctave,'enable','on');
set(handles.fivelinedoctave,'enable','on');
% --------------------------------------------------------------------
function foursegmentenvelopes_sine_Callback(hObject, eventdata, handles)
% hObject    handle to foursegmentenvelopes_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = '4seg_envelopes_sine';
set(handles.edit_tone,'string',control.timber);
% 只要不是karplus-strong，高音段都是可见的
set(handles.threelinedoctave,'enable','on');
set(handles.fourlinedoctave,'enable','on');
set(handles.fivelinedoctave,'enable','on');
% --------------------------------------------------------------------
function KarplusStrong_Callback(hObject, eventdata, handles)
% hObject    handle to KarplusStrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = 'KarplusStrong';
set(handles.edit_tone,'string',control.timber);
% 由于功能的局限性，小字三以上的就不用用了
set(handles.threelinedoctave,'enable','off');
set(handles.fourlinedoctave,'enable','off');
set(handles.fivelinedoctave,'enable','off');
if control.notegroup == 6||7||8
    control.notegroup = 4;        % 改回默认的小字一组
end
set(handles.edit_notegroup,'string','小字一组');


% --------------------------------------------------------------------
function turdefault_Callback(hObject, eventdata, handles)
% hObject    handle to turdefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
signal.dur = 0.6;
set(handles.edit_turation,'string',num2str(signal.dur));


% --------------------------------------------------------------------
function turadd_Callback(hObject, eventdata, handles)
% hObject    handle to turadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if signal.dur < 5
    signal.dur = signal.dur + 0.1;
else
    q=warndlg('警告！音节时长过长，不建议再增加。','警告');
    if strcmpi(q,'Yes')
        close;
    end
end
set(handles.edit_turation,'string',num2str(signal.dur));

% --------------------------------------------------------------------
function turminus_Callback(hObject, eventdata, handles)
% hObject    handle to turminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
if signal.dur>0.15
    signal.dur = signal.dur - 0.1;
else
    q=errordlg('错误！音节时长应当为正数。','错误');
    if strcmpi(q,'Yes')
        close;
    end
end
set(handles.edit_turation,'string',num2str(signal.dur));



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
