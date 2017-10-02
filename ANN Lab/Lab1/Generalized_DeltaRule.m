%%
%hidden nodes, the # of hidden nodes corresponds to the sperate lines
%the prior knowledge of the data space,we can see two lines can split the
%data space
hidden=3;
eta=0.001;
alpha=0.9;

epoch=50000;
% The intial weight is Gaussian distributed around zero
% with standard deviation 1/sqrt(datapoint's dimension)
deviation = 1/sqrt(insize);
for i=1:hidden
    w(i,:) = deviation.*randn(1,insize+1);
end
for i=1:outsize
    v(i,:) = deviation.*randn(1,hidden+1);
end
% w= 1/sqrt(insize).*rand(hidden,insize+1);
% v= 1/sqrt(insize).*rand(outsize,hidden+1);
dw= zeros(hidden,insize+1);
dv= zeros(outsize,hidden+1);

% hin  = w*[patterns ; ones(1,ndata)];
% hout = [2 ./ (1+exp(-hin)) - 1 ; ones(1,ndata)];
% oin = v * hout;
% out = 2 ./ (1+exp(-oin)) - 1;

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
    
    
    error(i) = sum(sum(abs(sign(out) - targets)./2));
    if error(i)/ndata<=0.05
        break;
    end
    % See after how many iterations, the error is zero
    if error(i)==0
        break;
    end
end
% 
% % axis ([-2, 2, -2, 2], 'square');
% % plot (patterns(1, find(targets>0)), ...
% %           patterns(2, find(targets>0)), '*', ...
% %           patterns(1, find(targets<0)), ...
% %           patterns(2, find(targets<0)), '+');
% % 
% %       
% % for j=1:hidden
% %     % Inspect the separation line during the learning
% %     p = w(j,1:2);
% %     k = -w(j, insize+1) / (p*p');
% %     l = sqrt(p*p');
% %     hold on;
% %     plot ([p(1), p(1)]*k + [-p(2), p(2)]/l, ...
% %           [p(2), p(2)]*k + [p(1), -p(1)]/l, '-');
% % 
% %     drawnow;
% % end
% 
% 
figure(2)
plot(1:i,error/ndata)
title('error rate')
disp(sprintf('total_iteration = %d',i))





