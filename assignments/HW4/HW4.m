% HW 4 solutions
%part 
clear all
close all
th = .15;
N = 50;
x = 0:.01:1;
samp = binornd(N,th);
nf = sum(samp);
%plot some stuff
LL = betapdf(x,nf+1,N-nf+1);
LL = LL/sum(LL); %normalizing :)
P1 = betapdf(x,1,1);%uniform
Post1 = betapdf(x,nf+1,N-nf+1);

figure();hold on;
plot(x,LL,x,P1,x,Post1,'LineWidth',2)
[MLE,ind] = max(LL);
[MAP, ind2] = max(Post1);
disp('MLE is ')
disp(x(ind))
disp('Uniform Prior is ')
disp(x(ind2))
P2 = betapdf(x,1/2,1/2); %jeffreys
Post2 = betapdf(x,nf+1/2,N-nf+1/2);
[MAP2,ind3] = max(Post2);
disp('Jeffreys Map is ')
disp(x(ind3))
figure(); hold on;
plot(x,LL,x,P2,x,Post2,'LineWidth',2)


%% part 3
figure(); hold on;
plot(x,Post2,'LineWidth',2)
cur_alpha = nf+1/2;
cur_beta =N-nf+1/2;
for i = 1:10
    s_i = binornd(N,th);
    n_i = sum(s_i);
    %update current alpha and beta params
    cur_alpha = cur_alpha + n_i;
    cur_beta = cur_beta+N-n_i;
    Post_i = betapdf(x,cur_alpha,cur_beta);
    plot(x,Post_i,'LineWidth',2)
end