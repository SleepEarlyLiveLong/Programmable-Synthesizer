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
signal.dur=0.6;       % ʱ��Ĭ��Ϊ0.6s
signal.h_t=[];        % ʱ��ͼ�ξ��
signal.h_f=[];        % Ƶ��ͼ�ξ��
signal.color=[0,0,1]; % ��ɫĬ��Ϊ��
signal.linestyle = '-';
signal.linewidth = 0.5;
signal.marker = 'none';
signal.markeredgecolor = 'auto';
signal.markerfacecolor = 'none';
signal.markersize = 6;
global control;
control.notegroup = 4;                  % Ĭ����С��һ��
control.timber = '4seg_envelopes_sine';                     % Ĭ���� 4seg_envelopes_sine
% �´��ڱ���
global midisignal;
midisignal.fs=44100;
midisignal.y=[];
midisignal.len=[];
midisignal.t=[];
midisignal.filename=[];
midisignal.timber = 4;    %Ĭ�����Ķΰ������Ҳ� 4seg_envelopes_sine

% ��ʼ������
set(handles.edit_notegroup,'string','С��һ��');
set(handles.edit_tone,'string',control.timber);
set(handles.edit_turation,'string',num2str(signal.dur));
set(handles.edit_marker,'string',signal.marker);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));
set(handles.edit_markersize,'string','(Value)');
% �ʼ�������ǿɼ���
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
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=32.703;
    case 2              %������
        f=65.406;
    case 3              %С����
        f=130.813;
    case 4              %С��һ��
        f=261.626;
    case 5              %С�ֶ���
        f=523.251; 
    case 6              %С������
        f=1046.502;
    case 7              %С������
        f=2093.005;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_D.
function pushbutton_D_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=36.708;
    case 2              %������
        f=73.416;
    case 3              %С����
        f=146.832;
    case 4              %С��һ��
        f=293.665;
    case 5              %С�ֶ���
        f=587.33; 
    case 6              %С������
        f=1174.659;
    case 7              %С������
        f=2349.318;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�

% --- Executes on button press in pushbutton_E.
function pushbutton_E_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=41.203;
    case 2              %������
        f=41.203;
    case 3              %С����
        f=164.814;
    case 4              %С��һ��
        f=329.628;
    case 5              %С�ֶ���
        f=659.255; 
    case 6              %С������
        f=1318.51;
    case 7              %С������
        f=2637.02;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_F.
function pushbutton_F_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=43.654;
    case 2              %������
        f=87.307;
    case 3              %С����
        f=174.614;
    case 4              %С��һ��
        f=349.228;
    case 5              %С�ֶ���
        f=698.456; 
    case 6              %С������
        f=1396.913;
    case 7              %С������
        f=2793.826;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_G.
function pushbutton_G_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=48.999;
    case 2              %������
        f=97.999;
    case 3              %С����
        f=195.998;
    case 4              %С��һ��
        f=391.995;
    case 5              %С�ֶ���
        f=783.991; 
    case 6              %С������
        f=1567.982;
    case 7              %С������
        f=3135.963;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_A.
function pushbutton_A_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=27.5;
    case 1              %����һ��
        f=55;
    case 2              %������
        f=110;
    case 3              %С����
        f=220;
    case 4              %С��һ��
        f=440;
    case 5              %С�ֶ���
        f=880; 
    case 6              %С������
        f=1760;
    case 7              %С������
        f=3520;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_B.
function pushbutton_B_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=30.868;
    case 1              %����һ��
        f=61.735;
    case 2              %������
        f=123.471;
    case 3              %С����
        f=246.942;
    case 4              %С��һ��
        f=493.883;
    case 5              %С�ֶ���
        f=987.767; 
    case 6              %С������
        f=1975.533;
    case 7              %С������
        f=3951.066;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_Caddhalf.
function pushbutton_Caddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=34.648;
    case 2              %������
        f=69.296;
    case 3              %С����
        f=138.591;
    case 4              %С��һ��
        f=277.183;
    case 5              %С�ֶ���
        f=554.365; 
    case 6              %С������
        f=1108.731;
    case 7              %С������
        f=2217.461;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_Daddhalf.
function pushbutton_Daddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Daddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=38.891;
    case 2              %������
        f=77.782;
    case 3              %С����
        f=155.563;
    case 4              %С��һ��
        f=311.127;
    case 5              %С�ֶ���
        f=622.254; 
    case 6              %С������
        f=1244.508;
    case 7              %С������
        f=2489.016;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_Faddhalf.
function pushbutton_Faddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Faddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=46.249;
    case 2              %������
        f=92.499;
    case 3              %С����
        f=184.997;
    case 4              %С��һ��
        f=369.994;
    case 5              %С�ֶ���
        f=739.989; 
    case 6              %С������
        f=1479.978;
    case 7              %С������
        f=2959.955;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_Gaddhalf.
