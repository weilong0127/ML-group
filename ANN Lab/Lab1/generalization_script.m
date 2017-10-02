%this is for generalization the network
%use the original data set Class A and Class B
clear all;
close all;
clc;

nsepdata;

hidden=4;
eta=0.001;
alpha=0.9;
epoch=2000;

deviation = 1/sqrt(insize);
for i=1:hidden
    w(i,:) = deviation.*randn(1,insize+1);
end
for i=1:outsize
    v(i,:) = deviation.*randn(1,hidden+1);
end
% w= 1/sqrt(insize).*rand(hidden,insize+1);
% v= 1/sqrt(insize).*rand(outsize,hidden+1);
dw= zeros(hidden,insize+1);
dv= zeros(outsize,hidden+1);
%n is the number of training data points
n=10;
train_patterns=patterns(:,1:n);
train_targets=targets(1:n);

for i=1:epoch
    %Firstly,the forward pass
    %hin for H*, hout for H, oin for O* and out for O
    hin  = w*[train_patterns ; ones(1,n)];
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,n)];
    
    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;
    
    %Secondly,the backward pass
    delta_o = (out - train_targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :);
    
    %Finally,perform the actual weight update
    dw = (dw .* alpha) - (delta_h * [train_patterns ; ones(1,n)]') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    %     error(i) = sum(sum(abs(sign(out) - targets)./2));
    %     if error(i)/ndata<=0.05
    %         break;
    %     end
end
weight=w
%%
%calculate the test error
hin  = w*[patterns ; ones(1,ndata)];
hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

oin = v * hout;
out = 2 ./ (1+exp(-oin)) - 1;

error = sum(sum(abs(sign(out) - targets)./2))
error/ndata

