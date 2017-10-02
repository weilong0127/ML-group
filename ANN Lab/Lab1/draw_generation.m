%draw generation
tic
close all;
n=200;
for hidden=2:100
test_error(hidden) = generalization(hidden,n);
end
plot(2:100,test_error(2:100))
ylabel('test error')
xlabel('hidden nodes')
title('training points n=200')
toc