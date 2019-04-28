%HW 6
clear all; close all;
%% part 1
x = -10:.01:10;
m1 = 0;
m2 = 2;
sig = 1;
n1 = normpdf(x,m1,sig);
n2 = normpdf(x,m2,sig);
figure(); hold on
plot(x,n1,x,n2)

%% roc curves

pfa = 1-normcdf(x,m1,sig);
pd = 1- normcdf(x,m2,sig);
figure();
plot(pfa,pd)
hold on;
pd2 = 1-normcdf(x,.5,sig);
plot(pfa,pd2)

%% poisson part

l0 = 5;
l1 = 10;
l2 = 6;
N = 10; %arbitrary number of samples 

pfa = 1-poisscdf(N*x,N*l0); %sum ofpoissons is poisson with param N*lambda
pd1 = 1-poisscdf(N*x,N*l1);
pd2 = 1-poisscdf(N*x,N*l2);

figure();
plot(pfa,pd1,pfa,pd2,'LineWidth',2);
