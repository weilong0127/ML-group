% initial values
% Try out different numbers for ? and epochs
clear;
clc;
close all;
nsepdata;
StepSize = 0.001;
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
    p = w(1,1:2);
    k = -w(1, insize+1) / (p*p');
    l = sqrt(p*p');
    subplot(1,2,1)
    plot (patterns(1, find(targets>0)), ...
          patterns(2, find(targets>0)), '*', ...
          patterns(1, find(targets<0)), ...
          patterns(2, find(targets<0)), '+', ...
          [p(1), p(1)]*k + [-p(2), p(2)]/l, ...
          [p(2), p(2)]*k + [p(1), -p(1)]/l, '-');
    
    axis ([-2, 2, -2, 2], 'square');
    drawnow;
    pause(0.5);
    
    yin = w*[patterns; ones(1,ndata)];
    yout = [2./(1+exp(-yin))-1];
    error(i) = sum(sum(abs(sign(yout) - targets)./2));
end
legend('ClassA','ClassB','separate line')
subplot(122)
plot(1:i,error/ndata,'r')
grid on
xlabel('epochs')
ylabel('error')
title('error change following weight update(epochs)')
