function [PR,t,nn] = piano_roll(Notes,vel,ts)
%
% Inputs:
%  Notes: 从 midiInfo.m 返回的音符矩阵(N*8)
%  vel:   (可选) 若vel==1, set value to note velocity instead of 1. (默认 0)
%  ts:    (可选) time step of one 'pixel' 以秒为单位 (默认 0.01)
%
% Outputs:
%  PR:    PR(ni,ti): 在音符编号为ni，时刻编号为ti处（）的取值，只能取0/1
%          行数——音符数；列数——时刻标记数
%  t:     t(ti): 时刻编号为ti的时刻（以秒为单位）
%  nn:    nn(ni): note number at note index ti
%
%   (i.e. t and nn provide 'real-world units' for PR)
%

% Copyright (c) 2009 Ken Schutte
% more info at: http://www.kenschutte.com/midi

if nargin < 2
  vel = 0;
end
if nargin < 3
  ts = 0.01;
end

Nnotes = size(Notes,1);

n1 = round(Notes(:,5)/ts)+1; % start tics
n2 = round(Notes(:,6)/ts)+1; % end tics

if vel == 0
  vals = ones(Nnotes,1);
else
  vals = Notes(:,4); % velocity
end

Notes(:,3) = Notes(:,3) + (Notes(:,3)==0); % correct zeros in the tone
PR = zeros(max(Notes(:,3)), max(n2));

for i=1:Nnotes
  PR(Notes(i,3), n1(i):n2(i)) = vals(i);
end

% create quantized time axis:
t = linspace(0,max(Notes(:,6)),size(PR,2));
% note axis:
nn = min(Notes(:,3)):max(Notes(:,3));
% truncate to notes used:
PR = PR(nn,:);
