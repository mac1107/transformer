function ASPDist=calparameter2_v5(data,casename)
%%
% clear all;
% close all;
% casename='shortedturns1';

MImage=strcat('mm_results/',casename,'.tif');
M=imread(MImage);
Msize=size(M);
height=Msize(1);
width=Msize(2);

critera=10; %

arealoc=[];
arearange=[];
casedata=getfield(data,casename);
% data=load(strcat('data/',casename,'.txt'));
[f,Ref,Measured,~,~,~,~,min_global,max_global,~,flength,min_f,max_f]=getinformation(casedata);

f_index=[log10(min_f) log10(max_f)];
index_dif=f_index(2)-f_index(1);

originalimage=strcat('originalimage\',casename,'.tif');
OImage=imread(originalimage);
red=OImage(:,:,1);
blue=OImage(:,:,3);
Osize=size(OImage);
imgheight=Osize(1);
imgwidth=Osize(2);
local_blue=zeros(1,imgwidth);
local_red=zeros(1,imgwidth);
for i=1:imgwidth
    for j=1:imgheight
        if red(j,i)>240 && blue(j,i)<20
            local_blue(i)=j;
        elseif red(j,i)<20 && blue(j,i)>240
            local_red(i)=j;
        end
    end
end

indices1=find(local_blue~=0);
indices2=find(local_red~=0);

i1length=length(indices1);
i2length=length(indices2);

fstblue=indices1(1);
lastblue=indices1(i1length);
fstred=indices2(1);
lastred=indices2(i2length);

imgstpnt=max(fstblue,fstred);
imgendpnt=min(lastred,lastblue);

arearange=[];
imgarealoc=[];
flag2=0;
%% 将二值化差异图像分为连续的块，存储在imgarealoc中
for i=1:1:width
    state=0;
    hrange=[];
    flag=0;
    %遍历当前i下是否有白色块存在
    for j=1:1:height
        if M(j,i) ~=0
            hrange=[hrange,j];
            flag=1;
            flag2=flag2+1;
        end
    end
    
    if ~isempty(hrange)%有白色块存在
        hrmaxindex=length(hrange);
        for j=hrange(1):1:hrange(hrmaxindex)%遍历白色块
%             if j-1<=0||i+1>size(M,2)
%                 continue;
%             end
            if M(j-1,i+1)~=0
                state=1;
                break;
            end
            if M(j,i+1)~=0
                state=1;
                break;
            end
            if M(j+1,i+1)~=0
                state=1;
                break;
            end
        end
    end
    
    if state==1
        arearange=[arearange,i];
    end
    if state==0&&flag==1&&flag2>1
        areafirstloc=min(arearange);
        arealastloc=max(arearange);
        if arealastloc-areafirstloc>=1
            imgarealoc=[imgarealoc;areafirstloc,arealastloc];
        end
        flag2=0;
        arearange=[];
    end
end

%% 将分段图块的索引值转为f值
imllength=length(imgarealoc);

flag=0;
flag2=0;
imgfirstloc=0;
for i=1:1:imllength
%     if i>size(imgarealoc,1)
%         break
%     end
    imgfirstloc=imgarealoc(i,1);
    imglastloc=imgarealoc(i,2);
    firstloc=10^(f_index(1)+(imgfirstloc-imgstpnt)*index_dif/(imgendpnt-imgstpnt));
    lastloc=10^(f_index(1)+(imglastloc-imgstpnt)*index_dif/(imgendpnt-imgstpnt));
    arealoc=[arealoc;firstloc,lastloc];
end

%%
ARLocsize=size(arealoc);
areanum=ARLocsize(1);

ASum=[];

subbands=detectsubbands_v5(data,casename);
sbsize=size(subbands);
sblength=sbsize(1);%分频段个数

% casedata=load(strcat('data/',casename,'.txt'));
% f=casedata(:,1);
% Ref=casedata(:,2);
% Measured=casedata(:,3);
% flength=length(f);
ChangePointArray=[];
TotalS1Array=[];
TotalS2Array=[];

S1Dist=[];%S1面积、S1参考曲线平均斜率、S1实测曲线平均斜率、当前分频段、频率起点、频率终点
S2Dist=[];%S2面积、S2参考曲线平均斜率、S2实测曲线平均斜率、当前分频段、频率起点、频率终点
band=1;

%% 按分频段计算各图像块的面积参数
for j=1:sblength
    S1Array=[];
    S2Array=[];
    S1OArray=[];
    S1DArray=[];
    S2OArray=[];
    S2DArray=[];
    fArray=[];
    s1scount=0;
    s2scount=0;
    sbstpnt=subbands(j,1);
    sbendpnt=subbands(j,2);
    
    %图像块中起点小于等于当前分频点左边点的集合
    indices1=find(arealoc(:,1)<=sbstpnt);
    
    %图像块中终点大于等于当前分频点右边点的集合
    indices2=find(arealoc(:,2)>=sbendpnt);
    
    %图像块中起点大于当前分频点左边点的集合
    indices3_1=find(arealoc(:,1)>sbstpnt);
    %图像块中重点大于当前分频点左边点的集合
    indices3_2=find(arealoc(:,2)<sbendpnt);
    %求交集
    %图像块是当前分频段的子集
    indices3=intersect(indices3_1,indices3_2);
    
    i1len=length(indices1);
    i2len=length(indices2);
    i3len=length(indices3);
    
    
    %图像块中起点小于等于当前分频段起点的集合
    %包括了分频段是当前图像块的子集的情况
    if ~isempty(indices1)
        flag=0;
        if arealoc(indices1(i1len),2)>sbstpnt%indices1中最后一个的终点超过当前分频段起点sbstpnt
            for i=1:1:flength-1
                if f(i)>=sbstpnt&&f(i)<arealoc(indices1(i1len),2)&&f(i)<=sbendpnt%当前频率点在当前分频段内，也在当前图像差异块内
                    if Ref(i)>Measured(i)&&Ref(i+1)>Measured(i+1)
                        olocalmax=max(Ref(i),Ref(i+1));
                        olocalmin=min(Ref(i),Ref(i+1));
                        dlocalmax=max(Measured(i),Measured(i+1));
                        dlocalmin=min(Measured(i),Measured(i+1));
                        S1=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                        oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i))); %在对数坐标下计算斜率
                        dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                        S1Array=[S1Array S1];
                        S1OArray=[S1OArray oslope];
                        S1DArray=[S1DArray dslope];
                        s1scount=s1scount+1;
                        fArray=[fArray f(i)];
                    elseif Ref(i)<Measured(i)&&Ref(i+1)<Measured(i+1)
                        olocalmax=max(Ref(i),Ref(i+1));
                        olocalmin=min(Ref(i),Ref(i+1));
                        dlocalmax=max(Measured(i),Measured(i+1));
                        dlocalmin=min(Measured(i),Measured(i+1));
                        S2=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                        oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i)));
                        dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                        S2Array=[S2Array S2];
                        S2OArray=[S2OArray oslope];
                        S2DArray=[S2DArray dslope];
                        s2scount=s2scount+1;
                        fArray=[fArray f(i)];
                    end
                    %下个i过界
                    if Ref(i)>Measured(i)&&Ref(i+1)<Measured(i+1) || Ref(i)<Measured(i)&&Ref(i+1)>Measured(i+1) ||...
                            f(i)<=sbendpnt&&f(i+1)>=sbendpnt||f(i)<=arealoc(indices1(i1len),2)&&f(i+1)>=arealoc(indices1(i1len),2)
                        
                        fArray=[fArray f(i)];
                        changepnt=i;
                        
                        ChangePointArray=[ChangePointArray i];
                        
                        if length(fArray)>2
                            
                            if ~isempty(S1Array)
                                S1Area=sum(S1Array);%S1面积
                                S1OSmean=sum(S1OArray)/s1scount;%参考曲线平均斜率
                                S1DSmean=sum(S1DArray)/s1scount;%实测曲线平均斜率
                                ffst=fArray(1);%频率起点
                                ffend=max(fArray);%频率终点
                                SI1=[S1Area S1OSmean S1DSmean band ffst ffend];
                                S1Dist=[S1Dist;SI1];
                            elseif ~isempty(S2Array)
                                S2Area=sum(S2Array);
                                S2OSmean=sum(S2OArray)/s2scount;
                                S2DSmean=sum(S2DArray)/s2scount;
                                ffst=fArray(1);
                                ffend=max(fArray);
                                SI2=[S2Area S2OSmean S2DSmean band ffst ffend];
                                S2Dist=[S2Dist;SI2];
                            end
                        end
                        S1Array=[];
                        S2Array=[];
                        S1OArray=[];
                        S2OArray=[];
                        S1DArray=[];
                        S2DArray=[];
                        fArray=[];
                        s1scount=0;
                        s2scount=0;
                    end
                end
            end
        end
    end
    
    %图像块中终点大于等于当前分频段终点的集合
    if ~isempty(indices2)
        if arealoc(indices2(1),1)<sbendpnt && isempty(intersect(indices1,indices2))
            for i=1:1:flength-1
                if f(i)>=sbstpnt&&f(i)>arealoc(indices2(1),1)&&f(i)<=sbendpnt
                    if Ref(i)>Measured(i)&&Ref(i+1)>Measured(i+1)
                        olocalmax=max(Ref(i),Ref(i+1));
                        olocalmin=min(Ref(i),Ref(i+1));
                        dlocalmax=max(Measured(i),Measured(i+1));
                        dlocalmin=min(Measured(i),Measured(i+1));
                        S1=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                        oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i)));
                        dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                        S1Array=[S1Array S1];
                        S1OArray=[S1OArray oslope];
                        S1DArray=[S1DArray dslope];
                        s1scount=s1scount+1;
                        fArray=[fArray f(i)];
                    elseif Ref(i)<Measured(i)&&Ref(i+1)<Measured(i+1)
                        olocalmax=max(Ref(i),Ref(i+1));
                        olocalmin=min(Ref(i),Ref(i+1));
                        dlocalmax=max(Measured(i),Measured(i+1));
                        dlocalmin=min(Measured(i),Measured(i+1));
                        S2=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                        oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i)));
                        dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                        S2Array=[S2Array S2];
                        S2OArray=[S2OArray oslope];
                        S2DArray=[S2DArray dslope];
                        s2scount=s2scount+1;
                        fArray=[fArray f(i)];
                    end
                    if Ref(i)>Measured(i)&&Ref(i+1)<Measured(i+1) || Ref(i)<Measured(i)&&Ref(i+1)>Measured(i+1) || f(i)<=sbendpnt&&f(i+1)>=sbendpnt
                        
                        fArray=[fArray f(i)];
                        
                        changepnt=i;
                        
                        ChangePointArray=[ChangePointArray i];
                        
                        if(length(fArray)>2)
                            
                            if ~isempty(S1Array)
                                S1Area=sum(S1Array);
                                S1OSmean=sum(S1OArray)/s1scount;
                                S1DSmean=sum(S1DArray)/s1scount;
                                ffst=fArray(1);
                                ffend=max(fArray);
                                SI1=[S1Area S1OSmean S1DSmean band ffst ffend];
                                S1Dist=[S1Dist;SI1];
                            elseif ~isempty(S2Array)
                                S2Area=sum(S2Array);
                                S2OSmean=sum(S2OArray)/s2scount;
                                S2DSmean=sum(S2DArray)/s2scount;
                                ffst=fArray(1);
                                ffend=max(fArray);
                                SI2=[S2Area S2OSmean S2DSmean band ffst ffend];
                                S2Dist=[S2Dist;SI2];
                            end
                        end
                        
                        S1Array=[];
                        S2Array=[];
                        S1DArray=[];
                        S2DArray=[];
                        fArray=[];
                        s1scount=0;
                        s2scount=0;
                        %少了S1O和S2O清零？
                    end
                end
            end
        end
    end
    %图像块是当前分频段的子集
    for k=1:1:i3len
        arstpnt=arealoc(indices3(k),1);
        arendpnt=arealoc(indices3(k),2);
        
        for i=1:1:flength-1
            if f(i)>=arstpnt&&f(i)<=arendpnt
                if Ref(i)>Measured(i)&&Ref(i+1)>Measured(i+1)
                    olocalmax=max(Ref(i),Ref(i+1));
                    olocalmin=min(Ref(i),Ref(i+1));
                    dlocalmax=max(Measured(i),Measured(i+1));
                    dlocalmin=min(Measured(i),Measured(i+1));
                    S1=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                    oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i)));
                    dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                    S1Array=[S1Array S1];
                    S1OArray=[S1OArray oslope];
                    S1DArray=[S1DArray dslope];
                    s1scount=s1scount+1;
                    fArray=[fArray f(i)];
                elseif Ref(i)<Measured(i)&&Ref(i+1)<Measured(i+1)
                    olocalmax=max(Ref(i),Ref(i+1));
                    olocalmin=min(Ref(i),Ref(i+1));
                    dlocalmax=max(Measured(i),Measured(i+1));
                    dlocalmin=min(Measured(i),Measured(i+1));
                    S2=(f(i+1)-f(i))*(abs(Ref(i+1)-Measured(i+1))+abs(Ref(i)-Measured(i)))*0.5;
                    oslope=(Ref(i+1)-Ref(i))/(log10(f(i+1))-log10(f(i)));
                    dslope=(Measured(i+1)-Measured(i))/(log10(f(i+1))-log10(f(i)));
                    S2Array=[S2Array S2];
                    S2OArray=[S2OArray oslope];
                    S2DArray=[S2DArray dslope];
                    s2scount=s2scount+1;
                    fArray=[fArray f(i)];
                end
                if Ref(i)>=Measured(i)&&Ref(i+1)<=Measured(i+1) || Ref(i)<=Measured(i)&&Ref(i+1)>=Measured(i+1) || f(i)<=arendpnt&&f(i+1)>=arendpnt
                    
                    fArray=[fArray f(i)];
                    
                    changepnt=i;
                    
                    ChangePointArray=[ChangePointArray i];
                    
                    if(length(fArray)>2)
                        if ~isempty(S1Array)
                            S1Area=sum(S1Array);
                            S1OSmean=sum(S1OArray)/s1scount;
                            S1DSmean=sum(S1DArray)/s1scount;
                            ffst=fArray(1);
                            ffend=max(fArray);
                            SI1=[S1Area S1OSmean S1DSmean band ffst ffend];
                            S1Dist=[S1Dist;SI1];
                        elseif ~isempty(S2Array)
                            S2Area=sum(S2Array);
                            S2OSmean=sum(S2OArray)/s2scount;
                            S2DSmean=sum(S2DArray)/s2scount;
                            ffst=fArray(1);
                            ffend=max(fArray);
                            SI2=[S2Area S2OSmean S2DSmean band ffst ffend];
                            S2Dist=[S2Dist;SI2];
                        end
                    end
                    
                    S1Array=[];
                    S2Array=[];
                    S1DArray=[];
                    S2DArray=[];
                    fArray=[];
                    s1scount=0;
                    s2scount=0;
                    
                    
                    
                end
            end
        end
    end
    
    band=band+1;
    
    S1sum=sum(S1Array)/((sbendpnt-sbstpnt)*(max_global-min_global));
    S2sum=sum(S2Array)/((sbendpnt-sbstpnt)*(max_global-min_global));
    TotalS1Array=[TotalS1Array S1sum];
    TotalS2Array=[TotalS2Array S2sum];
    
    
