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
% 检测参数数目
narginchk(1,3);
nargoutchk(1,3);

% 获取参数数目
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
        error('输入参数不对。');
end

%初始化采样率,默认为44100
if isempty(fs)
    fs=44100;
elseif fs<round(f/2)
    error('信号采样率应大于信号频率的2倍。');
end
%初始化吉他余音时长，默认为1.5s
if isempty(dur)
    dur=1.5;
elseif dur<=0
    error('时间应当是一正数。');
end
%初始化参数p，默认为0.5
if isempty(r)
    r=0.5;
elseif r>=1 || P<=0
    error('参数p的范围应当是0-1。');
end

lenoft = length((0:1/fs:dur));
% karplus-strong算法
N=max(ceil(fs*dur),lenoft);  % 这一时间段内段总的点数，必须为整数
period=floor(fs/f);          % 周期，以点数为单位，必须为整数
np=floor(N/period);          % np是每一段的长度，点数为单位。
N_after=period*np;           % 合成信号的实际样点，总长度为 N_after<N
y=zeros(N_after,1);
% 确保变换前后长度相等，则不够的补零
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
y=y.*linspace(1,0,N)';    % 声音渐消的效果

switch nargout
    case 1
        varargout={y};
    case 2
        varargout={y,fs};
    case 3
        varargout={y,fs,N_after};
end