clear all;
clc;
close all;
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
%% Update
x_previous = x;
iteration = 0;
x_update = zeros(P,N);
while 1
    iteration = iteration+1;
    % update network
%     for i = 1:N
%         x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
%     end
    x_update = sgn(x_previous*w);
    % check convergence
    if isequal(x_update,x_previous)
        disp(['The network converges after ' num2str(iteration) ' iterations.'])
        x_net = x_update;
        break;
    else
        x_previous = x_update;
    end     
end
%% 1) Can  the network complete a degraded pattern? 
% Try the pattern p11, which is a degraded version of p1, or p22 which is a mixture of p2 and p3.
%% learn the distorted
x = p11;
%% recall the stored patterns from distorted inputs patterns
for i = 1:N
    x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
end
x_recall = x_update;
%% display
figure(1)
subplot(131)
vis(x_net(1,:));
title('original version')
subplot(132)
vis(p11);
title('distorted version')
subplot(133)
vis(x_recall(1,:));
title('recall version')
%% learn the distorted
x = p22;
%% recall the stored patterns from distorted inputs patterns
for i = 1:N
    x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
end
x_recall = x_update;
%% display
figure(2)
subplot(231)
vis(p2);
title('original version p2')
subplot(232)
vis(p22);
title('mixture version(p2,p3)')
subplot(233)
vis(x_recall(2,:));
title('recall version p2')

subplot(234)
vis(p3);
title('original version p3')
subplot(235)
vis(p22);
title('mixture version(p2,p3)')
subplot(236)
vis(x_recall(3,:));
title('recall version p3')