end
%% 不知道干嘛的
loc1=find(f>subbands(3,1),1);
loc21=find(f<subbands(3,2));
loc2=loc21(length(loc21));

% Reff=[];
% Measuredf=[]
% ff=[];
% for i=loc1:1:loc2
%     Reff=[Reff Ref(i)];
%     Measuredf=[Measuredf Measured(i)]
%     ff=[ff f(i)];
% end
% plot(ff,Reff);
% hold on;
% plot(ff,Measuredf,'-r');

%% 计算相对面积参数
si1size=size(S1Dist);
si2size=size(S2Dist);
si1len=si1size(1);
si2len=si2size(1);

newS1Dist=[];% 相对面积参数、参考曲线平均斜率、实测曲线平均斜率、分频段
newS2Dist=[];% 相对面积参数、参考曲线平均斜率、实测曲线平均斜率、分频段

for i=1:si1len
    S1Area=S1Dist(i,1);
    band=S1Dist(i,4);
    S1OSmean=S1Dist(i,2);
    S1DSmean=S1Dist(i,3);
    
    RS1=S1Area/((subbands(band,2)-subbands(band,1))*(max_global-min_global));%relative square
    
    newS1Dist=[newS1Dist;RS1,S1OSmean,S1DSmean,band];
    
end

for i=1:si2len
    S2Area=S2Dist(i,1);
    band=S2Dist(i,4);
    S2OSmean=S2Dist(i,2);
    S2DSmean=S2Dist(i,3);
    
    RS2=S2Area/((subbands(band,2)-subbands(band,1))*(max_global-min_global));
    
    newS2Dist=[newS2Dist;RS2,S2OSmean,S2DSmean,band];
    
