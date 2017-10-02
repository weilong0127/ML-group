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
    for i = 1:N
        x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
    end
    if isequal(x_update,x_previous)
        disp(['Reach fixpoint at ' num2str(iteration) ' itarations'])
        break;
    else
        x_previous = x_update;
    end       
end
%% STEP2:Distortion Resistance
index = 0;
for noisepoints=5:20:1024
    index = index+1;
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
    noise(index) = noisepoints;
    noisepoints_remain(index) = nnz(x_net(1,:)-p1);
    noisepoints_reduce(index)=noisepoints-noisepoints_remain(index);
end
% display plot
noise_percentage = noisepoints_remain./1024;
figure(1)
plot(noise,noise_percentage)
title('how many percentage of noise?(unit:%)')
grid on;

figure(2)
plot(noise,noisepoints_remain)
title('how many noisepoints?(unit:number)')
grid on;