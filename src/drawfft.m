function varargout=drawfft(x,fs,dur,varargin)
%%DRAWXT - draw the time-domain signal 
% 
%   This function draw the x-t plot of a 1-D signal
% 
%   drawfft(x,fs,dur)
%   drawfft(x,fs,dur,option)
%   [y,h_f] = drawfft(...)
% 
%   option:{color,linestyle,linewidth,marker,...
%           markeredgecolor,markerfacecolor,markersize}

%% ������
narginchk(3,10);
nargoutchk(0,2);

narg = numel(varargin);
color = [];
linestyle = '';
linewidth = [];
marker = '';
markeredgecolor = [];
markerfacecolor = [];
markersize = [];

switch narg
    case 1
        color = varargin{:};
    case 2
        [color,linestyle] = varargin{:};
    case 3
        [color,linestyle,linewidth] = varargin{:};
    case 4
        [color,linestyle,linewidth,marker] = varargin{:};
    case 5
        [color,linestyle,linewidth,marker,markeredgecolor] = varargin{:};
    case 6
        [color,linestyle,linewidth,marker,markeredgecolor,...
            markerfacecolor]= varargin{:};
    case 7
        [color,linestyle,linewidth,marker,markeredgecolor,...
            markerfacecolor,markersize] = varargin{:};
    otherwise
        error('�������������������');
end

if isempty(color)   % Ĭ��Ϊ��ɫ
    color=[0,0,1];
elseif max(color)>1 || min(color)<0
    error('������������ȷ��ɫ��ȡֵ��');
end

if isempty(linestyle)   % Ĭ��Ϊ'-',������
    linestyle='-';
elseif ~any(strcmpi(linestyle,{'-','--',':','-.','none'}))
    error('������ѡ����ȷ���������ࡣ');
end

if isempty(linewidth)   % �߿�Ĭ��Ϊ0.5
    linewidth=0.5;
elseif linewidth <= 0
    error('�����߿�ӦΪ������');
end

if isempty(marker)   % Ĭ��Ϊ'none',����͹�Ա�ǵ�
    marker='none';
elseif ~any(strcmpi(marker,{'o','+','*','.','x','square','s',...
        'diamond','d','^','v','>','<','pentagram','p',...
        'hexagram','h','none'}))
    error('������ѡ����ȷ�ı�ǵ����ࡣ');
end

if isempty(markeredgecolor)   % ��ǵ��Եɫ�ʣ�Ĭ��Ϊ������ͬɫ
    markeredgecolor='auto';
% isvector('auto')==1,max('auto')==117!
elseif isvector(markeredgecolor) && length(markeredgecolor)==3
        if max(markeredgecolor)>1 || min(markeredgecolor)<0
            error('������ѡ����ȷ��ɫ��ȡֵ��');
        end
elseif ~any(strcmpi(markeredgecolor,{'none','auto'}))  % �������ַ�
    error('������ѡ����ȷ��ɫ��ȡֵ��');
end

if isempty(markerfacecolor)   % ��ǵ��м�ɫ�ʣ�Ĭ��Ϊ��ɫ
    markerfacecolor='none';
% isvector('auto')==1,max('auto')==117!
elseif isvector(markerfacecolor) && length(markerfacecolor)==3
        if max(markerfacecolor)>1 || min(markerfacecolor)<0
            error('������ѡ����ȷ��ɫ��ȡֵ��');
        end
elseif ~any(strcmpi(markerfacecolor,{'none','auto'}))  % �������ַ�
    error('������ѡ����ȷ��ɫ��ȡֵ��');
end
    
if isempty(markersize)   % ��ǵ�ߴ�Ĭ��Ϊ6
    linewidth=6;
elseif linewidth <= 0
    error('���󣡱�ǵ�ߴ�ӦΪ������');
end

%% ����ͼ��
if ~isvector(x)
    error('����������һά������');
else
    x=x(:);
end
N = round(fs*dur);
N=max( 1024,power(2,ceil(log2(N))) );
y=abs(fft(x,N));
y=y(:);
f=0:fs/(N-1):fs/2;
f=f(:);
h_f=plot(f(1:round(N/2)),y(1:round(N/2)),'color',color,'LineStyle',linestyle,...
    'LineWidth',linewidth,'Marker',marker,'markerEdgeColor',...
    markeredgecolor,'MarkerFaceColor',markerfacecolor,...
    'MarkerSize',markersize);
xlabel('Ƶ��/Hz');ylabel('����');

switch nargout
    case 1
        varargout={y};
    case 2
        varargout={y,h_f};
end