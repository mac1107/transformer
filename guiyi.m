%% ¹éÒ»»¯
clear, close, clc;
data=load('data2020');

casenames=fieldnames(data);
asp=[];
hauspara=[];
table=[];
fuck=0;
label=[]
for i=1:size(casenames,1)
    casename=char(casenames(i))
    if size(casename,2)>4&&strcmp(casename(1:5),'axial')~=0
        type=1;
        fuck=fuck+1;
    elseif strcmp(casename(1:3),'gnd')~=0
        type=2;
        fuck=fuck+1;
    elseif  size(casename,2)>4&&strcmp(casename(1:5),'short')~=0
        type=3;
        fuck=fuck+1;
    else
        continue
    end
    
    mm_v3(data, casename);
    hauspara=[hauspara;calHausdorff(data,casename)];
    asp=[asp;calparameter2_v5(data,casename)];
    label(fuck,1)=type;

end
%% 
    table(:,1:20)=asp;
    table(:,21:25)=hauspara;
    minima=min(min(table));
    maxima=max(max(table));
    table=(table-minima)/(maxima-minima);
    table=[label table];
csvwrite('test.csv',table);