function [ a ] = LMS( dataFinal )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    a = [-1,1,1];        % selected after trying for MANY possible a's.
    % a = randi(5,[1,size(data,1)]);
    n = 0.0005;           %learning rate
    % b = randi(5,[1,size(data,2)]);             
    b = ones(1,size(dataFinal,2));
    thres = 0.000025;
    check = zeros(length(dataFinal),1);
    j =1;
    i =0;
    while norm((n)*dataFinal(:,j)'*(a*dataFinal(:,j) - b(j))) > thres
        j = 1+mod(i,length(dataFinal));
        a = a - (n)*dataFinal(:,j)'*(a*dataFinal(:,j) - b(j));
        i = i+1;
    end
end

% Untill now all the algorithms that we saw used misclassified sample for
% updation purpose. This had a major issue as due to this outliers etc
% had large influence. So to correct this issue this method was introduced.
% In this method all the points are concidered. It is assumed that each
% poiint has a distence bi from the line. 
% But as correct distance cant be estimated error is introduced. So,
% e = AY - B;
% Using this we try and update A to get a favorable vector.


% This algorithm give very different results for different initallised
% values. Even then it was not able to correctly identify all the points.