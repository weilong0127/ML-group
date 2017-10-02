%%
%hidden nodes, the # of hidden nodes corresponds to the sperate lines
%the prior knowledge of the data space,we can see two lines can split the
%data space
clear;
close all;
clc;

nsepdata;
hidden=4;
eta=0.001;
alpha=0.9;

epoch=2000;
w= rand(hidden,3);
%w=[1,1,0;-1,-1,0];
dw= zeros(hidden,3);
v=rand(1,hidden+1);
v= [rand(1,hidden),0];
%v=[1,1,0];
dv= zeros(1,hidden+1);

for i=1:epoch
    %Firstly,the forward pass
    %hin for H*, hout for H, oin for O* and out for O
    hin  = w*[patterns ; ones(1,ndata)];
    hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];

    oin = v * hout;
    out = 2 ./ (1+exp(-oin)) - 1;

    %Secondly,the backward pass
    delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
    delta_h = (v' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
    delta_h = delta_h(1:hidden, :);

    %Finally,perform the actual weight update
    dw = (dw .* alpha) - (delta_h * [patterns ; ones(1,ndata)]') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
%     p = bsxfun(@times,w(:,1:2),v(1:2);
%     for j=1:hidden
%         % Inspect the separation line during the learning
%         p = w(j,1:2)*v(j);
%         k = -w(j, insize+1) / (p*p');
%         l = sqrt(p*p');
%         hold on;
%         plot ([p(1), p(1)]*k + [-p(2), p(2)]/l, ...
%               [p(2), p(2)]*k + [p(1), -p(1)]/l, '-');
%         
%         drawnow;
%     end
    
%     pause(1);
    
    error(i) = sum(sum(abs(sign(out) - targets)./2));
%     if error(i)/ndata<=0.05
%         break;
%     end
end

axis ([-2, 2, -2, 2], 'square');
plot (patterns(1, find(targets>0)), ...
          patterns(2, find(targets>0)), '*', ...
          patterns(1, find(targets<0)), ...
          patterns(2, find(targets<0)), '+');

      
for j=1:hidden
    % Inspect the separation line during the learning
    p = w(j,1:2)*v(j);
    k = -w(j, insize+1) / (p*p');
    l = sqrt(p*p');
    hold on;
    plot ([p(1), p(1)]*k + [-p(2), p(2)]/l, ...
          [p(2), p(2)]*k + [p(1), -p(1)]/l, '-');

    drawnow;
end


figure(2)
plot(1:i,error/ndata)
grid on
xlabel('epochs')
ylabel('error')
title('error change following weight update(epochs)')



