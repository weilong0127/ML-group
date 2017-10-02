clear all;
clc;
close all;
%% 1) Apply the update rule repeatedly until you reach a stable fixpoint.
% Did all the patterns converge towards stored patterns?
%% Train network with correct version
x1=vm([0 0 1 0 1 0 0 1])
x2=vm([0 0 0 0 0 1 0 0])
x3=vm([0 1 1 0 0 1 0 1])
x = [x1;x2;x3];
[P,N] = size(x);
%% Weight
for i = 1:N
    w(i,:) = sum(bsxfun(@times,x(:,i),x));
    w(i,i) = 0;
end
w=w-diag(diag(w));
%% Update
iteration = 0;
tf = 0;
force=0;
x1d=vm([1 0 1 0 1 0 0 1]);
x2d=vm([1 1 0 0 0 1 0 0]);
x3d=vm([1 1 1 0 1 1 0 1]);
x = [x1d;x2d;x3d];
x_previous = x;
while 1
    iteration = iteration+1;
    x_update = zeros(P,N);
    for i = 1:N
        x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
    end
    tf = isequal(x,x_update);
    if tf
        disp(['The network is able to store all three patterns after ' num2str(iteration) ' iterations.'])
    end
    if tf && isequal(x_previous,x_update)
    % break the loop
        x_net = x_update
        break;
    else
        x_previous = x_update;
    end
    force=force+1;
    if force>30 
        disp('i am break haha and not stored to original');
        break;
    end
end
x_net = x_update
%% 2) How many attractors are there in this network? Hint: automate the searching.
%% distorted inputs patterns
% x1d has a one bit error, x2d and x3d have two bit errors.
x1d=vm([1 0 1 0 1 0 0 1]);
x2d=vm([1 1 0 0 0 1 0 0]);
x3d=vm([1 1 1 0 1 1 0 1]);
x = [x1d;x2d;x3d];
%% recall the stored patterns from distorted inputs patterns
% x_recall = sgn(x*w)
for i = 1:N
    x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
end
x_recall = x_update
% automate the searching of attractors
Count = 0;
for i = 1:P
    if isequal(x_net(i,:),x_recall(i,:))
        Count = Count+1;
    end
end
Count_attractors_1 = Count
%% 3) What happens when you make the starting pattern even more dissimilar to the stored ones
% (e.g. more than half is wrong)?
x1d=vm([1 1 0 1 1 0 0 1])
x2d=vm([1 1 0 0 0 0 1 1])
x3d=vm([1 1 1 0 0 1 1 0])
x = [x1d;x2d;x3d];
% recall the stored patterns from distorted inputs patterns
% x_recall = sgn(x*w)
for i = 1:N
    x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
end
x_recall = x_update
% automate the searching of attractors
Count = 0;
for i = 1:P
    if isequal(x_net(i,:),x_recall(i,:))
        Count = Count+1;
    end
end
Count_attractors_2 = Count