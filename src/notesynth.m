function varargout=notesynth(f,dur,varargin)
%NOTESYNTH - This function synthesize a single note
%
%   y=notesynth(f,dur) 
%   y=notesynth(f,dur,amp)
%   y=notesynth(f,dur,fs,amp)
%   y=notesynth(f,dur,fs,amp,type)
% 
%   type:{'noenvelope_sine'},'noenvelope_saw','noenvelope_square',...
%           '4seg_envelopes_sine','KarplusStrong'.

%% 检查参数数目
narginchk(2,5);
nargoutchk(1,1);

% 获取参数数目
narg=numel(varargin);
amp=[];
fs=[];
type='';

switch narg
    case 0
    case 1
        fs = varargin{:};
    case 2
        [fs,amp] = varargin{:};
    case 3
        [fs,amp,type] = varargin{:};
    otherwise
        error('输入参数不对。');
end

 % 参数判断
if isempty(fs)
    fs = 8000;
elseif fs <= 0
    error('错误！采样率应为正数。');
end

N = floor(dur*fs);     % 音符在现有采样率下的样点数
if N <= 0
  error('错误！音符时长为非正数。');
end

if isempty(amp)
    amp = 1;
elseif isvector(amp) && length(amp)~=1
    if length(amp) ~= N
        error('错误！幅度向量与取值应当长度相等。');
    end
elseif amp <=0
    error('错误！幅度应为正数。');
end

t=0:1/fs:dur;   % length(t)=ceil(fs*dur) or ceil(fs*dur)+1

if strcmp(type,'noenvelope_sine')             % 合成正弦波
    x = amp.*sin(2*pi*f*t);   
elseif strcmp(type,'noenvelope_saw')          % 合成锯齿波
    T = (1/f)*fs;               % 音符的周期，以点数作为单位
    ramp = (0:N)/T;             % 斜率就是1/T,注意，t和x的长度一定要一致！
    x = ramp-fix(ramp);         % 不允许超过[0,1]的范围
    x = amp.*x;
    x = x - mean(x);
elseif strcmp(type,'noenvelope_square')
    x=sign(amp.*sin(2*pi*f*t));
elseif strcmp(type,'4seg_envelopes_sine')
    envel = interp1([0 dur/6 dur/3 dur/5 dur], [0 1 .75 .6 0], t);
    I_env = 5.*envel;
    x = envel.*sin(2.*pi.*f.*t + I_env.*sin(2.*pi.*f.*t));
elseif strcmp(type,'KarplusStrong')     % KarplusStrong合成算法
    x = KarplusStrong(f,fs,dur);
    x=x';    % 一行多列为了和其他的保持一致，好共同使用最后一段平滑代码
else
  error('错误！合成模式未知。');
end

% 边缘平滑。效果：前始后终不再过于突兀，体现一个渐变的过程
if (dur > 0.02)
  L = 2*fix(0.01*fs)+1;  % L 是奇数长度,0.02s
  ramp = bartlett(L)';  % odd length 巴特兰窗，移动的三角窗
  L = ceil(L/2);         %相当于只画出三角窗的左半部分，代表了0.01秒的样点
  x(1:L) = x(1:L) .* ramp(1:L);            % 前L个点，即前0.01s
  x(end-L+1:end) = x(end-L+1:end) .* ramp(end-L+1:end);  % 后L个点，即后0.01s
end
varargout = {x};
end