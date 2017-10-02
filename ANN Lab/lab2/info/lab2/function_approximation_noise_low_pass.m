clear;
close all;
clc;

rand('seed',10);

plotinit
[xtrain,ytrain]=readxy('ballist',2,2);
temp=xtrain;
% temp=[xtrain ytrain];
% train=sortrows(temp,1);
% xtrain=train(:,1:2);
% ytrain=train(:,3:4);
%use low pass filter
% windowSize = 3;
% b = (1/windowSize)*ones(1,windowSize);
% a = 1;
% xtrain = filter(b,a,xtrain);
% ytrain = filter(b,a,ytrain);

% median filter
% xtrain = medfilt1(xtrain);
% ytrain = medfilt1(ytrain);
figure
plot(xtrain(:,1),xtrain(:,2));
% moving average filter
m = 3;
coeff24hMA = ones(1, m)/m;
xtrain(:,1) = filter(coeff24hMA, 1, xtrain(:,1));
xtrain(:,2) = filter(coeff24hMA, 1, xtrain(:,2));


[xtest,ytest]=readxy('balltest',2,2);
units=15;
data=xtrain;
vqinit;
singlewinner=1;
emiterb;
title('training result of EM')
print('lab2/training_EM_low','-dpng')

%calculate the matrix Phi of RBF
Phi=calcPhi(xtrain,m,var);

%extract the two desired y vectors for train & test 
d1=ytrain(:,1);
d2=ytrain(:,2);
dtest1=ytest(:,1);
dtest2=ytest(:,2);
%calculate the weight vectors
w1=Phi\d1;
w2=Phi\d2;
%Now we can calculate approximations of training data
y1=Phi*w1;
y2=Phi*w2;

%as well as approximations of test data
Phitest=calcPhi(xtest,m,var);
ytest1=Phitest*w1;
ytest2=Phitest*w2;
%Finally we plot these
%haha

figure
xyplot(d1,y1,'train1');
print('lab2/train1_low_20units','-dpng')
figure
xyplot(d2,y2,'train2');
print('lab2/train2_low_20units','-dpng')
figure
xyplot(dtest1,ytest1,'test1');
print('lab2/test1_low_20units','-dpng')
figure
xyplot(dtest2,ytest2,'test2');
print('lab2/test2_low_20units','-dpng')

