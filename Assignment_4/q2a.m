clear all; clc;

load arcene_train.data
a = arcene_train;
load arcene_train.labels
load arcene_valid.data
train_labels = arcene_train;
c = arcene_valid;
load arcene_valid.labels
valid_labels = arcene_valid;

sigma = 10000;
d=[a;c];
%-----------------------------------------------------------
%kernel on train+valid data
K1 = zeros(size(d,1),size(d,1));
for i=1:size(d,1)
    for j=1:size(d,1)
        K1(i,j) = exp(-norm(d(i,:)-d(j,:))^2/sigma^2);
    end
end
temp1 = ones(size(d,1),size(d,1))/(size(d,1));
Ker1 = K1 - temp1*K1 - K1*temp1 + temp1*K1*temp1;
[eigenvec eigenval] = eig(Ker1);
eigenval = diag(eigenval);
for i=1:size(d,1)
    eigenvec(:,i) = eigenvec(:,i)/eigenval(i);
end
%-----------------------------------------------------------



accuracies1 = zeros(1,100);
accuracies2 = zeros(1,100);

for t=1:100
    v = eigenvec(:,1:t);
    train_set = Ker1(1:100,:)*v;
    validate_set = Ker1(101:200,:)*v;
    %linear svm
    trainmodel = svmtrain(train_set,train_labels);
    accuracies1(t)=100*(size(find(svmclassify(trainmodel,validate_set)==valid_labels),1)/size(train_set,1));
    %rbf svm
    trainmodel = svmtrain(train_set,train_labels,'kernel_function','rbf','rbf_sigma',5);
    accuracies2(t)=100*(size(find(svmclassify(trainmodel,validate_set)==valid_labels),1)/size(train_set,1));
end
figure
plot(accuracies1)
figure
plot(accuracies2)