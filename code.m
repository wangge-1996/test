% load('variance_matrix.mat');
% surface_atom=zeros(1904,20);
% for i=1:1904
%     surface_atom(i,:)=variance_matrix(i,:)/sum(variance_matrix(i,:));
% end
% save('surface_atom.mat','surface_atom');




load('surface_atom.mat');
% goal={'ARG LYS ASP GLU','GLN ASN HIS SER THR TYR CYS MET TRP','ALA LLE LUE PHE VAL PRO GLY',...
%     'TYR TRP ALA LLE LUE PHE VAL PRO GLY','CYS MET','ARG LYS ASP GLU GLN ASN SER THR',...
%     'GLN ASN SER THR CYS MET','TYR TRP PHE','ALA LLE LUE VAL','ASP GLU',...
%     'ARG LYS HIS','ASP GLU','GLN ASN SER THR TYR CYS MET TRP ALA LLE LUE PHE VAL PRO GLY',...
%     'ARG LYS HIS','LYS MET TRP ALA LUE PHE VAL GLY','LYS GLU CYS LLE PRO'};
% acid=[{'ARG'},'LYS','ASP','GLU','GLN','ASN','HIS','SER','THR','TYR','CYS','MET','TRP','ALA','ILE','LUE','PHE','VAL','PRO','GLY'];
acid=[{'R'},'K','D','E','Q','N','H','S','T','Y','C','M','W','A','I','L','F','V','P','G'];
% NH2=[9 10 9.6 10 9 9 9 9 9 9 11 9.2 9.4 9.9 10 9.6 9 9.7 11 9.6];
% COOH=[2 9 1.9 2 2 2 2 2 2 2 1.7 2.3 2.4 2.4 2 2.4 3 2.3 2 2.3];
% acid_feature=zeros(1904,16);
% for i=1:1904
%    for j=1:14
%       for k=1:20
%          if isempty(strfind(char(goal(1,j)),char(acid(1,k))))==0
%              acid_feature(i,j)=surface_atom(i,k)+acid_feature(i,j);
%          end
%       end
%    end
% end
% for i=1:1904
%     for k=1:20
%         acid_feature(i,15)=acid_feature(i,15)+surface_atom(i,k)*NH2(k);
%     end
% end
% for i=1:1904
%     for k=1:20
%         acid_feature(i,16)=acid_feature(i,16)+surface_atom(i,k)*COOH(k);
%     end
% end
% save('acid_feature.mat','acid_feature');

% Dehydrating_hydrophobic_feature=zeros(1904,6);
% for i=1:1904
%     for k=1:20
%         if (isempty(strfind('R D E N Q K H',char(acid(k))))==0)%强亲水性
%             Dehydrating_hydrophobic_feature(i,1)=Dehydrating_hydrophobic_feature(i,1)+surface_atom(i,k);
%         end
%         if (isempty(strfind('L I V A M F',char(acid(k))))==0)%强疏水性
%             Dehydrating_hydrophobic_feature(i,2)=Dehydrating_hydrophobic_feature(i,2)+surface_atom(i,k);
%         end
%         if (isempty(strfind('S T Y W',char(acid(k))))==0)%弱亲水性或弱疏水性
%             Dehydrating_hydrophobic_feature(i,3)=Dehydrating_hydrophobic_feature(i,3)+surface_atom(i,k);
%         end
%         if (isempty(strfind('P',char(acid(k))))==0)%脯氨酸
%             Dehydrating_hydrophobic_feature(i,4)=Dehydrating_hydrophobic_feature(i,4)+surface_atom(i,k);
%         end
%         if (isempty(strfind('G',char(acid(k))))==0)%甘氨酸
%             Dehydrating_hydrophobic_feature(i,5)=Dehydrating_hydrophobic_feature(i,5)+surface_atom(i,k);
%         end
%         if (isempty(strfind('C',char(acid(k))))==0)%半胱氨酸
%             Dehydrating_hydrophobic_feature(i,6)=Dehydrating_hydrophobic_feature(i,6)+surface_atom(i,k);
%         end
%     end
% end
save('Dehydrating_hydrophobic_feature.mat','Dehydrating_hydrophobic_feature');




