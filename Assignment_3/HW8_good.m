%%Principle Componenent Analysis
%read data into matlab
clear all;
[tdata text full]=xlsread('training.xls');
% seperate data by features
f0=tdata(:,1)';
% count number of elements in each class
tlen=length(f0);
% find training classes' lengths
t1=0;t2=0;t3=0;
for i=1:tlen
    if f0(i)==1
     t1=t1+1;
    elseif f0(i)==2
     t2=t2+1;  
    elseif f0(i)==3
     t3=t3+1;  
    end
end
% Estimate the mean using training set
t_xi=tdata(:,2:14);
m=mean(t_xi);
% compute centralized data points Xi wrt the mean
t_Xi=zeros(size(t_xi));
for i=1:tlen
    t_Xi(i,:)=t_xi(i,:)-m;
end
% find covariance matrix so we can find the best eigenvectors
Cov=cov(t_xi);
% Eigen vector and value
[V,D] = eigs(Cov);
% choose the eigvector of cov having the largest eigenvalue
v=zeros(length(V),3);
v(:,1)=V(:,1);v(:,2)=V(:,2);v(:,3)=V(:,3);
% use the eigenvectors to find the principle components
ai=zeros(tlen,3);
for i=1:tlen
    ai(i,:)=(t_xi(i,:)-m)*v;
end
% This is the PCA model building phase with d' projection
%range of each class in training set 
class_1=1:t1;
class_2=t1+1:t1+t2;
class_3=t1+t2+1:tlen;
% treat the number of components just like number of features
comp3d=3; % three components for 3d
mu_3d=zeros(3,comp3d);
comp2d=2; % two components for 2d
mu_2d=zeros(3,comp2d);
comp1d=1; % two components for 1d
mu_1d=zeros(3,comp1d);

%----------------3d-------------------------
class=3; % 3 classes total
covar_3d=zeros(3,3,class);
covar_2d=zeros(2,2,class);
covar_1d=zeros(1,1,class);

for i=1:comp3d
    %class one mean w/ component i
    mu_3d(1,i)=mean(ai(class_1,i));
    %class two mean w/ component i
    mu_3d(2,i)=mean(ai(class_2,i));
    %class three mean w/ component i
    mu_3d(3,i)=mean(ai(class_3,i));
end


% find covariance of the components for each class
covar_3d(:,:,1)=cov(ai(class_1,1:comp3d));
covar_3d(:,:,2)=cov(ai(class_2,1:comp3d));
covar_3d(:,:,3)=cov(ai(class_3,1:comp3d));

%----------------2d-------------------------
for i=1:comp2d
    %class one mean w/ component i
    mu_2d(1,i)=mean(ai(class_1,i));
    %class two mean w/ component i
    mu_2d(2,i)=mean(ai(class_2,i));
    %class three mean w/ component i
    mu_2d(3,i)=mean(ai(class_3,i));
end


covar_2d(:,:,1)=cov(ai(class_1,1:comp2d));
covar_2d(:,:,2)=cov(ai(class_2,1:comp2d));
covar_2d(:,:,3)=cov(ai(class_3,1:comp2d));

%----------------1d-------------------------
for i=1:comp1d
    %class one mean w/ component i
    mu_1d(1,i)=mean(ai(class_1,i));
    %class two mean w/ component i
    mu_1d(2,i)=mean(ai(class_2,i));
    %class three mean w/ component i
    mu_1d(3,i)=mean(ai(class_3,i));
end

