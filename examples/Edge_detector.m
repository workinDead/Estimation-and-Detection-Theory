% bad edge detector
%set up matrix
clear all; close all;
N = 100;
X = 25*ones(N,N);
X(N/2+1:end,1:N/2) = 75;
X(N/2+1:end,N/2+1:end) = 150;
X(1:N/2,N/2+1:end) = 225;
imagesc(X)
title('True Image')
xlabel('n')
ylabel('n')
s_2 = 30;

X = X + sqrt(s_2)*randn(N,N);
figure();
imagesc(X)
title('Noisy Image','fontsize',20)
xlabel('n')
ylabel('n')

%mean_list

mean_list = [0, 25-75,25-150,25-225,75-150,75-225,150-225,75-25,150-25,225-25,150-75,225-75,225-150];
%mean_list = [0,25-35,25-45,25-55,35-45,35-55,45-55,35-25,45-25,55-25,45-35,55-35,55-45];
%priors
priors = ones(13,1);
priors(2) = 1-200/N^2;
priors(1,3:13) = 1/12*200/N^2;

edges = [];
edges2 = edges;
for i = 1:N
    i
    for j = 1:N
        x_ij = X(i,j);
        %get set of edge indeces -not considering diagonals yet
        
        if (i==1&&j==1)
            edge_list = [ i+1,j;i,j+1];
        elseif (i==1&&j ==N)
            edge_list = [i,j-1;i+1,j];
        elseif(i ==N && j==1)
            edge_list = [i-1,j;i,j+1];
        elseif(i==N && j==N)
            edge_list = [i-1,j;i,j-1];
        elseif (i ==1)
            edge_list = [i+1,j;i,j+1;i,j-1];
        elseif (j==1)
            edge_list = [i+1,j;i-1,j;i,j+1];
        elseif (j==N)
            edge_list = [i,j-1;i+1,j];
        elseif (i==N)
            edge_list = [i-1,j;i,j+1];
        else
            edge_list = [i,j+1;i,j-1;i+1,j;i-1,j];
        end
        %do some predictionmiction
        for k =1:length(edge_list(:,1))
            %using the bayesian
            inds = edge_list(k,:);
           neighbor = X(inds(1),inds(2));
           z = ((x_ij-neighbor)/sqrt(2*s_2))^2;
           posteriors = [priors(1)*ncx2pdf(z,1,mean_list(1)),...
               priors(2)*ncx2pdf(z,1,mean_list(2)),...
               priors(3)*ncx2pdf(z,1,mean_list(3)),...
               priors(4)*ncx2pdf(z,1,mean_list(4)),...
               priors(5)*ncx2pdf(z,1,mean_list(5)),...
               priors(6)*ncx2pdf(z,1,mean_list(6)),...
               priors(7)*ncx2pdf(z,1,mean_list(7)),...
               priors(8)*ncx2pdf(z,1,mean_list(8)),...
               priors(9)*ncx2pdf(z,1,mean_list(9)),...
               priors(10)*ncx2pdf(z,1,mean_list(10)),...
               priors(11)*ncx2pdf(z,1,mean_list(11)),...
               priors(12)*ncx2pdf(z,1,mean_list(12)),...
               priors(13)*ncx2pdf(z,1,mean_list(13))];
           [M,ind1] = max(posteriors);
           %ind1
            %using the minimum distance
            [M2,ind2] = min((x_ij - neighbor-mean_list).^2);
            %ind2
           if ind1 ~= 1
               %we have an edge between ij and it's neighbor, for ease of
               %labeling we will just put that pixel as one
               edges = [edges; i,j];
           end
           if ind2~=1
              edges2 = [edges2;i,j]; 
           end
    end
    
    end
end
edges
display_mat_1 = zeros(N,N);
display_mat_2 = zeros(N,N);

for i = 1:length(edges(:,1))
   display_mat_1(edges(i,1),edges(i,2))=1; 
end
for i = 1:length(edges2(:,1))
   display_mat_2(edges2(i,1),edges2(i,2))=1; 
end
figure();
imagesc(display_mat_1)
title('Naive Bayesian Edge Detector - Using Posterior','fontsize',20)
xlabel('n')
ylabel('n')
figure();
imagesc(display_mat_2)
title('Naive Bayesian Edge Detector - Using Distance','fontsize',20)
xlabel('n')
ylabel('n')
figure();