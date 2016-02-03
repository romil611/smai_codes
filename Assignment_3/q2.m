tic
clc;clear;
load('arcene_train.data');

k=1000;
m = mean(arcene_train);
vari = var(arcene_train);
[b,l]=size(arcene_train);

for i=1:b
    arcene_train_m(i,:)=(arcene_train(i,:)-m);
end

% Cov = cov(arcene_train); %% computed and saved..
% [V,D] = eigs(Cov);
load ('eigen')
v = zeros(length(V),k);

for i=1:k
    v(:,i)=V(:,i);
end

ai = zeros(b,k);
for i=1:b
    ai(i,:)= arcene_train_m(i,:)*v;
end

%%% ai has n x d' here d' is 5

%%% gaussian bayesian....


load('labels');
one = find(labels==1);
two = find(labels==-1);

aio = ai(one,:);
ait = ai(two,:); 

one_p = size(aio,1)/(size(labels,1)); %%%  prior
two_p = size(ait,1)/(size(labels,1));


mean_aio = mean(aio);%%% p(x/1)
var_aio = var(aio);

mean_ait = mean(ait);%%%% p(x/2)
var_ait = var(ait);


toc




