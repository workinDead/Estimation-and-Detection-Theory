%% using glmfit
clear all;
load challenger.mat
%temperature is the set of x^i, Failure is the set of Y^i
test_mdl = glmfit(Temperature, Failure, 'binomial')

%% Using gradient descent

%start with an educated guess
theta0 = [14.9,.1];

n = 1000; %number of steps
theta = zeros(n,2);
gradf = theta;
step=.0001;
theta(1,:)=theta0;
Temperature = [ones(length(Temperature),1),Temperature]; %augment with ones for the intercept term
for i = 1:(n-1)
    %compute the gradient of the log likelihood at the current step
    for j= 1:length(Failure)
        gradf(i,:) = gradf(i,:) + (Failure(j)-(1/(1+exp(-1*theta(i,:)*Temperature(j,:)'))))*Temperature(j,:);
    end
    gradf(i,:) = -1*gradf(i,:);%have to multiply by -1 in order to find the maximum
    %after the first step using Barzilai-Borwein step size selection method
   %
   
    %compute the gradient descent
    theta(i+1,:) = theta(i,:)-step*gradf(i,:);

end

%display the final value
theta(end,:)

%% Investigating thresholds
load challengertest.mat

%compute probabilities
probs = 1./(1+exp(-[ones(length(Temperature_new),1),Temperature_new]*test_mdl))

T = 0.01:0.01:0.99;
TPR = zeros(length(T),1);
FPR = TPR;
TotalTP = length(Failure_new(Failure_new==1));
TotalTN = length(Failure_new(Failure_new==0));
for i = 1:length(T)
    preds = zeros(length(probs),1);
    for j = 1:length(probs)
        if probs(j)>T(i)
            preds(j)= 1;
        end
        %compute true positive rate and false positive rate
        if (Failure_new(j)==1 && preds(j)==1)
            TPR(i) = TPR(i)+1;
        end
        
        if (Failure_new(j) ==0 && preds(j)==1)
            FPR(i) = FPR(i)+1;
    
        end
    end
        
end
plot(FPR,TPR,'LineWidth',2)
xlabel('False Positive Rate', 'FontSize',16)
ylabel('True Positive Rate', 'FontSize',16)
title('Receiver Operating Characteristic for O-Ring data')