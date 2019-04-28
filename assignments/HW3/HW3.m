%% using glmfit
clear all;
load income
%MLE
MLE = mle(y,'distribution','burr')


%fmincon

f=@(theta) -1*sum(log(theta(3)) + log(theta(2))-log(theta(1))+(theta(2)-1).*log(y) - (theta(2)-1)*log(theta(1)) - (theta(3)+1).*log(1+(y./theta(1)).^theta(2)))  ;

theta_hat_fmincon = fmincon(f,[25000;3;1],-1*eye(3),[0;0;0])
%% Using gradient descent

%start with an educated guess
theta0 = MLE+5;

n = 1000; %number of steps
theta = zeros(n,3);%
gradf = theta;
step=.0001;
theta(1,:)=theta0;
for i = 1:(n-1)
    %compute the gradient of the log likelihood at the current step
    for j= 1:length(y)
        gradf(i,:) = gradf(i,:) + [-1/theta(i,1)-(theta(i,2)-1)/theta(i,1)+(theta(i,3)+1)*theta(i,2)/((1+(y(j)/theta(i,1))^theta(i,2))*theta(i,1)^(theta(i,2)+1)),1/theta(i,2)+log(y(j))-log(theta(i,1))-(theta(i,3)+1)/(1+(y(j)/theta(i,1))^theta(i,2))*(y(j)/theta(i,1))^(theta(i,2))*log(y(j)/theta(i,1)),1/theta(i,3)-log((1+(y(j)/theta(i,1))^theta(i,2)))];
    end
    gradf(i,:) = -1*gradf(i,:);%have to multiply by -1 in order to find the maximum
    %after the first step using Barzilai-Borwein step size selection method
   %
   
    %compute the gradient descent
    theta(i+1,:) = theta(i,:)-step*gradf(i,:);

end

%display the final value
theta(end,:)

%% plotting stuff
histfit(y,15,'burr')

