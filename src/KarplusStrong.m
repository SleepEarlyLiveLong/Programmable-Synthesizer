function varargout=KarplusStrong(f,varargin)
%SYNGUITAI - synthetize sound of guitar of various tones
% 
%   y=synguitar(f) where f means synthesis frequency 
%   y=synguitar(f,fs) where fs means sampling rate 
%   y=synguitar(f,fs,dur) where dur means duration of the tone
%   y=synguitar(f,fs,dur,r) where r decides damping speed (0<p<1)
%   [y,fs,N]=synguitar(...) where N means length of the synthetized yone
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%% 
% ��������Ŀ
narginchk(1,3);
nargoutchk(1,3);

% ��ȡ������Ŀ
narg=numel(varargin);
fs=[];
dur=[];
r=[];

switch narg
    case 0
    case 1
        fs=varargin{:};
    case 2
        [fs,dur]=varargin{:};
    case 3
        [fs,dur,r]=varargin{:};
    otherwise
        error('����������ԡ�');
end

%��ʼ��������,Ĭ��Ϊ44100
if isempty(fs)
    fs=44100;
elseif fs<round(f/2)
    error('�źŲ�����Ӧ�����ź�Ƶ�ʵ�2����');
end
%��ʼ����������ʱ����Ĭ��Ϊ1.5s
if isempty(dur)
    dur=1.5;
elseif dur<=0
    error('ʱ��Ӧ����һ������');
end
%��ʼ������p��Ĭ��Ϊ0.5
if isempty(r)
    r=0.5;
elseif r>=1 || P<=0
    error('����p�ķ�ΧӦ����0-1��');
end

lenoft = length((0:1/fs:dur));
% karplus-strong�㷨
N=max(ceil(fs*dur),lenoft);  % ��һʱ����ڶ��ܵĵ���������Ϊ����
period=floor(fs/f);          % ���ڣ��Ե���Ϊ��λ������Ϊ����
np=floor(N/period);          % np��ÿһ�εĳ��ȣ�����Ϊ��λ��
N_after=period*np;           % �ϳ��źŵ�ʵ�����㣬�ܳ���Ϊ N_after<N
y=zeros(N_after,1);
% ȷ���任ǰ�󳤶���ȣ��򲻹��Ĳ���
if N_after < N
    lendiff = N-N_after;
    y=[y;zeros(lendiff,1)];
end
part=rand(period,1)-0.5;
part=part-mean(part);

for i=1:np
    part=part*r+[part(end);part(1:end-1)]*(1-r);
    pos = (i-1)*period+1;
    y(pos:pos+period-1)=part;
end
y=y.*linspace(1,0,N)';    % ����������Ч��

switch nargout
    case 1
        varargout={y};
    case 2
        varargout={y,fs};
    case 3
        varargout={y,fs,N_after};
end