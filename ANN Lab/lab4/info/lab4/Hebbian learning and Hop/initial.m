clear all;
clc;
close all;
% the utility function vm(x):
% translate a vector from the binary format into the bipolar
disp(['Three test patterns'])
x1=vm([0 0 1 0 1 0 0 1])
x2=vm([0 0 0 0 0 1 0 0])
x3=vm([0 1 1 0 0 1 0 1])
% To make the pattern vectors as easy as possible
% read and write we define them as row vectors.
x = [x1;x2;x3];
% There are 3 parterns
P = 3;
% There are 8 units/nodes (each node has 3 pattenrs) in the network
N = 8;

