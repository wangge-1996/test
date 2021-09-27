F1_final=0;
for q=1:200
    acc=zeros(10,2);
    number=1;
    y=zeros(1087,1);
    for i=1:1087
        if i>=1&&i<=275
            y(i)=1;
        end
        if i>=276&&i<=386
            y(i)=2;
        end
        if i>=387&&i<=771
            y(i)=3;
        end
        if i>=772&&i<=1052
            y(i)=4;
        end
        if i>=1053&&i<=1087
            y(i)=5;
        end
    end
    g=unifrnd (0,1);
    c=unifrnd (20,40);
    for k=1:10
        path=['D:\2020_10_9\SDA\feature_SDA',num2str(k),'.mat'];
        %path=['D:\2020_10_9\DALI_feature.mat'];
        load(path);
        load('D:\2020_10_9\hummplocfeature.mat');
        E=[E hummplocfeature];
        X_train=[];
        Y_train=[];
        % Y_train=[];
        X_test=[];
        Y_test=[];%要改
        if k==1
            num=1;
            for j=1:1087
                if (j>=1&&j<=27)||(j>=276&&j<=286)||(j>=387&&j<=424)||(j>=772&&j<=799)||(j>=1053&&j<=1055)%要改
                    X_test(num,:)=E(j,:);
                    Y_test(num)=y(j);
                    num=num+1;
                end
            end
            
            num=1;
            for j=1:1087%要改
                if (j>=28&&j<=275)||(j>=287&&j<=386)||(j>=425&&j<=771)||(j>=800&&j<=1052)||(j>=1056&&j<=1087)%要改
                    X_train(num,:)=E(j,:);
                    Y_train(num)=y(j);
                    num=num+1;
                end
            end
        end
        
        
        if k>=2&&k<=9
            num=1;
            for j=1:1087
                if (j>=28+(k-2)*27&&j<=54+(k-2)*27)||(j>=287+(k-2)*11&&j<=297+(k-2)*11)||(j>=425+(k-2)*38&&j<=462+(k-2)*38)||(j>=800+(k-2)*28&&j<=827+(k-2)*28)||(j>=1056+(k-2)*3&&j<=1058+(k-2)*3)%要改
                    X_test(num,:)=E(j,:);
                    Y_test(num)=y(j);
                    num=num+1;
                end
            end
            num=1;
            for j=1:1087
                if (j>=1&&j<=27+(k-2)*27)||(j>=276&&j<=286+(k-2)*11)||(j>=387&&j<=424+(k-2)*38)||(j>=772&&j<=799+(k-2)*28)||(j>=1053&&j<=1055+(k-2)*3)%要改
                    X_train(num,:)=E(j,:);
                    Y_train(num)=y(j);
                    num=num+1;
                end
            end
            for j=1:1087
                if (j>=55+(k-2)*27&&j<=275)||(j>=298+(k-2)*11&&j<=386)||(j>=463+(k-2)*38&&j<=771)||(j>=828+(k-2)*28&&j<=1052)||(j>=1057+(k-2)*3&&j<=1087)%要改
                    X_train(num,:)=E(j,:);
                    Y_train(num)=y(j);
                    num=num+1;
                end
            end
        end
        
        if k==10
            num=1;
            for j=1:1087%protInd(j)
                if (j>=244&&j<=275)||(j>=375&&j<=386)||(j>=729&&j<=771)||(j>=1024&&j<=1052)||(j>=1080&&j<=1087)%要改
                    X_test(num,:)=E(j,:);
                    Y_test(num)=y(j);
                    num=num+1;
                end
            end
            num=1;
            for j=1:1087
                if (j>=1&&j<=243)||(j>=276&&j<=374)||(j>=387&&j<=728)||(j>=772&&j<=1023)||(j>=1053&&j<=1079)%要改
                    X_train(num,:)=E(j,:);
                    Y_train(num)=y(j);
                    num=num+1;
                end
            end
        end
        
        Y_test=Y_test';
        Y_train=Y_train';
        
        
        [mtrain,ntrain]=size(X_train);
        [mtest,ntest]=size(X_test);
        dataset=[X_train;X_test];
        [dataset_scale,ps]=mapminmax(dataset',0,1);
        dataset_scale=dataset_scale';
        X_train=dataset_scale(1:mtrain,:);
        X_test=dataset_scale((mtrain+1):(mtrain+mtest),:);
        param=['-g ',num2str(g),' -c ',num2str(c),'-s 0 -t 2'];
        model=svmtrain(Y_train,X_train,param);
        %     model=svmtrain(Y_train,X_train,'-g 0.6793 -c 4.8344 -s 0 -t 2');
        [iris_predict_label,iris_accuracy,dec_values]=svmpredict(Y_test,X_test,model);
        a=zeros(5,5);
        
        for i=1:length(Y_test)
            a(Y_test(i),iris_predict_label(i))=a(Y_test(i),iris_predict_label(i))+1;
        end
        
%         path=['D:\2020_10_9\SDA\DALIgitF1matrix\',num2str(k),'.mat'];
%         save(path,'a')
%         disp(a)
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
%         disp('/n');
%         disp(k);
%         disp(iris_accuracy(1));
%         disp(F1_ave);
        acc(number,1)=iris_accuracy(1);
        acc(number,2)=F1_ave;
        number=number+1;
    end
    disp('.................')
    disp(mean(acc(1:10,1)));
    disp(mean(acc(1:10,2)));
    if (mean(acc(1:10,2))>F1_final)%&&(iris_accuracy(1)>acc_final)
        g_final=g;
        c_final=c;
        F1_final=mean(acc(1:10,2));
    end
end
disp(g_final);
disp(c_final);