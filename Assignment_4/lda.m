clear all; clc
load arcene_train.data
a = arcene_train;
load arcene_train.labels
load arcene_valid.data
b = arcene_train;
c = arcene_valid;
load arcene_valid.labels
d = arcene_valid;


%------------------------------------------------------------
% Kernel on train data
sigma1 = 10000;
K11 = zeros(size(a,1),size(a,1));
for i=1:size(a,1)
    for j=1:size(a,1)
        K11(i,j) = exp(-norm(a(i,:)-a(j,:))^2/sigma1^2);
    end
end
temp1 = ones(size(a,1),size(a,1))/(size(a,1));
Ker1 = K11 - temp1*K11 - K11*temp1 + temp1*K11*temp1;
%------------------------------------------------------------



%------------------------------------------------------------
%Kernel on valid data
K12 = zeros(size(c,1),size(c,1));
for i=1:size(c,1)
    for j=1:size(c,1)
        K12(i,j) = exp(-norm(c(i,:)-c(j,:))^2/sigma1^2);
    end
end
temp2 = ones(size(c,1),size(c,1))/(size(c,1));
Ker2 = K12 - temp2*K12 - K12*temp2 + temp2*K12*temp2;
%------------------------------------------------------------


m1indices = find(b==1);
m2indices = find(b==-1);
M1 = mean(Ker1(m1indices,:));   % mean for class label 1
M2 = mean(Ker1(m2indices,:));   % mean for class label 2

bm1indices = find(d==1);
bm2indices = find(d==-1);
bM1 = mean(Ker2(bm1indices,:));   % mean for class label 1
bM2 = mean(Ker2(bm2indices,:));   % mean for class label 2

N = Ker1(m1indices,:)'*(eye(size(m1indices,1))-(1/size(m1indices,1)))*Ker1(m1indices,:) + Ker1(m2indices,:)'*(eye(size(m2indices,1))-(1/size(m2indices,1)))*Ker1(m2indices,:);
N1 = Ker2(bm1indices,:)'*(eye(size(bm1indices,1))-(1/size(bm1indices,1)))*Ker2(bm1indices,:) + Ker2(bm2indices,:)'*(eye(size(bm2indices,1))-(1/size(bm2indices,1)))*Ker2(bm2indices,:);
N1 = N1 + 8000*eye(size(Ker1,1));
N = N + 640*eye(size(Ker2,1));
train = Ker1*inv(N)*(M1-M2)';
test = Ker2*inv(N1)*(bM1-bM2)';
%test = Ker1*inv(N)*(M1-M2)';

%train1 = Ker1*inv(N1)*(M1-M2)';
%test1 = Ker2*inv(N1)*(M1-M2)';

trainmodel = svmtrain(train,b);
accuracy = size(find(svmclassify(trainmodel, test)==d),1);
trainmodel = svmtrain(train,b,'kernel_function','rbf');
accuracy1 = size(find(svmclassify(trainmodel, test)==d),1);
accuracy
accuracy1