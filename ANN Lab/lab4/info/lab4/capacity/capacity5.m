%% What happens if convergence to the pattern from a noisy version (a few flipped units) is used?
% What does the different behavior for large number of patterns mean?
% clear;
% close all;
% clc;
% tic
%% STEP 1:Create 300 random patterns
seed=20;
rng(seed)
x = sgn(randn(300,100));
%% STEP 2:train a 100 unit network with them
x_train = x(1:100,:);
noisepoints = 5;
x_train = flip1(x_train,noisepoints);
[P,N]=size(x_train);
x_previous = x_train;
iteration = 0;
x_update = zeros(P,N);
w = x_train'*x_train;
while 1
    iteration = iteration+1;
    % update network(little model)
    x_update = sgn(x_previous*w);
    if isequal(x_update,x_previous)
        disp(['Reach fixpoint at ' num2str(iteration) ' itarations'])
        break;
    else
        x_previous = x_update;
    end       
end
x_learn = x(1:P,:)-x_update(1:P,:);
x_learn = x_learn(any(x_learn,2),:);
[UNSTABLE,~] = size(x_learn);
stable_patterns(1) = 100-UNSTABLE;
patterns(1) = 0;
index = 1;
for p = 101:300
    index = index+1;
    % (1)add new patterns to the weight matrix
    w = w+x(p,:)'*x(p,:);
    % (2)run the network with little model for one time
    % (a single iteration does not cause them to change)
    x_update = sgn(x_previous*w);
    % (3)calculate how many earlier patterns remain stable
    x_train = x(1:P,:)-x_update(1:P,:);
    x_train = x_train(any(x_train,2),:);
    [UNSTABLE,~] = size(x_train);
    stable_patterns(index) = P-UNSTABLE;
    patterns(index)=p-P;
end
% plot it: how many stable patterns
hold on;
plot(patterns,stable_patterns,'r')
xlabel('Added Pattern Amount')
ylabel('Stable Patterns')
title('how many stable patterns after adding more patterns?')
toc