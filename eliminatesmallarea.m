clear all;
close all;
casename='radial1';

MImage=strcat('mm_results/',casename,'.tif');
M=imread(MImage);
Msize=size(M);
height=Msize(1);
width=Msize(2);



arealoc=[];
data=load(strcat('data/',casename,'.txt'));
f=data(:,1);
Origin=data(:,2);
Def=data(:,3);
mino=min(Origin);
maxo=max(Origin);
mind=min(Def);
maxd=max(Def);
min_global=min(mino,mind);
max_global=max(maxo,maxd);
D=max_global-min_global;
flength=length(f);
min_f=f(1);
max_f=f(flength);

critera=0.3*D; %

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
for i=1:1:width
    state=0;
    hrange=[];
    flag=0;
        for j=1:1:height
            if M(j,i) ~=0
                hrange=[hrange,j];
                flag=1;
                flag2=flag2+1;
            end
        end    
        
    if ~isempty(hrange)
        
        hrmaxindex=length(hrange);

        for j=hrange(1):1:hrange(hrmaxindex)
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
    %图像连续
    if state==1
        arearange=[arearange,i];
    end
    %图像不连续，分块存储在imgarealoc中
    if state==0&&flag==1&&flag2>1
        areafirstloc=min(arearange);
        arealastloc=max(arearange);
        if arealastloc-areafirstloc>=1
            imgarealoc=[imgarealoc;areafirstloc,arealastloc];     
        end
        flag2=0;
        arearange=[];    
    end
    if flag2==1
        flag2=0;
        arrarange=[];
    end
end

imllength=length(imgarealoc);

newarealoc=[];

for i=1:imllength
    areafirstloc=imgarealoc(i,1);
    arealastloc=imgarealoc(i,2);
    Ssum=0;
    for j=areafirstloc:1:arealastloc
        for k=1:imgheight
            if M(k,j)==255
                Ssum=Ssum+1;
            end
        end
    end
    if Ssum>=critera
        newarealoc=[newarealoc;areafirstloc,arealastloc];
    end
end

newM=zeros(imgheight,imgwidth);
nimllength=length(newarealoc);
for i=1:nimllength
    areafirstloc=newarealoc(i,1);
    arealastloc=newarealoc(i,2);
    if areafirstloc>=imgstpnt && arealastloc<=imgendpnt      
        for j=areafirstloc:1:arealastloc
            h1=local_blue(j);
            h2=local_red(j);
            for k=1:imgheight
                if k<h1&&k>h2 || k<h2&&k>h1
                    newM(k,j)=255;
                end                    
            end
       end
        
    end
    
end

imwrite(newM,strcat('eliminated\',casename,'.tif'),'tif');





