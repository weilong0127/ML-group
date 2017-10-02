% initial values
% Try out different numbers for ? and epochs
clear;
clc;
close all;
sepdata;
StepSize = 0.0001;
epochs = 20;
w = rand(1,3);
[insize, ndata] = size(patterns);
X = [patterns; ones(1,ndata)];
T = targets;

% delta rule
for i=1:epochs
    delta_w = -StepSize.*(w*X-T)*X';
    w = w+delta_w;
    % Inspect the separation line during the learning
    x1=-2:0.1:2;
    x2=-w(1,1)/w(1,2)*x1-w(1,3);

    plot (patterns(1, find(targets>0)), ...
          patterns(2, find(targets>0)), '*', ...
          patterns(1, find(targets<0)), ...
          patterns(2, find(targets<0)), '+', ...
          x1, x2, '-');
    %axis ([-2, 2, -2, 2], 'square');
    legend('ClassA','ClassB','separate line')
    drawnow;
    pause(1);
    
    yin = w*[patterns; ones(1,ndata)];
    yout = [2./(1+exp(-yin))-1];
    error(i) = sum(sum(abs(sign(yout) - targets)./2));
end

figure(2)
plot(1:i,error/ndata,'r')
grid on
xlabel('epochs')
ylabel('error')
title('error change following weight update(epochs)')