end

ASDist=[newS1Dist;newS2Dist];%A只是为了寻找方便(⊙﹏⊙)b
 %% 某种统计学指标？
SDist=[S1Dist;S2Dist];
silen=si1len+si2len;

LF1od=0;
LF1o2=0;
LF1d2=0;
LF2od=0;
LF2o2=0;
LF2d2=0;
MFod=0;
MFo2=0;
MFd2=0;
HF1od=0;
HF1o2=0;
HF1d2=0;
HF2od=0;
HF2o2=0;
HF2d2=0;

for i=1:silen
    ffst=SDist(i,5);
    fend=SDist(i,6);
    band=SDist(i,4);
    
    od=0;
    o2=0;
    d2=0;
    for j=1:flength
        if f(j)>=ffst &&f(j)<=fend
            od=od+Ref(j)*Measured(j);
            o2=o2+Ref(j)^2;
            d2=d2+Measured(j)^2;
        end
    end
    
    if band==1
        LF1od=LF1od+od;
        LF1o2=LF1o2+o2;
        LF1d2=LF1d2+d2;
    elseif band==2
        LF2od=LF2od+od;
        LF2o2=LF2o2+o2;
        LF2d2=LF2d2+d2;
    elseif band==3
        MFod=MFod+od;
        MFo2=MFo2+o2;
        MFd2=MFd2+d2;
    elseif band==4
        HF1od=HF1od+od;
        HF1o2=HF1o2+o2;
        HF1d2=HF1d2+d2;
    elseif band==5
        HF2od=HF2od+od;
        HF2o2=HF2o2+o2;
        HF2d2=HF2d2+d2;
    end
