load('arcene_valid.data')
load('avl')
arcene_test = arcene_valid;
k=1000;
m = mean(arcene_test);
vari = var(arcene_test);
error = 0;



[b,l]=size(arcene_test);

load('eigen')
v = zeros(length(V),k);
for i=1:b
    arcene_test(i,:)=(arcene_test(i,:));
end


for i=1:k
    v(:,i)=V(:,i);
end

aitr = zeros(b,k);

for i=1:b
    aitr(i,:)= arcene_test(i,:)*v; 
    tempo = -1*sum( ((aitr(i,:)-mean_aio)./(var_aio)).^2 );
    tempo = tempo+log(one_p)-sum(log(var_aio));
    
    
    tempt = -1*sum( ((aitr(i,:)-mean_ait)./(var_ait)).^2 );
    tempt = tempt+log(two_p)-sum(log(var_ait));
    if(tempo > tempt)
        if(labels(i)==1)
        else
            error=error+1;
        end
    else
         if(labels(i)==-1)
        else
            error=error+1;
        end
    end
end

