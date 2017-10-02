function [ out] = GR( hidden)
%%
%hidden nodes, the # of hidden nodes corresponds to the sperate lines
%the prior knowledge of the data space,we can see two lines can split the
%data space
if nargin < 1
hidden=3;
end
eta=0.001;
alpha=0.9;
%%
%data set
x=[-5:1:5]';
y=x;
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;
gridsize = size(x,1);
% ny = size(y,1);
ndata = gridsize*gridsize;

targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);
%%
epoch=50000;
% The intial weight is Gaussian distributed around zero
% with standard deviation 1/sqrt(datapoint's dimension)
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

% hin  = w*[patterns ; ones(1,ndata)];
% hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
% oin = v * hout;
% out = 2 ./ (1+exp(-oin)) - 1;

for i=1:epoch
    %Firstly,the forward pass
    %hin for H*, hout for H, oin for O* and out for O
    hin  = w*[patterns ; ones(1,ndata)];
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;

    %Secondly,the backward pass
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :);

    %Finally,perform the actual weight update
    dw = (dw .* alpha) - (delta_h * [patterns ; ones(1,ndata)]') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
end



end

