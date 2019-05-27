% ESE 524 Linear Models System Identification example
clear all; close all;
%% initialize variables and input functions, plot inputs
N = 100;
p = 10;
s2 = 1;

%first generate true filter coefficients

h = fir1(p, .4); % low pass filter at 8 hz
h=h';
u = zeros(4,N);
u(1,:) = 1;
u(2,:) = cos(2*pi*(0:N-1)/20);
u(3,1) = 1;
u(4,:) = 0+2*randn(1,N);

%plot the signals
figure(); 
title('Candidate Input Functions');

subplot(2,2,1)
plot(0:N-1, u(1,:),'o-','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('u_1[n]','fontsize',18)



subplot(2,2,2)
plot(0:N-1, u(2,:),'o-','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('u_2[n]','fontsize',18)

subplot(2,2,3)
plot(0:N-1, u(3,:),'o-','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('u_3[n]','fontsize',18)


subplot(2,2,4)
plot(0:N-1, u(4,:),'o-','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('u_4[n]','fontsize',18)
%% Estimate Some coefficients

%create H matrices
H_1 = zeros(N,p+1);
H_2 = H_1;
H_3 = H_1;
H_4 = H_1;
for i = 1:N
    if (i<=p)
        H_1(i,1:i)= u(1,i:-1:1); %this indexing gives the right order
        H_2(i,1:i)= u(2,i:-1:1);
        H_3(i,1:i)= u(3,i:-1:1);
        H_4(i,1:i)= u(4,i:-1:1);
    else
        H_1(i,:) = u(1,i:-1:i-p);
        H_2(i,:) = u(2,i:-1:i-p);
        H_3(i,:) = u(3,i:-1:i-p);
        H_4(i,:) = u(4,i:-1:i-p);
    end
    
end

%generate signals
x1 = H_1*h + s2*randn(N,1);
x2 = H_2*h + s2*randn(N,1);
x3 = H_3*h + s2*randn(N,1);
x4 = H_4*h + s2*randn(N,1);

%plot signals
figure(); 
subplot(2,2,1)
plot(0:N-1, x1,'o-', 0:N-1,H_1*h,'*- ','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('x_1[n]','fontsize',18)



subplot(2,2,2)
plot(0:N-1, x2,'o-', 0:N-1,H_2*h,'*- ','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('x_2[n]','fontsize',18)

subplot(2,2,3)
plot(0:N-1, x3,'o-', 0:N-1,H_3*h,'*- ','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('x_3[n]','fontsize',18)


subplot(2,2,4)
plot(0:N-1, x4,'o-', 0:N-1,H_4*h,'*- ','MarkerSize',3)
xlabel('n','fontsize',18)
ylabel('x_4[n]','fontsize',18)



%% Compute the estimators

h_hat1 = (H_1'*H_1)^-1*H_1'*x1;
h_hat2 = (H_2'*H_2)^-1*H_2'*x2;
h_hat3 = (H_3'*H_3)^-1*H_3'*x3;
h_hat4 = (H_4'*H_4)^-1*H_4'*x4;

mse_1 = mean((h-h_hat1).^2)
mse_2 = mean((h-h_hat2).^2)
mse_3 = mean((h-h_hat3).^2)
mse_4 = mean((h-h_hat4).^2)

%why is random noise the best?
mean(diag((H_1'*H_1)^-1))
mean(diag((H_2'*H_2)^-1))
mean(diag((H_3'*H_3)^-1))
mean(diag((H_4'*H_4)^-1))

figure(); 
subplot(2,2,1)
surf((H_1'*H_1))
title('Information Matrix for Unit Step Input','fontsize',16)



subplot(2,2,2)
surf((H_2'*H_2))
title('Information Matrix for Cosine Input','fontsize',16)


subplot(2,2,3)
surf((H_3'*H_3))
title('Information Matrix for Dirac Delta Input','fontsize',16)


subplot(2,2,4)
surf((H_4'*H_4))
title('Information Matrix for Random Input','fontsize',16)