covar_1d(:,:,1)=cov(ai(class_1,1:comp1d));
covar_1d(:,:,2)=cov(ai(class_2,1:comp1d));
covar_1d(:,:,3)=cov(ai(class_3,1:comp1d));
% 1d
det_1_1d=det(covar_1d(:,:,1));
inv_1_1d=inv(covar_1d(:,:,1));
det_2_1d=det(covar_1d(:,:,2));
inv_2_1d=inv(covar_1d(:,:,2));
det_3_1d=det(covar_1d(:,:,3));
inv_3_1d=inv(covar_1d(:,:,3));
% 2d
det_1_2d=det(covar_2d(:,:,1));
inv_1_2d=inv(covar_2d(:,:,1));
det_2_2d=det(covar_2d(:,:,2));
inv_2_2d=inv(covar_2d(:,:,2));
det_3_2d=det(covar_2d(:,:,3));
inv_3_2d=inv(covar_2d(:,:,3));
% 3d
det_1_3d=det(covar_3d(:,:,1));
inv_1_3d=inv(covar_3d(:,:,1));
det_2_3d=det(covar_3d(:,:,2));
inv_2_3d=inv(covar_3d(:,:,2));
det_3_3d=det(covar_3d(:,:,3));
inv_3_3d=inv(covar_3d(:,:,3));
%% TEST DATA
data=csvread('wine_data.txt');
tr=data(:,1);
len=length(data);
xi=data(:,2:14);
% class sizes
s1=59; s2=71; s3=48;
c_1=1:s1;c_2=s1+1:+s1+s2;c_3=s1+s2+1:len;
% Project test data into d' dimensional projection Choose d'!!!
%################################################################
%---------------IMPORTANT INPUT HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!
d=1;% Set d' as needed (d can be 1,2 or 3) Solve for all d's to plot w/o warnings

pw1=.331;pw2=.399;pw3=.270;%priors
priori={pw1,pw2,pw3};
samples=178;
class=3;

