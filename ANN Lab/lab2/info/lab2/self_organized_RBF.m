clc;
clear all;
close all;

plotinit
data=read('cluster');
units=5;


% initialize the units randomly in space
vqinit;
%vqiter;
% single winner strategy
singlewinner=1;

vqstep;
% try to run the algorithm a few steps
% for i=1:10
%     vqstep;
%     vqinit;
%     vqiter;
%     pause(0.5)
% end

%vqiter;
hold on;
title('singlewinner=1')
%print('lab2/singlewinner=1','-dpng')