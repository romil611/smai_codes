function [ a ] = Margin( dataFinal )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    a = randi(5,[1,size(dataFinal,1)]);
    n = 0.09;           %learning rate
    b = 0.5;               %margin
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

% This is a little improvement of the previous techique. In this algorithm
% the concept margin is introduced so that the partitioning line is not too
% close to the points. This helps in obtaining a more general line .
% So our J is AY - b.

% This methos also gave very efficient results and was able to classify the
% results correctly in a short time. It is also computationally not that
% expensive. But if the data set was not as good as the one provided then
% this algorithm might not have such results. 
% As a margin was kept it gave pretty good seperation line.