if d==1
    ai=zeros(len,comp1d);
    for i=1:len
        ai(i,:)=(xi(i,:)-m)*v(:,1:comp1d);
    end
    u={mu_1d(1,:)',mu_1d(2,:)',mu_1d(3,:)'};
    sig_inv={inv_1_1d inv_2_1d inv_3_1d};
    sig_det={det_1_1d det_2_1d det_3_1d};
elseif d==2
    ai=zeros(len,comp2d);
    for i=1:len
        ai(i,:)=(xi(i,:)-m)*v(:,1:comp2d);
    end
    u={mu_2d(1,:)',mu_2d(2,:)',mu_2d(3,:)'};
    sig_inv={inv_1_2d inv_2_2d inv_3_2d};
    sig_det={det_1_2d det_2_2d det_3_2d};
elseif d==3
    ai=zeros(len,comp3d);
    for i=1:len
        ai(i,:)=(xi(i,:)-m)*v(:,1:comp3d);
    end
    u={mu_3d(1,:)',mu_3d(2,:)',mu_3d(3,:)'};
    sig_inv={inv_1_3d inv_2_3d inv_3_3d};
    sig_det={det_1_3d det_2_3d det_3_3d};
end
x=ai';
% discriminator g_i(x) =
% -1/2(x-u_i)^2/sig^2-1/2*ln|sigma_i|+log(p(w_i))
go = zeros(class,samples);
for c=1:class
    for s=1:samples
go(c,s) = -0.5*(x(:,s)-u{c})' * sig_inv{c} * (x(:,s)-u{c}) -0.5*log(sig_det{c})+log(priori{c});
    end
end

% classify as 1, 2, or 3 which corresponds to low, medium, or high quality
% respectively
 classifiedo = zeros(1,samples);
for s=1:samples
        num=max(go(:,s));
        [cato caro] = ind2sub(size(go(:,s)),find(go(:,s)==num));
        classifiedo(1,s) = cato;
end


% Calcualte Error Dep Case
% Since we know the answer we can find the error by counting
e1=0; e2=0; e3=0;
classified=classifiedo;
for i=1:s1
    %if not equal to class 1 then count it as error
    if classified(1,i) ~= 1
    e1=e1+1;
    end
end
for i=s1+1:s1+s2
    %if not equal to class 1 then count it as error
    if classified(1,i) ~= 2
    e2=e2+1;
    end
end
for i=s1+s2+1:s1+s2+s3
    %if not equal to class 1 then count it as error
    if classified(1,i) ~= 3
    e3=e3+1;
    end
end
Ei=e1+e2+e3
d_error=(Ei)/(s1+s2+s3)

source1 = strcat('Dimensions:',num2str(d));
source2 = strcat(' Error:',num2str(Ei),'/',num2str(len),'=',num2str(d_error));
%figure(1)
bar(classifiedo)

title({'Wine Classification',source1,source2})
xlabel('wine sample')
ylabel('category')


if d==1
% 1D
x1_1d = ai(c_1);x2_1d = ai(c_2);x3_1d = ai(c_3);
y1_1d = ones(1,s1);y2_1d = ones(1,s2);y3_1d =ones(1,s3);
elseif d==2
% 2D
x1_2d = ai(c_1,1);x2_2d = ai(c_2,1);x3_2d = ai(c_3,1);
y1_2d = ai(c_1,2);y2_2d = ai(c_2,2);y3_2d = ai(c_3,2);
elseif d==3
% 3D
x1_3d = ai(c_1,1);x2_3d = ai(c_2,1);x3_3d = ai(c_3,1);
y1_3d = ai(c_1,2);y2_3d = ai(c_2,2);y3_3d = ai(c_3,2);
z1_3d = ai(c_1,3);z2_3d = ai(c_2,3);z3_3d = ai(c_3,3);
end

%%

figure(2)
subplot(2,1,1)
plot(x1_1d,y1_1d,'or',x2_1d,y2_1d,'xb',x3_1d,y3_1d,'+g')
legend('c=1','c=2','c=3')
title('1-D PCA Projection')
xlabel('First PCA Component')
ylabel('Void')
subplot(2,1,2)
plot(x1_2d,y1_2d,'or',x2_2d,y2_2d,'xb',x3_2d,y3_2d,'+g')
legend('c=1','c=2','c=3')
title('2-D PCA Projection')
xlabel('First PCA Component')
ylabel('Second PCA Component')
grid on
figure(3)
plot3(x1_3d,y1_3d,z1_3d,'or',x2_3d,y2_3d,z2_3d,'xb',x3_3d,y3_3d,z3_3d,'+g')
legend('c=1','c=2','c=3')
title('3-D PCA Projection')
xlabel('First PCA Component')
ylabel('Second PCA Component')
zlabel('Third PCA Component')
grid on
axis vis3d

%% Save results to excel

str1='PCAresults.xls';
%delete(str1);
lab={'True Class','1d','2d','3d','E1','E2','E3'};
xlswrite(str1,lab,'Sheet1','A1');
xlswrite(str1,tr,'Sheet1','A2');
% write new data
if d==1
    xlswrite(str1,classifiedo','Sheet1','B2');
    xlswrite(str1,d_error,'Sheet1','E2');
elseif d==2
    xlswrite(str1,classifiedo','Sheet1','C2');
    xlswrite(str1,d_error,'Sheet1','F2');
elseif d==3
    xlswrite(str1,classifiedo','Sheet1','D2');
    xlswrite(str1,d_error,'Sheet1','G2');
end
%% Save PCA models excel

str2='PCAmodels.xls';
%delete(str2);
if d==1
    xlswrite(str2,ai,'Sheet1','B2');
    xlswrite(str2,mu_1d','Sheet1','D2');
    xlswrite(str2,[covar_1d(:,:,1) covar_1d(:,:,2) covar_1d(:,:,3)],'Sheet1','D4');
elseif d==2
    xlswrite(str2,ai,'Sheet2','B2');
    xlswrite(str2,mu_2d','Sheet2','E2');
    xlswrite(str2,[covar_2d(:,:,1) covar_2d(:,:,2) covar_2d(:,:,3)],'Sheet2','E6');
elseif d==3
    xlswrite(str2,ai,'Sheet3','B2');
    xlswrite(str2,mu_3d','Sheet3','F2');
    xlswrite(str2,[covar_3d(:,:,1) covar_3d(:,:,2) covar_3d(:,:,3)],'Sheet3','F8');
end

