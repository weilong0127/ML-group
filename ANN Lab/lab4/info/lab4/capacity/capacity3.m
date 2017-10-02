%% 2) Try to repeat this with learning a few random patterns instead of the pictures 
% and see if you can store more. 
% You can use sgn(randn(1,1024)) to easily generate the patterns.
clear;
close all;
clc;
tic
%% STEP 1:train a network random patterns
for RANDOM = 3:100
    x = [];
    for i=1:RANDOM
        x = [x;sgn(randn(1,1024))];
    end
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
    RESTORE = 0;
    for i=1:P
    %     figure;
    %     subplot(121);
    %     vis(x(i,:));
    %     title('original pattern');
    %     subplot(122)
    %     vis(x_update(i,:));
    %     title('learned pattern');
    %     print(['lab4/capacity/' num2str(P) 'randompatterns_p' num2str(i)],'-dpng')
        if isequal(x(i,:),x_update(i,:))
            RESTORE = RESTORE+1;
    %         disp(['Pattern ' num2str(i) ' is learned'])
    %     else
    %         disp(['Pattern ' num2str(i) ' is not learned'])
        end
    end
    
    %% Whether the network is able to restore patterns?
    if RESTORE == RANDOM
%          disp(['The network can learn ' num2str(RANDOM) ' patterns'])
    else
        disp(['The network cannot learn ' num2str(RANDOM) ' patterns'])
    end
end
toc