function pushbutton_Gaddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Gaddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=0;
    case 1              %����һ��
        f=51.913;
    case 2              %������
        f=103.826;
    case 3              %С����
        f=207.652;
    case 4              %С��һ��
        f=415.305;
    case 5              %С�ֶ���
        f=830.609; 
    case 6              %С������
        f=1661.219;
    case 7              %С������
        f=3322.438;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


% --- Executes on button press in pushbutton_Aaddhalf.
function pushbutton_Aaddhalf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Aaddhalf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
global control;
switch control.notegroup         % /Hz
    case 0              %���ֶ���
        f=29.135;
    case 1              %����һ��
        f=58.27;
    case 2              %������
        f=116.541;
    case 3              %С����
        f=233.082;
    case 4              %С��һ��
        f=466.164;
    case 5              %С�ֶ���
        f=932.328; 
    case 6              %С������
        f=1864.655;
    case 7              %С������
        f=3729.31;
    case 8              %С������
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
set(handles.edit_Value,'String',num2str(f));       %ע��set�������÷�


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
%                             �˵���ʼ                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% �˵� - ��ʼ - ���ļ� %%%%%%%%%%%%%%%%%%%%%%%%%
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
% M��������note���û�ֻ��ȷ����ǰ6�У��ֱ��ǣ�
% ����  ����  �������  ����  ������ʼʱ��   ��������ʱ��
% [track chan   nn       vel      t1             t2        msgNum1 msgNum2]
N = 21;        % ������Ŀ
M = zeros(N,6);

M(:,1) = 1;         % ����1
M(:,2) = 1;         % ����1
M(:,3) = (70:90)';  % ����(ֻ��ȡ0-127)����C����60��
M(:,4) = round(linspace(60,120,N))';  % ����ÿ����������ȣ�60->120
M(:,5) = (0.5:0.5:10.5)';  % ÿ�������Ŀ�ʼʱ��
M(:,6) = M(:,5) + 1.5;    % ÿ�������Ľ���ʱ��

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

M(:,1) = 1;         % ����1
M(:,2) = 1;         % ����1

M(:,3) = 30 + round(60*rand(N,1));  % �����ţ�����ȡ
M(:,4) = 60 + round(40*rand(N,1));  % ��ȣ�����ȡ

M(:,5) = 10 * rand(N,1);     % ��ʼʱ��
M(:,6) = M(:,5) + .2;        % ����ʱ��

midi_new = matrix2midi(M);
writemidi(midi_new, 'work2.mid');

%%%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ɫ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ���� %%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - �߿� %%%%%%%%%%%%%%%%%%%%%%%%%%
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
    q = warndlg('���棡�߿����������������ӡ�','����');
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
    q = errordlg('�����߿�Ӧ��Ϊ��ֵ��','����');
    if strcmp(q,'Yes')
        close;
    end
end
set(signal.h_t,'linewidth',signal.linewidth);
set(signal.h_f,'linewidth',signal.linewidth);
set(handles.edit_linewidth,'string',num2str(signal.linewidth));

%%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ��ǵ��� %%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ��ǵ��Եɫ %%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%% �˵� - ���� - ��ǵ����ɫ %%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ��ǵ�ߴ� %%%%%%%%%%%%%%%%%%%%%%%%
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
if ~strcmpi(signal.marker,'none')    % ��ǵ�����״
    if signal.markersize <= 15
    signal.markersize = signal.markersize + 2;
    else
        q = warndlg('���棡��ǵ�ߴ���󣬲����������ӡ�','����');
        if strcmp(q,'Yes')
            close;
        end
    end
else
    q=warndlg('���棡��ʱ��ǵ�����״��','����');
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
if ~strcmpi(signal.marker,'none')    % ��ǵ�����״
    if signal.markersize > 2
    signal.markersize = signal.markersize - 2;
    else
        q = errordlg('���󣡱�ǵ�ߴ�ӦΪ������','����');
        if strcmp(q,'Yes')
            close;
        end
    end
else
    q=warndlg('���棡��ʱ��ǵ�����״��','����');
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

%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - �ָ�Ĭ�� %%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function settodefault_Callback(hObject, eventdata, handles)
% hObject    handle to settodefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signal;
% ȫ������ΪĬ�ϲ���
signal.color=[0,0,1]; 
signal.linestyle = '-';
signal.linewidth = 0.5;
signal.dur=0.6;
signal.marker = 'none';
signal.markeredgecolor = 'auto';
signal.markerfacecolor = 'none';
signal.markersize = 6;
global control;
% ȫ������ΪĬ�ϲ���
control.notegroup = 4;                  % Ĭ����С��һ��
control.timber = 'noenvelope_sine';     % Ĭ�����ް�������
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
set(handles.edit_notegroup,'string','С��һ��');
set(handles.edit_tone,'string',control.timber);

