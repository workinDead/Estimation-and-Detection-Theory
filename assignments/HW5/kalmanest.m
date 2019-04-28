%% Parameters
sigma2_beta0 = 100;
sigma2_w = 25;
y = [16.7549, 25.9058, 16.2077, 14.4519, 15.7722, 17.1367, 17.2066, 20.8919, 19.0157, 22.9322]';
k = length(y);

%% Kalman Filter
disp('Kalman Filter');
beta_0 = 0;
beta_i_upd = beta_0; % initialization for beta(0|0)
P_i_upd = sigma2_beta0; % P(0|0)
for i = 1 : k
    beta_i_pre = beta_i_upd; % beta(i|i-1)
    P_k_pre = P_i_upd; % P(i|i-1)
    beta_i_upd = beta_i_pre + P_k_pre/(sigma2_w+P_k_pre)*(y(i)-beta_i_pre);  % beta(i|i)
    P_i_upd = P_k_pre - P_k_pre^2/(sigma2_w+P_k_pre);  % P(i|i)
    disp(['Time i=', num2str(i), ': beta_i_upd ', num2str(beta_i_upd), '  P_i_upd ', num2str(P_i_upd)]);
end

%% Gaussian linear model
disp(['Gaussian linear model']);
for i = 1 : k
    beta_i = sum(y(1:i)./sigma2_w)/(1/sigma2_beta0+sum(ones(i,1)./sigma2_w)); % estimation of mean
    C_i = 1/(1/sigma2_beta0+sum(ones(1,i)./sigma2_w)); % estimation of variance
    disp(['Time i=', num2str(i), ': beta_i ', num2str(beta_i), '  C_i ', num2str(C_i)]);
end