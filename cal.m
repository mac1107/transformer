clear, close, clc;
data=load('data2020');

casenames=fieldnames(data);
asp=[];
hauspara=[];
cc=[];
ASLE=[];
MM=[];
table=[];
fuck=0;
fid1=fopen('cc.txt','wt');
fid2=fopen('asle.txt','wt');
fid3=fopen('mm.txt','wt');
fid4=fopen('haus.txt','wt');
fid5=fopen('asp.txt','wt');

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
    [haus,subbands]=calHausdorff(data,char(casenames(i)));
    hauspara=[hauspara;haus];
    asp=[asp;calparameter2_v5(data,char(casenames(i)))];
    cc=[cc;calCC(data,char(casenames(i)),subbands)];
    ASLE=[ASLE;calASLE(data,char(casenames(i)),subbands)];
    MM=[MM;calMM(data,char(casenames(i)),subbands)];
    fprintf(fid1,'%d\t',type);
    fprintf(fid2,'%d\t',type);
    fprintf(fid3,'%d\t',type);
    fprintf(fid4,'%d\t',type);
    fprintf(fid5,'%d\t',type);
    label(fuck,1)=type;
    for j=1:5
        fprintf(fid1,'%d:%.4f\t',j,cc(fuck,j));
        fprintf(fid2,'%d:%.4f\t',j,ASLE(fuck,j));
        fprintf(fid3,'%d:%.4f\t',j,MM(fuck,j));
        fprintf(fid4,'%d:%.4f\t',j,hauspara(fuck,j));
        fprintf(fid5,'%d:%.4f\t',j,asp(fuck,j));
    end
    fprintf(fid1,'\n');
    fprintf(fid2,'\n');
    fprintf(fid3,'\n');
    fprintf(fid4,'\n');
    fprintf(fid5,'\n');
end

fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);
fclose(fid5);
hauspara=[label hauspara];
csvwrite('haus.csv',hauspara);
asp=[label asp];
csvwrite('asp.csv',asp);
cc=[label cc];
csvwrite('cc.csv',cc);
ASLE=[label ASLE];
csvwrite('ASLE.csv',ASLE);
MM=[label MM];
csvwrite('MM.csv',MM);