function [test_error] = generalization(hidden,n)
%hidden is the hidden nodes 
%n is the # of training data points
%this is for generalization the network
%use the original data set Class A and Class B

if (nargin < 2)
    hidden=4;
    n=100;
end

%%
%the data set
% generate two classes that are not linearly separable
classA(1,:) = [randn(1,500) .* 0.2 - 1.0, ...
               randn(1,500) .* 0.2 + 1.0];
classA(2,:) = randn(1,1000) .* 0.2 + 0.3;
classB(1,:) = randn(1,1000) .* 0.3 + 0.0;
classB(2,:) = randn(1,1000) .* 0.3 - 0.1;

% put together all points to a single matrix
patterns = [classA, classB];

% create a matrix targets with the correct answers
% class A correspond to the value 1 and class B to the value ?1
targets = [ones(1,1000),ones(1,1000).*(-1)];

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

% The points should come in a random order
permute = randperm(2000);
patterns = patterns(:, permute);
targets = targets(:, permute);
%%

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
%%
%calculate the test error
hin  = w*[patterns(:,n+1:end) ; ones(1,ndata-n)];
hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata-n)];

oin = v * hout;
out = 2 ./ (1+exp(-oin)) - 1;

error = sum(sum(abs(sign(out) - targets(n+1:end))./2));
test_error=error/ndata;

end

