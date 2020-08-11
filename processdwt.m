function processdwt(f0,origin0,casename)
semilogx(f0,origin0,'b');
xlabel('f/Hz');
ylabel('dB');
f1=log10(f0);
ymin=min(origin0);
ymax=max(origin0);
ymax=ceil(ymax/10)*10;
ymin=floor(ymin/10)*10;
createfigure2(f1,origin0);
print('-dtiffn','-r600',strcat(casename,'.tif'));
A=imread(strcat(casename,'.tif'));
carray=[]; %存放每一列所提取颜色像素点的矩阵
ccount=1;
trans=[];
[figheight,figwidth,~]=size(A);
for i=1:figwidth
    for j=1:figheight
        if A(j,i,1)~=255 && A(j,i,2)~=255 && A(j,i,3)==255
            carray(ccount)=j;
            ccount=ccount+1;
        end
    end
    if ccount>5
        cmax=max(carray); %该像素列中具有所求颜色值的像素点中的最大值
        cmin=min(carray); %该像素列中具有所求颜色值的像素点中的最小值
        cmean=ymax-((cmax+cmin)/2-194)*(ymax-ymin)/(2338-194);
        fvalue=(i-457)/(3169-457)*(7-1)+1;
        
        if ~isempty(cmean)
            trans=[trans;fvalue cmean];
        end
    end
    carray=[];
    ccount=1;
%     break;
end

f=trans(:,1);
origin=trans(:,2);
% f=log10(f0);
% origin=origin0;

%%%%小波基为db5
[c1,l1]=wavedec(origin',4,'db5');

ca111=appcoef(c1,l1,'db5',4);
cd11=detcoef(c1,l1,1);
cd21=detcoef(c1,l1,2); %获取高频细节
cd31=detcoef(c1,l1,3);
cd41=detcoef(c1,l1,4);
% cd51=detcoef(c1,l1,5);
sd11=zeros(1,length(cd11));
sd21=zeros(1,length(cd21));
sd31=zeros(1,length(cd31));
% sd41=zeros(1,length(cd41));
% [THR21,~,~] = ddencmp('den','wv',cd21);
% sd21=wthresh(cd21,'s',5);
% [THR31,~,~] = ddencmp('den','wv',cd31);
% sd31=wthresh(cd31,'s',THR31);
[THR41,~,~] = ddencmp('den','wv',cd41);
sd41=wthresh(cd41,'s',1);
% sd51=wthresh(cd51,'s',1);
c21=[ca111,sd41,sd31,sd21,sd11];
origin11=waverec(c21,l1,'db5');
% [c1,l1]=wavedec(origin',3,'db5');
%
% ca111=appcoef(c1,l1,'db5',3);
% cd11=detcoef(c1,l1,1);
% cd21=detcoef(c1,l1,2); %获取高频细节
% cd31=detcoef(c1,l1,3);
% % cd41=detcoef(c1,l1,4);
% sd11=zeros(1,length(cd11));
% sd21=zeros(1,length(cd21));
% sd31=zeros(1,length(cd31));
% % sd41=wthresh(cd41,'s',100);
% c21=[ca111,sd31,sd21,sd11];
% origin11=waverec(c21,l1,'db5');

%%%%小波基为db6
% [c,l]=wavedec(origin',4,'db6');
% ca11=appcoef(c,l,'db6',4); %获取低频信号
% cd1=detcoef(c,l,1);
% cd2=detcoef(c,l,2); %获取高频细节
% cd3=detcoef(c,l,3);
% cd4=detcoef(c,l,4);
% sd1=zeros(1,length(cd1));
% sd2=zeros(1,length(cd2));
% sd3=zeros(1,length(cd3));
% sd4=wthresh(cd4,'s',100);
% origin1=waverec(c2,l,'db6'); %小波重构
% c2=[ca11,sd4,sd3,sd2,sd1];

%%%%小波基为coif5
% [c,l]=wavedec(origin',4,'coif5');
% ca11=appcoef(c,l,'coif5',4); %获取低频信号
% cd1=detcoef(c,l,1);
% cd2=detcoef(c,l,2); %获取高频细节
% cd3=detcoef(c,l,3);
% cd4=detcoef(c,l,4);
% sd1=zeros(1,length(cd1));
% sd2=zeros(1,length(cd2));
% sd3=zeros(1,length(cd3));
% sd4=wthresh(cd4,'s',100);
% c2=[ca11,sd4,sd3,sd2,sd1];
% origin1=waverec(c2,l,'coif5'); %小波重构

% plot(origin1);
% h=figure;
figure;
f2=10.^(f);
semilogx(f0,origin0,'b');
hold on;
semilogx(f2,origin11,'r');
xlabel('f/Hz');
ylabel('dB');
legend('origin signal','denoising signal');
createfigure2(f,origin11);
eval([strcat(casename,'_dwt'),'=','[f origin11'']',';']);
print('-dtiffn','-r600',strcat(casename,'_dwt.tif'));
save('dwt_data',strcat(casename,'_dwt'),'-append');
figure;
plot(f1,origin0,'b','linewidth',1);
% hold on;plot(f,origin,'c','linewidth',1);
hold on;plot(f,origin11,'r','linewidth',1);

print('-dtiffn','-r600',strcat(casename,'_comp.tif'));
% B=getframe(h);
