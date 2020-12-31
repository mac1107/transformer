function mm_v3(data,casename)
casedata=getfield(data,casename);
[f,Ref,Measured1,minRef,maxRef,minMeasured,maxMeasured,min_global,max_global,D,flength,min_f,max_f]=getinformation(casedata);

h=figure(1);
semilogx(f,Ref,'b','LineWidth',1.5);
hold on;
set(gca, 'Fontname', 'Times', 'Fontsize', 12);
semilogx(f,Measured1,'-r','LineWidth',1.5);
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% legend('Reference FR Curve','Measurement FR Curve');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 9])
print(1, '-dtiff',strcat('originalimage/',casename),'-r100');
close(h);
% print(1, '-dpng',strcat('originalimage/',casename));
%%%% call fun to get binary image
B_image=Binary_v5(casename);

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

fsp=[ceil(f_index(1)):ceil(f_index(2))];%频率的指数


imgsppnt=ceil(imgstpnt+(fsp-f_index(1))*(imgendpnt-imgstpnt)/index_dif);%图像分段进行腐蚀

erodeImage=[];
M=[];

for i=1:length(imgsppnt)
    
    if i==1
         M=B_image(:,1:imgsppnt(i));
    else
         M=B_image(:,(imgsppnt(i-1)+1):imgsppnt(i));
    end
    Height=round(0.01*fsp(i)*D);
    rect=[Height, 2];
    se = strel('rectangle',rect);
    em = imerode(M,se);
    erodeImage=[erodeImage em];  
end
erodeImage=[erodeImage B_image(:,(imgsppnt(i)+1):size(B_image,2))]; 

save(strcat('mm_results\',casename,'.mat'),'erodeImage');

imwrite(erodeImage,strcat('mm_results\',casename,'.tif'),'tif');
% close;
end
