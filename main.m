clear, close, clc;
data=load('data2020');

casenames=fieldnames(data);
asp=[];
hauspara=[];
for i=1:size(casenames,1)
    if strcmp(casenames(i),'nofault1')~=0||strcmp(casenames(i),'nofault2')~=0
        continue
    end
    mm_v3(data, char(casenames(i)));
    hauspara=[hauspara;calHausdorff(data,char(casenames(i)))];
    asp=[asp;calparameter2_v5(data,char(casenames(i)))];
end