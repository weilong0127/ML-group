clear all
clc
close all

for i = 1:500
    % Input:
    % x	: data training vector
    % column vector for input pattern
    x =0:0.1:16*pi;
    x = x';
    % units : number of RBF units
    units = i;
    units_list(i) = units;

    % desired function values
    % f = sin(2*x);
    f = exp(x);

    % compute positions and variances of RBF units
    makerbf;
    % compute Phi
    Phi = calcPhi(x,m,var);

    % compute w
    A = Phi'*Phi;
    b = Phi'*f;
    w = A\b;

    % output y 
    y = Phi*w;

    % plot result
     rbfplot1(x,y,f,units)
     
     if i==1
         figure;
         rbfplot1(x,y,f,units)
     end
    
    if i==4
        print('lab2/result4_2','-dpng')
        w4=w
    end
   
    if i==5
        print('lab2/result5_2','-dpng')
        w5=w
    end
     if i==6
        print('lab2/result6_2','-dpng')
        w6=w
    end
    r(i) = max(abs((y-f)));
    
end


figure;
plot(units_list,r,'b')
error = ones(1,80);
hold on;
plot(units_list,error.*0.1,'--g')
hold on;
plot(units_list,error.*0.01,'--y')
hold on;
plot(units_list,error.*0.001,'--r')
title('residuals of differnet units')
print('lab2/residuals_batch_mode1_2','-dpng')
%%
figure;
plot(units_list,r,'b')
error = ones(1,80);
hold on;
plot(units_list,error.*0.1,'--g')
hold on;
plot(units_list,error.*0.01,'--y')
hold on;
plot(units_list,error.*0.001,'--r')
title('residuals of differnet units')
axis([min(units_list) max(units_list) 0 0.15])
print('lab2/residuals_batch_mode2_2','-dpng')
%%
figure;
plot(units_list,r,'b')
error = ones(1,80);
hold on;
plot(units_list,error.*0.1,'--g')
hold on;
plot(units_list,error.*0.01,'--y')
hold on;
plot(units_list,error.*0.001,'--r')
title('residuals of differnet units')
axis([min(units_list) max(units_list) 0 0.015])
print('lab2/residuals_batch_mode3_2','-dpng')
%%
unit(1) = units_list(min(find(r<0.1)));
residual(1) = r(min(find(r<0.1)));
unit(2)= units_list(min(find(r<0.01)));
residual(2) = r(min(find(r<0.01)));
unit(3) = units_list(min(find(r<0.001)))
residual(3) = r(min(find(r<0.001)))