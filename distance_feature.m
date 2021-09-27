loc={'cytosol','mitochondria',...
    'nucleoplasm','plasma membrane','endoplasmic reticulum'};
error_protein=[];
variance_matrix=[];
num=1;
str2='.pdb';
for k=1:5
    disp(loc{k});
    path=['D:\2020_7_31\name\',loc{k},'.xlsx'];
    pdb_list=importdata(path);
    for i=13:length(pdb_list)
        disp(i);
        str1=lower(pdb_list{i,1});
        str=strcat(str1,str2);
        str1=['D:\2020_7_1\pdb\',loc{k},'\'];
        str_final=strcat(str1,str);
        try
            E=distance_get(str_final);
            if length(variance_matrix)==0
                variance_matrix=E;
            else
                variance_matrix=[variance_matrix;E];
            end
            if max(E)==0
                error_protein(num)=i;
                num=num+1;
            end
        catch
            error_protein(num)=i; 
            num=num+1;
        end
    end
end
save('variance_matrix.mat','variance_matrix')
save('error_protein.mat','error_protein')
