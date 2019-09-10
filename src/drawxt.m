function varargout = drawxt(t,x,varargin)
%%DRAWXT - draw the time-domain signal 
% 
%   This function draw the x-t plot of a 1-D signal
% 
%   drawxt(t,x)
%   drawxt(t,x,option)
% 
%   option:{color,linestyle,linewidth,marker,...
%           markeredgecolor,markerfacecolor,markersize}

%% 检查参数
narginchk(2,9);
nargoutchk(0,1);

narg = numel(varargin);
color = [];
linestyle = '';
linewidth = [];
marker = '';
markeredgecolor = [];
markerfacecolor = [];
markersize = [];

switch narg
    case 0
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
        error('错误！输入参数个数有误。');
end

if isempty(color)   % 默认为蓝色
    color=[0,0,1];
elseif max(color)>1 || min(color)<0
    error('错误！请输入正确的色彩取值。');
end

if isempty(linestyle)   % 默认为'-',即连线
    linestyle='-';
elseif ~any(strcmpi(linestyle,{'-','--',':','-.','none'}))
    error('错误！请选择正确的线条种类。');
end

if isempty(linewidth)   % 线宽默认为0.5
    linewidth=0.5;
elseif linewidth <= 0
    error('错误！线宽应为正数。');
end

if isempty(marker)   % 默认为'none',即不凸显标记点
    marker='none';
elseif ~any(strcmpi(marker,{'o','+','*','.','x','square','s',...
        'diamond','d','^','v','>','<','pentagram','p',...
        'hexagram','h','none'}))
    error('错误！请选择正确的标记点种类。');
end

if isempty(markeredgecolor)   % 标记点边缘色彩，默认为和线条同色
    markeredgecolor='auto';
% isvector('auto')==1,max('auto')==117!
elseif isvector(markeredgecolor) && length(markeredgecolor)==3
    if max(markeredgecolor)>1 || min(markeredgecolor)<0
        error('错误！请选择正确的色彩取值。');
    end
elseif ~any(strcmpi(markeredgecolor,{'none','auto'}))  % 可能是字符
    error('错误！请选择正确的色彩取值。');
end

if isempty(markerfacecolor)   % 标记点中间色彩，默认为无色
    markerfacecolor='none';
% isvector('auto')==1,max('auto')==117!
elseif isvector(markerfacecolor) && length(markerfacecolor)==3
    if max(markerfacecolor)>1 || min(markerfacecolor)<0
        error('错误！请选择正确的色彩取值。');
    end
elseif ~any(strcmpi(markerfacecolor,{'none','auto'}))  % 可能是字符
    error('错误！请选择正确的色彩取值。');
end

    
if isempty(markersize)   % 标记点尺寸默认为6
    linewidth=6;
elseif linewidth <= 0
    error('错误！标记点尺寸应为正数。');
end

%% 绘制图形
if ~isvector(x)
    error('错误！请输入一维向量。');
else
    x=x(:);
end
if ~isvector(t)
    error('错误！请输入一维向量。');
else
    t=t(:);
end
if length(t)==length(x)
h_t=plot(t,x,'color',color,'LineStyle',linestyle,...
    'LineWidth',linewidth,'Marker',marker,'MarkerEdgeColor',...
    markeredgecolor,'MarkerFaceColor',markerfacecolor,...
    'MarkerSize',markersize);
xlabel('时间/s');ylabel('幅度');
end

switch nargout
    case 0
        return;
    case 1
        varargout={h_t};
    otherwise
        error('错误！输出参数有误。');
end