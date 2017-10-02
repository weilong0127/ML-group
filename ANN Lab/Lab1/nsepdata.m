% generate two classes that are not linearly separable
classA(1,:) = [randn(1,50) .* 0.2 - 1.0, ...
               randn(1,50) .* 0.2 + 1.0];
classA(2,:) = randn(1,100) .* 0.2 + 0.3;
classB(1,:) = randn(1,100) .* 0.3 + 0.0;
classB(2,:) = randn(1,100) .* 0.3 - 0.1;

% put together all points to a single matrix
patterns = [classA, classB];

% create a matrix targets with the correct answers
% class A correspond to the value 1 and class B to the value ?1
targets = [ones(1,100),ones(1,100).*(-1)];

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

% The points should come in a random order
permute = randperm(200);
patterns = patterns(:, permute);
targets = targets(:, permute);

% look at where your data points end up
% plot (patterns(1, find(targets>0)), ...
%           patterns(2, find(targets>0)), '*', ...
%           patterns(1, find(targets<0)), ...
%           patterns(2, find(targets<0)), '+');
%       legend('ClassA','ClassB')