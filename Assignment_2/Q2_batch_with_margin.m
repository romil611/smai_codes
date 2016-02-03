clear;
clc;
data1 = [1,1,7;1,6,3;1,7,8;1,8,9;1,4,5;1,7,5]';
data2 = -[1,3,1;1,4,3;1,2,4;1,7,1;1,1,3;1,4,2]';
data = [data1,data2];
a = zeros(1,size(data,1));

n = 0.01;           %neta
b = 0.2;             %margin
thres = 50000;
scatter(data1(2,:),  data1(3,:),'r'),axis([-10,10,-10,10]),hold on;
scatter(-data2(2,:),-data2(3,:),'b','d','filled'),axis([-10,10,-10,10]);
m1 = min(min(min(data1(2,:)),min(-data2(2,:))),min(min(data1(3,:)),min(-data2(3,:))));
m2 = max(max(max(data1(2,:)),max(-data2(2,:))),max(max(data1(3,:)),max(-data2(3,:))));
x = -100:0.5:100;

minimum = length(data);
rr = 1;
ans = a;
for i = 1:thres
    q = a*data;
    e = find(q <= b);
    w = sum(data(:,e)');
    if length(e) < minimum
        ans = a;
        minimum = length(e);
        rr = i;
    end
    if length(e) == 0
        fprintf('hurrey\n');
        break;
    end
    a = a+n*w;
end

y = (ans(1)+ans(2)*x)/(-ans(3));
plot(x,y,'k'),axis([-10,10,-10,10]),hold off;

