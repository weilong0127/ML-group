clear all;
clc;
close all;
% the utility function vm(x):
% translate a vector from the binary format into the bipolar
disp(['Three test patterns'])
x1=vm([0 0 1 0 1 0 0 1])
x2=vm([0 0 0 0 0 1 0 0])
x3=vm([0 1 1 0 0 1 0 1])
% To make the pattern vectors as easy as possible
% read and write we define them as row vectors.
x = [x1;x2;x3];
% There are 3 parterns
P = 3;
% There are 8 units/nodes (each node has 3 pattenrs) in the network
N = 8;

iteration = 0;
tf = 0;
x_previous = x;
w = zeros(N,N);
% Translate the calculation of the weight matrix into Matlab expressions
for i = 1:N
    w(i,:) = sum(bsxfun(@times,x(:,i),x));
    w(i,i) = 0;
end
%%
while 1
    % count how many iterations reach fixpoints
    iteration = iteration+1;
    % Translate the update rule into Matlab expressions
    x_update = zeros(P,N);
    for i = 1:N
        x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x_previous),2));
    end
    
    % Check if the network is able to store all three patterns.
    tf = isequal(x,x_update);
    if tf
        disp(['The network is able to store all three patterns after ' num2str(iteration) ' iterations.'])
    end
    
    % Check Convergence
    % If two updates give the same network(x_current),
    % which is the same as the input pattern,
    % the network reaches its fixpoints
    if tf && isequal(x_previous,x_update)
    % break the loop
        disp(['The network converges and reaches the fixpoints.'])
        disp(['  '])
        disp(['  '])
        disp(['The final network is'])
        x_net = x_update
        break;
    else
        x_previous = x_update;
    end
end

    