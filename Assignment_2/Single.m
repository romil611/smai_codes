function [ a ] = Single( dataFinal )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    a = randi(5,[1,size(dataFinal,1)]);
    n = 0.09;           %learning rate
    b = 0;               %margin
    thres = 50000;
    check = zeros(length(dataFinal),1);
    for i = 0:thres
        j = 1+mod(i,length(dataFinal));
        q = a*dataFinal(:,j);
        if q <= b
            a = a + n*dataFinal(:,j)';
            check(j)=0;
        else
            check(j)=1;
        end
        if sum(check) == length(check)
            break;
        end
    end
end

% This is one of the simplest techniques used for achiving good value of 'A'.
% In this technique we first check whether a point is misclassified and if
% it is then it is added to 'A'. This process is continued till 'A' reaches
% an optimal value.
% So here our J is AYk.

% This methos gave very efficient results and was able to classify the
% results correctly in a short time. It is also computationally not that
% expensive. But if the data set was not as good as the one provided then
% this algorithm might not have such results. Also lands close to the
% points though.