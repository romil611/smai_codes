clear;
clc;
data1 = [1,1,7;1,6,3;1,7,8;1,8,9;1,4,5;1,7,5]';
data2 = -[1,3,1;1,4,3;1,2,4;1,7,1;1,1,3;1,4,2]';
dataFinal = [data1,data2];

scatter(data1(2,:),  data1(3,:),'r'),axis([-5,10,-5,10]),hold on;
scatter(-data2(2,:),-data2(3,:),'b','d','filled'),axis([-5,10,-5,10]);

x = -10:0.5:10;
tic,a1 = Single(dataFinal),toc;
tic,a2 = Margin(dataFinal),toc;
tic,a3 = Relax(dataFinal),toc;
tic,a4 = LMS(dataFinal),toc;

y1 = (a1(1)+a1(2)*x)/(-a1(3));
plot(x,y1,'k'),axis([-5,10,-5,10]);
y2 = (a2(1)+a2(2)*x)/(-a2(3));
plot(x,y2,'g'),axis([-5,10,-5,10]);
y3 = (a3(1)+a3(2)*x)/(-a3(3));
plot(x,y3,'m'),axis([-5,10,-5,10]);
y4 = (a4(1)+a4(2)*x)/(-a4(3));
plot(x,y4,'c'),axis([-5,10,-5,10]);
legend('Class W1','Class W2', 'Single', 'Margin', 'Relaxation', 'LMS','Location','southwest'),hold off;


% In case of linearly classifiable data we asume a model G(x) = A*Y .
% So for properly classifying the points we need to determine the correct
% value of A. For this we first define an error function J and then try and
% minimize it. Now using the technique of Gradiant Decent we update the value of A.
%
% A(k+1) = A(k) + (ETA)*J';
% J' is the derivate of the error function we are trying to minimize and ETA is the learning rate.
% Depending on our choice of J our algorithm changes.