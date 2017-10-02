% Translate the calculation of the weight matrix into Matlab expressions
w = zeros(N,N);
for i = 1:N
    w(i,:) = sum(bsxfun(@times,x(:,i),x));
    w(i,i) = 0;
end
% Translate the update rule into Matlab expressions
x_update = zeros(P,N);
for i = 1:N
    x_update(:,i) = sgn(sum(bsxfun(@times,w(i,:),x),2));
end