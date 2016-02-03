function [ wrong ] = Knn( train,test,k )
    s1 = size(test);
    s2 = size(train);
    wrong = zeros(s1(1),1);
    for i = 1:s1(1)
        aa = test(i,:);
        a = repmat(aa,s2(1),1);
        b = sqrt((train(:,1:end-1) - a(:,1:end-1)).^2);
        c = sum(b(:,1:end)'); %c is row vector and not a colomn vector
        temp = [train, c'];
        temp = sortrows(temp,s2(2)+1);        
        final = temp(1:k,end-1);
        u = unique(final);
        s3 = size(u);
        max = 0;
        class = 0;
        for j = 1:s3
            d = length(find(final == u(j)));
            if(d>max)
                max = d;
                class = u(j);  %class is the assigned class
            end
        end
        if (class ~= a(1,end)) %a(1,end) has the actual class
            wrong(i) = 1; 
        else
            wrong(i) = 2;
        end
    end
end