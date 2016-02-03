clc;
clear;
load ./Dataset/datasets.mat
% a = seed;        %last atribute for each entry depicts their actual class
a = irisdataset; %last atribute for each entry depicts their actual class
% a = wine;        %last atribute for each entry depicts their actual class
% a = bcancer;       %last atribute for each entry depicts their actual class
temp = randperm(length(a),length(a)); %no. of samples more than atributes 
for p = 2:5 % k of k fold 
    tot = 0;
    for k = 1:5 % k of knn
        for i = 1:p
            n = length(a)/p;   %let no. of samples be more than atributes 
            ti = temp(floor((i-1)*n+1):floor(i*n));
            test = a(ti,:);
            b = ones(size(a));
            b(ti) = 0;
            tri = find(b(:,1) > 0);
            train = a(tri,:);       
            l = Knn(train,test,k);
             %wrong is storing the correctly classified;change 2 to 1 
             %and then it will have wrong ones
            wrong(p-1,k,i) = double(length(find(l == 2))/floor(n));
            tot = tot+1;
        end
        xyz(k) = sum(wrong(p-1,k,:))/p; %mean of accuracy
        abc(k) = sqrt(sum((wrong(p-1,k,:)-xyz(k)).^2))/p; %standard deviation
    end
    figure,errorbar([1:5],xyz,abc),
    xlabel('Value of k (of KNN)'),    ylabel('Mean Accuracy'),
    title(strcat('Mean Accuracy VS K plot with Standard Deviation as error and k(K-Fold)=',num2str(p)));
    men1(p-1) = (sum(sum(wrong(p-1,:,:))))/tot;         %mean across each fold
    standard_dev(p-1) = sqrt((sum(sum((wrong(p-1,:,:)-men1(p-1)).^2)))/tot);
    %standard deviation across each fold
end