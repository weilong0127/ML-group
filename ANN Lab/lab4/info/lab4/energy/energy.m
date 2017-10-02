clear all;
clc;
close all;
%%Load the file pict.m
%contains nine patterns named p1, p2, p3, p4, p5, p6, p7, p8 and p9
pict
%% train network with first three
x = [p1;p2;p3];
[P,N]=size(x);
%% weight
w=x'*x;
w=w-diag(diag(w));
%% Update
x_previous = x;
iteration = 0;
x_update = zeros(P,N);
while 1
    iteration = iteration+1;
    % update network
    for i = 1:N
        x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
    end
    % check convergence
    if isequal(x_update,x_previous)
        disp(['The network converges after ' num2str(iteration) ' iterations.'])
        x_net = x_update;
        break;
    else
        x_previous = x_update;
    end     
end
%% 1) express energy function
All_E = -sum(sum(w.*(x_net'*x_net),1),2)
%% 2) What is the energy at the different attractors?
All_E = 0;
for i = 1:P
    E(i) = -sum(sum(w.*(x_net(i,:)'* x_net(i,:)),1),2);
    All_E = All_E+E(i);
end
E 
All_E
%% 3) What is the energy at the points of the distorted patterns?
% p11 means the distorted pattern
distort_E = -sum(sum(w.*(p11'*p11),1),2)
%% Follow how the energy changes from iteration to iteration 
% when you use the sequential update rule to approach an attractor.
%% update
x_previous = x;
iteration = 0;
index = 0;
x_update = zeros(P,N);
%choose how many units to update
many=50;
while 1
    iteration = iteration+1;
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
    ['randomly pick 100 units to update in each iteration']})