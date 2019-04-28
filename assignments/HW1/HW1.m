%HW 2
clear all; close all;
%% part ii

mu = 0:10:100;
s2 = 1;
N=50;
muhat_bar = zeros(length(mu),1);
muhat_v = muhat_bar;

for j = 1:length(mu)
muhat = zeros(1,1000);
for i = 1:1000
    %generate x[n]
    xn = mu(j)+sqrt(s2)*randn(N,1);
    
    % compute estimator
    muhat(i) = 1/(N-1)*sum(xn);
end
%compute the average and variance of the estimators to estimate the expected value of
%muhat
muhat_bar(j) = mean(muhat); 
muhat_v(j) = std(muhat);
end
%plot the bias as a function of mu
table(mu',muhat_bar,muhat_v,'VariableNames',{'mu','mu_hat','var_mu_hat'})
%% part iii
mu = 0;

s2 = [1,5,10,15,20,25,30,35,40,45,50];
for j = 1:length(s2)
muhat = zeros(1,1000);
s2hat = muhat;
for i = 1:1000
    %generate x[n]
    xn = mu+sqrt(s2(j))*randn(N,1);
    
    % compute estimator of mean for variance computation
    muhat(i) = 1/(N-1)*sum(xn);
    s2hat(i) = 1/N*sum((xn-1/N*sum(xn)).^2);
end
%compute the average and variance of the estimators to estimate the expected value of
%muhat
s2hat_bar(j) = mean(s2hat); 
s2hat_v(j) = std(s2hat);
end
%plot the bias as a function of mu
table(s2',s2hat_bar',s2hat_v','VariableNames',{'sigma2','sigma2_hat','var_sigma2_hat'})


%% part iv
mu = 10;
s2 = 5;
N = 10:50:1010;

for j = 1:length(N)
muhat = zeros(1,1000);
s2hat = muhat;
for i = 1:1000
    %generate x[n]
    xn = mu+s2*randn(N(j),1);
    
    % compute estimator of mean for variance computation
    muhat(i) = 1/(N(j)-1)*sum(xn);
    s2hat(i) = 1/N(j)*sum((xn-muhat(i)).^2);
end
%compute the average and variance of the estimators to estimate the expected value of
%muhat
muhat_bar = mean(muhat);
muhat_v = std(muhat)^2;
s2hat_bar(j) = mean(s2hat); 
s2hat_v(j) = std(s2hat)^2;
end
%plot the bias as a function of mu
table(N',s2hat_bar',s2hat_v','VariableNames',{'sigma2','sigma2_hat','var_sigma2_hat'})