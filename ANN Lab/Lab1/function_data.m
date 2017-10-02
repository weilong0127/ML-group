% Function data
clear all;
close all;
clc;
x=[-5:1:5]';
y=x;
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;
subplot(221)
mesh (x, y, z);
title('bell shaped Gauss')

% ndata:product of the number of element in x and in y
gridsize = size(x,1);
% ny = size(y,1);
ndata = gridsize*gridsize;

targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
figure
out=GR(6);
subplot(121)
zz = reshape(out, gridsize, gridsize);
mesh(x,y,zz);
axis([-5 5 -5 5 -0.7 0.7]);
drawnow;
title('approximated bell shaped Gauss,hidden=6')
% out=GR(48);
% subplot(223)
% zz = reshape(out, gridsize, gridsize);
% mesh(x,y,zz);
% axis([-5 5 -5 5 -0.7 0.7]);
% drawnow;
% title('approximated bell shaped Gauss,hidden=48')
out=GR(200);
subplot(122)
zz = reshape(out, gridsize, gridsize);
mesh(x,y,zz);
axis([-5 5 -5 5 -0.7 0.7]);
drawnow;
title('approximated bell shaped Gauss,hidden=200')



