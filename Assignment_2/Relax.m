function [ a ] = Relax( dataFinal )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    a = [-1,1,1];
    n = 0.1;           %learning rate
    b = 0.1;             %margin
    thres = 100000;
    check = zeros(length(dataFinal),1);
    for i = 0:thres
        j = 1+mod(i,length(dataFinal));
        q = a*dataFinal(:,j);
        if q < b
            a = a + n*(((b-q)^2)/(norm(dataFinal(:,j)')^2))*(dataFinal(:,j)');
            check(j)=0;
        else
            check(j)=1;
        end
        if sum(check) == length(check)
            break;
        end
    end
end

% Till the previous algorithm more weightage was give to outliers. So to
% correct this issue it is normalized with norm of the distence. Also the
% concept of relaxation is introduced. If there is under relaxation then
% the learning is slow but if there is over relaxation then it may
% overshoot.
% J' is (((AY-B)^2)/(|Y|^2))*Yk;

% This process was comparitively computationally expensive. But this
% algorithm also gave correct results and this algorithm has the capacity
% to handle far off cases.