%% Try generating sparse patterns with just 10% activity 
% and see how many can be stored for different values of ? 
% (use a script to check different values of the bias).

% clc;
% clear;
% close all;

seed=20;
rng(seed)
x = sgn(-0.5+randn(30,8));
%% Here we will use binary (0,1) patterns, 
% since they are easier to use than bipolar (?1) patterns in this case 
x(x==-1)=0;

x_train = x(1:5,:);
[P,N]=size(x_train);
%% weight
activity = 0.01/(N*P)*sum(sum(x_train,1),2);
w = (x_train-activity)'*(x_train-activity);
index = 0;

%% slightly updated rule
for theta = -50:0.1:50
    index = index+1;
    x_previous = x_train;
    iteration = 0;
    x_update = zeros(P,N);
    while 1
        iteration = iteration+1;
        % update network(little model)
        x_update = 0.5+0.5*sgn(x_previous*w-theta);
        if isequal(x_update,x_previous)
            break;
        else
            x_previous = x_update;
        end       
    end
    x_learn = x(1:P,:)-x_update(1:P,:);
    % how many row is not zero?
    x_learn = x_learn(any(x_learn,2),:);
    [UNSTABLE,~] = size(x_learn);
    stable_patterns(index) = P-UNSTABLE;
    theta_change(index) = theta;
end
% figure
hold on;
plot(theta_change,stable_patterns,'r')
xlabel('Theta')
ylabel('Stable Patterns')

