clc;
close all;
clear all;

plotinit
data=read('cluster');
units=5;
% initialize the units randomly in space
vqinit;
initrbf()
% single winner strategy
singlewinner=0;

% batchwise EM in single step
%emstepb;
%title('batchwise batchwise EM in single step with 5 units')
%print('lab2/batchwise_EM(5units)_0','-dpng')

% EM iterate until convergence
for i=1:10
emiterb;
end

title('EM iterate until convergence with 3 units')
%print('lab2/iterate_EM(3units)_3','-dpng')
