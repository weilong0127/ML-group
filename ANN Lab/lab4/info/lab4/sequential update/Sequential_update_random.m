clear all;
clc;
close all;
tic
%%Load the file pict.m
%contains nine patterns named p1, p2, p3, p4, p5, p6, p7, p8 and p9
pict
%% learn the network with first three
x = [p1;p2;p3];
[P,N]=size(x);
%% Weight
w = zeros(N,N);
for i = 1:P
    w = w + x(i,:)'* x(i,:);
end
w=w-diag(diag(w));
%% What happens if we select units randomly,
% calculate their new state and then repeat the process 
% (the original sequential Hopfield dynamics)?
%% Update
x_previous = x;
iteration = 0;
index = 0;
x_update = zeros(P,N);
%choose how many units to update
many=10;
%fore to break
fore=0;
while 1
    iteration = iteration+1;
    % update network
    % choose which units needed to be updated randomly
    units=randi([1,1024],1,many);
    for i = 1:length(units)
        % select units randomly and calculate their new state
        % randomly update the units
            x_update(:,units(i)) = sgn(sum(bsxfun(@times,w(units(i),:),x_previous),2));
    end
    % showing the image every hundredth iteration
    if rem(iteration,100)==1
        index = index+1;
        subplot(2,5,index)
        vis(x_update(1,:));
    end
    x_previous = x_update;
    fore = fore+1;
    if fore>=1000
        break;
    end
end
suptitle('sequential update of p1')
toc