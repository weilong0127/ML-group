% generate two classes with one hundred data points
classA(1,:) = randn(1,100) .* 0.5 + 1.0;
classA(2,:) = randn(1,100) .* 0.5 + 0.5;
classB(1,:) = randn(1,100) .* 0.5 - 1.0;
classB(2,:) = randn(1,100) .* 0.5 + 0.0;

% put together all points to a single matrix
patterns = [classA, classB];

% create a matrix targets with the correct answers
% class A correspond to the value 1 and class B to the value ?1
targets = [ones(1,100),ones(1,100).*(-1)];

% The points should come in a random order
permute = randperm(200);
patterns = patterns(:, permute);
targets = targets(:, permute);

[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

% look at where your data points end up
h1=plot (patterns(1, find(targets>0)), ...
    patterns(2, find(targets>0)), '*');
hold on;
h2= plot(patterns(1, find(targets<0)), ...
    patterns(2, find(targets<0)), '+g');
legend([h1,h2],'ClassA','ClassB')

