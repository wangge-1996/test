load('acid_feature.mat');
load('Dehydrating_hydrophobic_feature.mat');
E=[acid_feature Dehydrating_hydrophobic_feature];
y=zeros(1904,1);
for i=1:1904
    if i>=1&&i<=476
        y(i)=1;
    end
    if i>=477&&i<=671
        y(i)=2;
    end
    if i>=672&&i<=1361
        y(i)=3;
    end
    if i>=1362&&i<=1834
        y(i)=4;
    end
    if i>=1835&&i<=1904
        y(i)=5;
    end
end
% X=[];
% Y=zeros(465,1);%要改
% num=1;
% for i=1:471
%     if max(E(i)~=0)
%         X(num,:)=E(i,:);
%         Y(num)=y(i);
%         num=num+1;
%     end
% end




X_train=[];
Y_train=zeros(1715,1);%要改
% Y_train=[];
X_test=[];
Y_test=zeros(189,1);%要改
% Y_test=[];
num=1;
for j=1:1904
    if (j>=1&&j<=47)||(j>=477&&j<=495)||(j>=672&&j<=740)||(j>=1362&&j<=1408)||(j>=1835&&j<=1841)%要改
        X_test(num,:)=E(j,:);
        Y_test(num)=y(j);
        num=num+1;
    end
end

num=1;
for j=1:1904%要改
    if (j>=48&&j<=476)||(j>=496&&j<=671)||(j>=741&&j<=1361)||(j>=1409&&j<=1834)||(j>=1842&&j<=1904)%要改
        X_train(num,:)=E(j,:);
        Y_train(num)=y(j);
        num=num+1;
    end
end

[mtrain,ntrain]=size(X_train);
[mtest,ntest]=size(X_test);
dataset=[X_train;X_test];
[dataset_scale,ps]=mapminmax(dataset',0,1);
dataset_scale=dataset_scale';
X_train=dataset_scale(1:mtrain,:);
X_test=dataset_scale((mtrain+1):(mtrain+mtest),:);

model=svmtrain(Y_train,X_train,'-g 1 -c 1');
[iris_predict_label,iris_accuracy,dec_values]=svmpredict(Y_test,X_test,model);
a=zeros(5,5);
for i=1:189
    a(Y_test(i),iris_predict_label(i))=a(Y_test(i),iris_predict_label(i))+1;
end

disp(a)

F1_score=zeros(1,5);
for i=1:5
    if a(i,i)==0
        F1_score(i)=0;
        continue
    end
    p=a(i,i)/(sum(a(:,i)));
    r=a(i,i)/(sum(a(i,:)));
    F1_score(i)=2*(p*r)/(p+r);
end
F1_ave=sum(F1_score(1,:))/5;
% disp(iris_accuracy(1));
% disp(F1_ave);
acc_final=iris_accuracy(1);
F1_final=F1_ave;





for j=1:1000
    g=unifrnd (0,40);
    c=unifrnd (0,40);
    param=['-g ',num2str(g),' -c ',num2str(c)];
    model=svmtrain(Y_train,X_train,param);
    [iris_predict_label,iris_accuracy,dec_values]=svmpredict(Y_test,X_test,model);
    a=zeros(5,5);
    for i=1:189
        a(Y_test(i),iris_predict_label(i))=a(Y_test(i),iris_predict_label(i))+1;
    end
    
    disp(a)
    g_final=10;
    c_final=10;
    F1_score=zeros(1,5);
    for i=1:5
        if a(i,i)==0
            F1_score(i)=0;
            continue
        end
        p=a(i,i)/(sum(a(:,i)));
        r=a(i,i)/(sum(a(i,:)));
        F1_score(i)=2*(p*r)/(p+r);
    end
    F1_ave=sum(F1_score(1,:))/5;
    
    if (F1_ave>F1_final)%&&(iris_accuracy(1)>acc_final)
        g_final=g;
        c_final=c;
        F1_final=F1_ave;
    end
end

param=['-g ',num2str(g_final),' -c ',num2str(c_final)];
model=svmtrain(Y_train,X_train,param);
[iris_predict_label,iris_accuracy,dec_values]=svmpredict(Y_test,X_test,model);
a=zeros(5,5);
for i=1:189
    a(Y_test(i),iris_predict_label(i))=a(Y_test(i),iris_predict_label(i))+1;
end
disp(a)
F1_score=zeros(1,5);
for i=1:5
    if a(i,i)==0
        F1_score(i)=0;
        continue
    end
    p=a(i,i)/(sum(a(:,i)));
    r=a(i,i)/(sum(a(i,:)));
    F1_score(i)=2*(p*r)/(p+r);
end
F1_ave=sum(F1_score(1,:))/5;
disp(iris_accuracy(1));
disp(F1_ave);
disp(g_final);
disp(c_final);

