%test plot_hidden
clear;
clc;
close all
color=['r' 'g' 'b' 'c' 'k' 'r' 'y' 'm' ''];
c=jet(12);
for hidden=2:10
    
error=plot_hidden(hidden);

h(hidden)=plot(1:length(error),error,'Color',c(hidden,:),'LineWidth',2)
hold on;

end
error=plot_hidden(100);
hold on;
hh=plot(1:length(error),error,'Color',c(12,:),'LineWidth',2)
hold on
grid on
xlabel('epochs')
ylabel('error')
title('error change following weight update(epochs)')
legend([h(2:10),hh],'hidden=2','hidden=3','hidden=4','hidden=5','hidden=6','hidden=7','hidden=8',...
    'hidden=9','hidden=10','hidden=100')
