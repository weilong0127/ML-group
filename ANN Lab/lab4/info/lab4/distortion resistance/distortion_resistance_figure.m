clear;
close all;
clc;
tic
%% load data
pict
%% STEP 1:train a network with p1, p2, p3 with little model
x = [p1;p2;p3];
[P,N]=size(x);
x_previous = x;
iteration = 0;
x_update = zeros(P,N);
w = x'*x;
w=w-diag(diag(w));
while 1
    iteration = iteration+1;
    % update network(little model)
%     for i = 1:N
%         x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
%     end
    x_update = sgn(x_previous*w);
    if isequal(x_update,x_previous)
        disp(['Reach fixpoint at ' num2str(iteration) ' itarations'])
        break;
    else
        x_previous = x_update;
    end       
end
%% STEP2:Distortion Resistance
noisepoints = 500;
%% add noise to pattern
p1dist = flip1(p1,noisepoints);
x = p1dist;
[P,N]=size(x);
%% reconstruct noisy pattern with little model
% iterate it a number of times and check whether it has been successfully restored
iteration = 3;
x_noisy = x;
% use the pretrained network
x_net = x_update;
while iteration>0
    iteration = iteration-1;
    for i = 1:N
        x_net(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
    end
end
% display figures for comparison
figure;
subplot(131);
vis(p1);
title('original p1');
subplot(132)
vis(p1dist);
title('p1 add noise');
subplot(133)
vis(x_net(1,:));
title('reconstruct');
toc