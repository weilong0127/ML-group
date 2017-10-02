tic
clear all;
close all;
clc;
patterns = eye(8) * 2 - 1;
targets = patterns;
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

Generalized_DeltaRule
sign(w)
toc