%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - �汾˵�� %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function VERSION_Callback(hObject, eventdata, handles)
% hObject    handle to VERSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hs = msgbox({'����汾˵��:';'';'Version: 1.0 ';'';...
             'Author: Chen Tianyang';'';...
             'Data:2018-04-14';''},'Version Information');
%�ı������С
ht = findobj(hs, 'Type', 'text');
set(ht,'FontSize',12);
%�ı�Ի����С
set(hs, 'Resize', 'on'); 

%%%%%%%%%%%%%%%%%%%%% �˵� - ���� - ʹ��˵�� %%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function USERGUIDE_Callback(hObject, eventdata, handles)
% hObject    handle to USERGUIDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hs = msgbox({'���ʹ�ð���:';...
            '����һ����׵ĵ������ϳ�������������¹��ܣ�';'';...
            '1. ��ȡ������һ�������źţ�';...
            '2. ���ƶ��������źŵ�����ͼ��';...
            '3. �ж��ź��и����ڵ������㣻';...
            '4. ��ȡ�����źŵ���������';...
            '4. �����α�Ը���Ȥ���źŶν�����������';'';...
            '���У������������У�';...
            '        ��ʱ����';'        ��ʱƽ������';'        ��ʱ������';...
            '        ����Ƶ��';'';...
            '�����չʾ�����Լ������Ƶ�ʵĶ��ֺ������Σ�������';
            '        ������ʱ����غ���';...
            '        ������ʱƽ�����Ȳ��';...
            '        ��ʱ����غ���';...
            '        ��ʱƽ�����Ȳ��';...
            '        ������ʱ����غ���/ƽ�����Ȳ��';'';...
            },'UserGuide');
%�ı������С
ht = findobj(hs, 'Type', 'text');
set(ht,'FontSize',12);
%�ı�Ի����С
set(hs, 'Resize', 'on'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             �˵�����                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% �˵� - ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function greatoctavetwo_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctavetwo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 0;         % ������ֶ���
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
set(handles.edit_notegroup,'string','���ֶ���');

% --------------------------------------------------------------------
function greatoctaveone_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctaveone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 1;          % �������һ��
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
set(handles.edit_notegroup,'string','����һ��');

% --------------------------------------------------------------------
function greatoctave_Callback(hObject, eventdata, handles)
% hObject    handle to greatoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 2;          % ���������
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
set(handles.edit_notegroup,'string','������');

% --------------------------------------------------------------------
function unaccentedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to unaccentedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 3;         % ����С����
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
set(handles.edit_notegroup,'string','С����');

% --------------------------------------------------------------------
function onelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to onelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 4;        % ����С��һ��
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
set(handles.edit_notegroup,'string','С��һ��');

% --------------------------------------------------------------------
function twolinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to twolinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 5;        % ����С�ֶ���
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
set(handles.edit_notegroup,'string','С�ֶ���');

% --------------------------------------------------------------------
function threelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to threelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 6;         % ����С������
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
set(handles.edit_notegroup,'string','С������');

% --------------------------------------------------------------------
function fourlinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to fourlinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 7;        % ����С������
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
set(handles.edit_notegroup,'string','С������');

% --------------------------------------------------------------------
function fivelinedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to fivelinedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.notegroup = 8;          % ����С������
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
set(handles.edit_notegroup,'string','С������');

%%%%%%%%%%%%%%%%%%%%%%%%%%% �˵� - ��ɫ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function noenvelope_sine_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global control;
control.timber = 'noenvelope_sine';
set(handles.edit_tone,'string',control.timber);
% ֻҪ����karplus-strong�������ζ��ǿɼ���
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
% ֻҪ����karplus-strong�������ζ��ǿɼ���
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
% ֻҪ����karplus-strong�������ζ��ǿɼ���
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
% ֻҪ����karplus-strong�������ζ��ǿɼ���
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
% ���ڹ��ܵľ����ԣ�С�������ϵľͲ�������
set(handles.threelinedoctave,'enable','off');
set(handles.fourlinedoctave,'enable','off');
set(handles.fivelinedoctave,'enable','off');
if control.notegroup == 6||7||8
    control.notegroup = 4;        % �Ļ�Ĭ�ϵ�С��һ��
end
set(handles.edit_notegroup,'string','С��һ��');


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
    q=warndlg('���棡����ʱ�������������������ӡ�','����');
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
    q=errordlg('��������ʱ��Ӧ��Ϊ������','����');
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
