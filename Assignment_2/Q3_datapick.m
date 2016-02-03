clear;
clc;
a = fopen('optdigits-orig.cv');
i = 1;
while ~feof(a)
    if mod(i,33)==0
        sbl_v(i/33,:)=fgetl(a);
    else
        data_v(i,:)=fgetl(a);
    end
i=i+1;
end
a = fopen('optdigits-orig.tra');
i = 1;
while ~feof(a)
    if mod(i,33)==0
        sbl_t(i/33,:)=fgetl(a);
    else
        data_t(i,:)=fgetl(a);
    end
i=i+1;
end

sbl_t = sbl_t(:,2);
sbl_v = sbl_v(:,2);

a = data_t == '1';
data_t(a) = 255;
a = data_t == '0';
data_t(a) = 0;
a = data_v == '1';
data_v(a) = 255;
a = data_v == '0';
data_v(a) = 0;
data_t = double(data_t);
data_v = double(data_v);

a = find(sbl_t == '7' | sbl_t == '0');
train = zeros(8,9,length(a));
for i = 1:length(a)
    if sbl_t(a(i)) == '7'
        b = 1;
    else
        b = 0;
    end
    train(:,1:8,i) = imresize(data_t((a(i)-1)*33+1:a(i)*33-1,:),0.25);
    train(:,9,i) = b; 
end
a = find(sbl_v == '7' | sbl_v == '0');
validate = zeros(8,9,length(a));
for i = 1:length(a)
    if sbl_v(a(i)) == '7'
        b = 1;
    else
        b = 0;
    end
    validate(:,1:8,i) = imresize(data_v((a(i)-1)*33+1:a(i)*33-1,:),0.25);
    validate(:,9,i) = b;
end
clear data_t;
clear data_v;
clear sbl_t;
clear sbl_v;
clear a;
clear b;
clear i;