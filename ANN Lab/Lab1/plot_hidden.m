function [error] = plot_hidden(h)
%%
%hidden nodes, the # of hidden nodes corresponds to the sperate lines
%the prior knowledge of the data space,we can see two lines can split the
%data space


nsepdata;

if (nargin < 1)
    h=4;
end

eta=0.001;
alpha=0.9;

epoch=2000;
w= rand(h,3);
%w=[rand(hidden,2),0];
%w=[1,1,0;-1,-1,0];
dw= zeros(h,3);

%v=rand(1,hidden+1);
v= [rand(1,h),0];
%v=[1,1,0];
dv= zeros(1,h+1);

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
    delta_h = delta_h(1:h, :);

    %Finally,perform the actual weight update
    dw = (dw .* alpha) - (delta_h * [patterns ; ones(1,ndata)]') .* (1-alpha);
    dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
    w = w + dw .* eta;
    v = v + dv .* eta;
    
    
    error(i) = sum(sum(abs(sign(out) - targets)./2));

end
error=error/ndata;

% figure
% plot(1:i,error/ndata)
% grid on
% xlabel('epochs')
% ylabel('error')
% title('error change following weight update(epochs)')



end

