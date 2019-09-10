function varargout = mymidi(varargin)
% MYMIDI MATLAB code for mymidi.fig
%      MYMIDI, by itself, creates a new MYMIDI or raises the existing
%      singleton*.
%
%      H = MYMIDI returns the handle to a new MYMIDI or the handle to
%      the existing singleton*.
%
%      MYMIDI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYMIDI.M with the given input arguments.
%
%      MYMIDI('Property','Value',...) creates a new MYMIDI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mymidi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mymidi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mymidi

% Last Modified by GUIDE v2.5 19-Apr-2018 18:50:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mymidi_OpeningFcn, ...
                   'gui_OutputFcn',  @mymidi_OutputFcn, ...
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


% --- Executes just before mymidi is made visible.
function mymidi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mymidi (see VARARGIN)

% Choose default command line output for mymidi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mymidi wait for user response (see UIRESUME)
% uiwait(handles.figure_midi);

% --- Outputs from this function are returned to the command line.
function varargout = mymidi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object deletion, before destroying properties.
function figure_midi_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure_midi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --------------------------------------------------------------------
function uipushtool_play_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global midisignal;
sound(midisignal.y,midisignal.fs);

% --------------------------------------------------------------------
function uipushtool_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global midisignal;
midisignal.filename = 'midi';
extensionset = '.wav';
filename = uiputfile(extensionset,...
    '��.mid�ļ�����Ϊ.wav�ļ�',midisignal.filename);
if filename == 0
    return;
end
audiowrite(filename,midisignal.y,midisignal.fs);

% --------------------------------------------------------------------
function fileopen_Callback(hObject, eventdata, handles)
% hObject    handle to fileopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global midisignal;
global midi;
global midihandles;
[filename,pathname] = uigetfile('*.mid','��ѡ��Ҫ�򿪵��ļ�');
if filename == 0
    return;
end
filename = strcat(pathname,filename);
pos = strfind(filename,'.');
% �ļ���չ��
extension = filename(pos(end):end);
if ~strcmpi(extension,'.mid')
    error('�������.mid�ļ���');
else
    midi = readmidi(filename);
end

% ���ֱ������midi.m�ᱨ�����ų�������һ������֮����������û�ж���
% midisignal.fs������ġ���ʵ��midisignal.fs�Ķ����ڸ�����Mypiano.m��
% �Ѿ��ж����ˡ����Դ�ʱӦ�������и����档

% ��midi�ṹ��ת����һ�������ź�
switch midisignal.timber
    case 1
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_saw');
    case 2
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_square');
    case 3
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_sine');
    case 4
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,...
            '4seg_envelopes_sine');
    case 5
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'KarplusStrong');
end
% �ز����� 44100 Hz,������̫��������
if midisignal.fs ~= 44100
    midisignal.y = resample(midisignal.y,44100,midisignal.fs);
    midisignal.fs = 44100;
end
% ʱ���źŷ��ȹ�һ��
if max(midisignal.y)>1
    midisignal.y = midisignal.y/max(midisignal.y);     
end
midisignal.len = length(midisignal.y);
midisignal.t = (0:midisignal.len-1)/midisignal.fs;
% ���Ӵ���
midihandles=guihandles(gcf);    % �Զ������GUI�Ĵ��ھ������
axes(midihandles.axes_miditime);     % �Ӵ��ڵ�һ����ͼ
plot(midisignal.t,midisignal.y);
xlabel('ʱ��/s');ylabel('����');title('�����ļ���ʱ���ź�');
% ��midi�ṹ��ת����Note�������ʽ
Notes = midiInfo(midi,0);
% ����Note�������piano_roll�����Զ����ٴ��ֽ����ʾ���ݰ�������
[PR,tt,nn] = piano_roll(Notes,1);
axes(midihandles.axes_midipianoroll);   % �Ӵ��ڵڶ�����ͼ
imagesc(tt,nn,PR);
colorbar('SouthOutside');
axis xy;xlabel('ʱ��/s');ylabel('�������');title('�Զ����ֽ��');


% --------------------------------------------------------------------
function noenvelope_saw_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_saw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
midisignal.timber = 1;
global midi;
changemiditimber(midi,midisignal.timber)

% --------------------------------------------------------------------
function noenvelope_square_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
midisignal.timber = 2;
global midi;
changemiditimber(midi,midisignal.timber)

% --------------------------------------------------------------------
function noenvelope_sine_Callback(hObject, eventdata, handles)
% hObject    handle to noenvelope_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
midisignal.timber = 3;
global midi;
changemiditimber(midi,midisignal.timber)
% --------------------------------------------------------------------
function foursegmentenvelopes_sine_Callback(hObject, eventdata, handles)
% hObject    handle to foursegmentenvelopes_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
midisignal.timber = 4;
global midi;
changemiditimber(midi,midisignal.timber)

% --------------------------------------------------------------------
function KarplusStrong_Callback(hObject, eventdata, handles)
% hObject    handle to KarplusStrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
midisignal.timber = 5;
global midi;
changemiditimber(midi,midisignal.timber)


function changemiditimber(midi,timber_number)
global midisignal;
global midihandles;
switch timber_number
    case 1
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_saw');
    case 2
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_square');
    case 3
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'noenvelope_sine');
    case 4
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,...
            '4seg_envelopes_sine');
    case 5
        [midisignal.y,midisignal.fs] = midi2audio(midi,midisignal.fs,'KarplusStrong');
end
% �ز����� 44100 Hz,������̫��������
if midisignal.fs ~= 44100
    midisignal.y = resample(midisignal.y,44100,midisignal.fs);
    midisignal.fs = 44100;
end
% ʱ���źŷ��ȹ�һ��
if max(midisignal.y)>1
    midisignal.y = 0.95.*midisignal.y/max(midisignal.y);     
end
midisignal.len = length(midisignal.y);
midisignal.t = (0:midisignal.len-1)/midisignal.fs;

axes(midihandles.axes_miditime);     % �Ӵ��ڵ�һ����ͼ
plot(midisignal.t,midisignal.y);
xlabel('ʱ��/s');ylabel('����');title('�����ļ���ʱ���ź�');
% ��midi�ṹ��ת����Note�������ʽ
Notes = midiInfo(midi,0);
% ����Note�������piano_roll�����Զ����ٴ��ֽ����ʾ���ݰ�������
[PR,tt,nn] = piano_roll(Notes,1);
axes(midihandles.axes_midipianoroll);   % �Ӵ��ڵڶ�����ͼ
imagesc(tt,nn,PR);
colorbar('SouthOutside');
axis xy;xlabel('ʱ��/s');ylabel('�������');title('�Զ����ֽ��');