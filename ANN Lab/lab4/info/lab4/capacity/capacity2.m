%% 1) How many patterns could safely be stored? 
% Was the drop in performance gradual or abrupt?
clear;
close all;
clc;
tic
%% load data
pict
%% STEP 1:train a network with p1, p2, p3...
x = [p1;p2;p3;p4;p5];
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
%% STEP2:display for comparison
for i=1:P
    figure;
    subplot(121);
    vis(x(i,:));
    title('original pattern');
    subplot(122)
    vis(x_update(i,:));
    title('learned pattern');
end