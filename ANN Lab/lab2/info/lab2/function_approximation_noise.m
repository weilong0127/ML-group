clear;
close all;
clc;

rand('seed',10);

plotinit
[xtrain,ytrain]=readxy('ballist',2,2);
[xtest,ytest]=readxy('balltest',2,2);
units=5;
data=xtrain;
vqinit;
singlewinner=1;
emiterb;
title('training result of EM using 20 units')
print('lab2/training_EM_20units','-dpng')

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
print('lab2/train1_20units','-dpng')
figure
xyplot(d2,y2,'train2');
print('lab2/train2_20units','-dpng')
figure
xyplot(dtest1,ytest1,'test1');
print('lab2/test1_20units','-dpng')
figure
xyplot(dtest2,ytest2,'test2');
print('lab2/test2_20units','-dpng')

