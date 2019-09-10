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

%% ��������Ŀ
narginchk(2,5);
nargoutchk(1,1);

% ��ȡ������Ŀ
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
        error('����������ԡ�');
end

 % �����ж�
if isempty(fs)
    fs = 8000;
elseif fs <= 0
    error('���󣡲�����ӦΪ������');
end

N = floor(dur*fs);     % ���������в������µ�������
if N <= 0
  error('��������ʱ��Ϊ��������');
end

if isempty(amp)
    amp = 1;
elseif isvector(amp) && length(amp)~=1
    if length(amp) ~= N
        error('���󣡷���������ȡֵӦ��������ȡ�');
    end
elseif amp <=0
    error('���󣡷���ӦΪ������');
end

t=0:1/fs:dur;   % length(t)=ceil(fs*dur) or ceil(fs*dur)+1

if strcmp(type,'noenvelope_sine')             % �ϳ����Ҳ�
    x = amp.*sin(2*pi*f*t);   
elseif strcmp(type,'noenvelope_saw')          % �ϳɾ�ݲ�
    T = (1/f)*fs;               % ���������ڣ��Ե�����Ϊ��λ
    ramp = (0:N)/T;             % б�ʾ���1/T,ע�⣬t��x�ĳ���һ��Ҫһ�£�
    x = ramp-fix(ramp);         % ��������[0,1]�ķ�Χ
    x = amp.*x;
    x = x - mean(x);
elseif strcmp(type,'noenvelope_square')
    x=sign(amp.*sin(2*pi*f*t));
elseif strcmp(type,'4seg_envelopes_sine')
    envel = interp1([0 dur/6 dur/3 dur/5 dur], [0 1 .75 .6 0], t);
    I_env = 5.*envel;
    x = envel.*sin(2.*pi.*f.*t + I_env.*sin(2.*pi.*f.*t));
elseif strcmp(type,'KarplusStrong')     % KarplusStrong�ϳ��㷨
    x = KarplusStrong(f,fs,dur);
    x=x';    % һ�ж���Ϊ�˺������ı���һ�£��ù�ͬʹ�����һ��ƽ������
else
  error('���󣡺ϳ�ģʽδ֪��');
end

% ��Եƽ����Ч����ǰʼ���ղ��ٹ���ͻأ������һ������Ĺ���
if (dur > 0.02)
  L = 2*fix(0.01*fs)+1;  % L ����������,0.02s
  ramp = bartlett(L)';  % odd length �����������ƶ������Ǵ�
  L = ceil(L/2);         %�൱��ֻ�������Ǵ�����벿�֣�������0.01�������
  x(1:L) = x(1:L) .* ramp(1:L);            % ǰL���㣬��ǰ0.01s
  x(end-L+1:end) = x(end-L+1:end) .* ramp(end-L+1:end);  % ��L���㣬����0.01s
end
varargout = {x};
end