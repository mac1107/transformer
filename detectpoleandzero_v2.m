function [opoles,ozeros,dpoles,dzeros] = detectpoleandzero_v2(data,casename)

%找出origin的极值点
% data=load(strcat('data/',casename,'.txt'));
casedata=getfield(data,casename);
f2=casedata(:,1);
Origin2=casedata(:,2);
Def2=casedata(:,3);
se1 = [ 0 0 0;-1 0 1];

output1=eros(Origin2,se1);
output2=dila(output1,se1);
output3=dila(output2,se1);
output4=eros(output3,se1);

output5=eros(Def2,se1);
output6=dila(output5,se1);
output7=dila(output6,se1);
output8=eros(output7,se1);

% output = output1 - output2;
% figure;
% semilogx(f,Origin);
% hold on;
 %semilogx(f,output4,'r');
f2length=length(f2);
Origin=[];
Def=[];
f=[];
for i=3:f2length-4
        Origin=[Origin,output4(i)];
        Def=[Def,output8(i)];
        f=[f,f2(i)];
end

flength=length(f);

figure,semilogx(f,Origin);
 


OriginMax=[];
OMaxF=[];
OriginMin=[];
OMinF=[];
omincount=0;
omaxcount=0;

DefMax=[];
DMaxF=[];
DefMin=[];
DMinF=[];
dmincount=0;
dmaxcount=0;

for i=2:1:flength-5
        if Origin(i)>Origin(i-1)&&Origin(i)>Origin(i+1)
           omaxcount=omaxcount+1;
           OriginMax(omaxcount)=Origin(i);
           OMaxF(omaxcount)=f(i);
        end
        if Origin(i)>Origin(i-1)&&Origin(i)==Origin(i+1)
            indices=find(Origin==Origin(i));
            loc=find(indices==i);
            for j=loc:length(indices)-1
                if indices(j)-indices(j+1)==-1
                    if Origin(indices(j+1))>Origin(indices(j+1)+1)
                        omaxcount=omaxcount+1;
                        OriginMax(omaxcount)=Origin(i);
                        OMaxF(omaxcount)=(f(indices(loc))+f(indices(j+1)))/2;
                    elseif Origin(indices(j+1))<Origin(indices(j+1)+1)
                        break;
                    end
                end
            end
        end
        if Origin(i)<Origin(i-1)&&Origin(i)<Origin(i+1)
           omincount=omincount+1;
           OriginMin(omincount)=Origin(i);
           OMinF(omincount)=f(i);
        end
        if Origin(i)<Origin(i-1)&&Origin(i)==Origin(i+1)
            indices=find(Origin==Origin(i));
            loc=find(indices==i);
            for j=loc:length(indices)-1
                if indices(j)-indices(j+1)==-1
                    if Origin(indices(j+1))<Origin(indices(j+1)+1)
                        omincount=omincount+1;
                        OriginMin(omincount)=Origin(i);
                        OMinF(omincount)=(f(indices(loc))+f(indices(j+1)))/2;
                    elseif Origin(indices(j+1))>Origin(indices(j+1)+1)
                        break;
                    end
                end
            end
        end
        
        
        if Def(i)>Def(i-1)&&Def(i)>Def(i+1)
           dmaxcount=dmaxcount+1;
           DefMax(dmaxcount)=Def(i);
           DMaxF(dmaxcount)=f(i);
        end
        if Def(i)>Def(i-1)&&Def(i)==Def(i+1)
            indices=find(Def==Def(i));
            loc=find(indices==i);
            for j=loc:length(indices)-1
                if indices(j)-indices(j+1)==-1
                    if Def(indices(j+1))>Def(indices(j+1)+1)
                        dmaxcount=dmaxcount+1;
                        DefMax(dmaxcount)=Def(i);
                        DMaxF(dmaxcount)=(f(indices(loc))+f(indices(j+1)))/2;
                    elseif Def(indices(j+1))<Def(indices(j+1)+1)
                        break;
                    end
                end
            end
        end
        if Def(i)<Def(i-1)&&Def(i)<Def(i+1)
           dmincount=dmincount+1;
           DefMin(dmincount)=Def(i);
           DMinF(dmincount)=f(i);
        end
        if Def(i)<Def(i-1)&&Def(i)==Def(i+1)
            indices=find(Def==Def(i));
            loc=find(indices==i);
            for j=loc:length(indices)-1
                if indices(j)-indices(j+1)==-1
                        if indices(j+1)==flength || Def(indices(j+1))<Def(indices(j+1)+1)
                            dmincount=dmincount+1;
                            DefMin(dmincount)=Def(i);
                            DMinF(dmincount)=(f(indices(loc))+f(indices(j+1)))/2;
                        elseif Def(indices(j+1))>Def(indices(j+1)+1)
                            break;
                        end
                end
            end
        end                
       
end

% 消除变化微小的极值点的干扰
while OriginMax(1)-OriginMin(1)<5
    OMaxF(1)=[];
    OriginMax(1)=[];
    OMinF(1)=[];
    OriginMin(1)=[];
end

while DefMax(1)-DefMin(1)<5
    DMaxF(1)=[];
    DefMax(1)=[];
    DMinF(1)=[];
    DefMin(1)=[];
end


opoles=[OMaxF;OriginMax];
ozeros=[OMinF;OriginMin];
dpoles=[DMaxF;DefMax];
dzeros=[DMinF;DefMin];
%     if Origin(i)<Origin(i-1)&&Origin(i)<=Origin(i+1)&&Origin(i)<=Origin(i+2)&&Origin(i)<Origin(i+3)
%         omincount=omincount+1;
%         OriginMin(omincount)=Origin(i);
%         OMinF(omincount)=f2(i);
%     end