end

LF1CC=LF1od/sqrt(LF1o2*LF1d2);
LF2CC=LF2od/sqrt(LF2o2*LF2d2);
MFCC=MFod/sqrt(MFo2*MFd2);
HF1CC=HF1od/sqrt(HF1o2*HF1d2);
HF2CC=HF2od/sqrt(HF2o2*HF2d2);

ACCArray=[LF1CC,LF2CC,MFCC,HF1CC,HF2CC];
%% 按分频段计算四个面积参数
[opoles,ozeros,dpoles,dzeros] = detectpoleandzero_v2(data,casename);

firstozero=ozeros(1,1);
firstdzero=dzeros(1,1);
Afirstzeroshift=firstdzero-firstozero;

AS1PArray=[];
AS2PArray=[];
AS3PArray=[];
AS4PArray=[];

AS1PDist=[];
AS2PDist=[];
AS3PDist=[];
AS4PDist=[];

for i=1:5
    for j=1:si1len
        if newS1Dist(j,4) == i
            if newS1Dist(j,2)>=12 && newS1Dist(j,3)>-12
                AS1PArray=[AS1PArray newS1Dist(j,1)];%右移，绝对值大于0超过阈值
            elseif newS1Dist(j,2)>=12 && newS1Dist(j,3)<=-12
                AS3PArray=[AS3PArray newS1Dist(j,1)];%上移，两个平均斜率异号
            elseif newS1Dist(j,2)<12 && newS1Dist(j,2)>-12&&newS1Dist(j,3)>=12
                AS1PArray=[AS1PArray newS1Dist(j,1)];%右移，绝对值大于0超过阈值
            elseif newS1Dist(j,2)<12 && newS1Dist(j,2)>-12&&newS1Dist(j,3)<12&&newS1Dist(j,3)>-12
                AS3PArray=[AS3PArray newS1Dist(j,1)];%上移，两个平均斜率绝对值均在阈值范围内
            elseif newS1Dist(j,2)<12 && newS1Dist(j,2)>-12&&newS1Dist(j,3)<=-12
                AS2PArray=[AS2PArray newS1Dist(j,1)];%左移，绝对值小于0超过阈值
            elseif newS1Dist(j,2)<=-12&&newS1Dist(j,3)>=12
                AS3PArray=[AS3PArray newS1Dist(j,1)];%上移，两个平均斜率异号
            elseif newS1Dist(j,2)<=-12&&newS1Dist(j,3)<12&&newS1Dist(j,3)>-12
                AS2PArray=[AS2PArray newS1Dist(j,1)];%左移，绝对值小于0超过阈值
            elseif newS1Dist(j,2)<=-12&&newS1Dist(j,3)<=-12
                AS2PArray=[AS2PArray newS1Dist(j,1)];%左移，绝对值小于0超过阈值
            end
        end
    end
    for j=1:si2len
        if newS2Dist(j,4) == i
            if newS2Dist(j,2)>=12 && newS2Dist(j,3)>-12
                AS2PArray=[AS2PArray newS2Dist(j,1)];%左移
            elseif newS2Dist(j,2)>=12 && newS2Dist(j,3)<=-12
                AS4PArray=[AS4PArray newS2Dist(j,1)];%下移
            elseif newS2Dist(j,2)<12 && newS2Dist(j,2)>-12&&newS2Dist(j,3)>=12
                AS2PArray=[AS2PArray newS2Dist(j,1)];%左移
            elseif newS2Dist(j,2)<12 && newS2Dist(j,2)>-12&&newS2Dist(j,3)<12&&newS2Dist(j,3)>-12
                AS4PArray=[AS4PArray newS2Dist(j,1)];%下移
            elseif newS2Dist(j,2)<12 && newS2Dist(j,2)>-12&&newS2Dist(j,3)<=-12
                AS1PArray=[AS1PArray newS2Dist(j,1)];%右移
            elseif newS2Dist(j,2)<=-12&&newS2Dist(j,3)>=12
                AS4PArray=[AS4PArray newS2Dist(j,1)];%下移
            elseif newS2Dist(j,2)<=-12&&newS2Dist(j,3)<12&&newS2Dist(j,3)>-12
                AS1PArray=[AS1PArray newS2Dist(j,1)];%右移
            elseif newS2Dist(j,2)<=-12&&newS2Dist(j,3)<=-12
                AS1PArray=[AS1PArray newS2Dist(j,1)];%右移
            end
        end
    end
    
    S1=sum(AS1PArray);
    S2=sum(AS2PArray);
    S3=sum(AS3PArray);
    S4=sum(AS4PArray);
    
    AS1PArray=[];
    AS2PArray=[];
    AS3PArray=[];
    AS4PArray=[];
    
    AS1PDist=[AS1PDist;S1,i];%右移
    AS2PDist=[AS2PDist;S2,i];%左移
    AS3PDist=[AS3PDist;S3,i];%下移
    AS4PDist=[AS4PDist;S4,i];%上移
end

ASPDist=[];

for i=1:5
    ASPDist=[ASPDist;AS1PDist(i),AS2PDist(i),AS3PDist(i),AS4PDist(i)];
end

ASPDist=reshape(ASPDist,1,20);
close all;
end
















