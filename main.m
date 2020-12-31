% function [hauspara,asp]=main(data,casenames)
clear, close, clc;
data=load('data2020');

casenames=fieldnames(data);
asp=[];
hauspara=[];
cc=[];
ASLE=[];
MM=[];
for i=1:size(casenames,1)
    if strcmp(casenames(i),'axial1')==0
        continue
    end
    mm_v3(data, char(casenames(i)));
    [haus,subbands]=calHausdorff(data,char(casenames(i)));
    hauspara=[hauspara;haus];
    asp=[asp;calparameter2_v5(data,char(casenames(i)))];
    cc=[cc;calCC(data,char(casenames(i)),subbands)];
    ASLE=[ASLE;calASLE(data,char(casenames(i)),subbands)];
    MM=[MM;calMM(data,char(casenames(i)),subbands)];
end