clear all;
clc;
close all;

%% learn the sparse pattern
%% use 3*1024
x = zeros(1,300*1024);
rho=0.01;
index=randi([1,300*1024],1,floor(300*1024*rho));
x(index)=1;
x=reshape(x,300,1024);

newrho=mean(x(:));
%%
% There are P parterns 
% and N units/nodes (each node has P pattenrs) in the network
[P,N]=size(x);
%% Run the algorithm
x_previous = x;
iteration = 0;
index = 0;
x_update = zeros(P,N);
% calculate weight 
w = (x-newrho)'*(x-newrho);
w=w-diag(diag(w));
force=0;

for theta=-50:50
while 1
    iteration = iteration+1;
    % update network(little model)
    for i = 1:N
        x_update(:,i) = 0.5+0.5*sign(sum(bsxfun(@times,w(i,:),x_previous),2)-theta);
    end
    if isequal(x_update,x_previous)
        disp(['Reach fixpoint at ' num2str(iteration) ' itarations'])
        break;
    else
        x_previous = x_update;
    end  
    force=force+1;
    if force>1000
        break
    end
    
end
x_net = x_update;
compare=[x_net ;x];
countstable=0;
for i=1:3
    if isequal(x_net(i,:),x(i,:))
        countstable=countstable+1;
    end
end
temp(theta+51)=countstable;
end
plot(-50:50,temp);


