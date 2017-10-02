clear all
clc
close all
tic
% Input:
% x	: data training vector
% column vector for input pattern
x =0:0.1:2*pi;
x = x';
% units : number of RBF units
units = 25;

% compute positions and variances of RBF units
makerbf;

% eta:learning rate
eta = 0.1;
% mapping functions
fun = 'sin2x'

diter
toc