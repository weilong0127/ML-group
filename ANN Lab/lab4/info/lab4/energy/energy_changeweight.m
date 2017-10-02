%lear all;
clc;
close all;
%%Load the file pict.m
%contains nine patterns named p1, p2, p3, p4, p5, p6, p7, p8 and p9
pict
%% train network with first three
x = [p1;p2;p3];
[P,N]=size(x);
%% 5) Generate a weight matrix by setting the weights to normally distributed random numbers, 
% and try iterating an arbitrary starting state. What happens?
arbitrary_start = 50;
%% weight
w=x'*x;
w=w-diag(diag(w));
%% Update
x_previous = x;
iteration = 0;
x_update = zeros(P,N);
%choose how many units to update
many=50;
while 1
    iteration = iteration+1;
    if iteration == arbitrary_start
        w = normrnd(0,1,[N N]);
        w = w-diag(diag(w));
    end
    % update network
    %choose which units needed to be updated randomly
    units=randi([1,1024],1,many);
    for i = 1:length(units)
        % select units randomly and calculate their new state
        % randomly update the units
            x_update(:,units(i)) = sgn(sum(bsxfun(@times,w(units(i),:),x_previous),2));
    end
    E(iteration) = -sum(sum(w.*(x_update'*x_update),1),2);
    x_previous = x_update;
    if iteration>=1000
        break;
    end
end
figure(1)
plot(E)
title({['energy changes in sequential update'];['with 3 patterns'];...
    ['change weight at the 50th iteration']});
figure(2)
plot(E,'b')  
%% 6) Make the weight matrix symmetric (e.g. by setting w=0.5*(w+w')). What happens now? Why?
%% weight
w=x'*x;
w=w-diag(diag(w));
%% Update
x_previous = x;
iteration = 0;
x_update = zeros(P,N);
%choose how many units to update
many=50;
while 1
    iteration = iteration+1;
    if iteration == arbitrary_start
        w = normrnd(0,1,[N N]);
        w=0.5*(w+w');
        w = w-diag(diag(w));
    end
    % update network
    %choose which units needed to be updated randomly
    units=randi([1,1024],1,many);
    for i = 1:length(units)
        % select units randomly and calculate their new state
        % randomly update the units
            x_update(:,units(i)) = sgn(sum(bsxfun(@times,w(units(i),:),x_previous),2));
    end
    E(iteration) = -sum(sum(w.*(x_update'*x_update),1),2);
    x_previous = x_update;
    if iteration>=1000
        break;
    end
end
hold on;
plot(E,'r')
title({['energy changes in sequential update'];['with 3 patterns'];...
    ['change weight at the 50th iteration']});



