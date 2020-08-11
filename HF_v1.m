%% Edit by ZZW
%% 2015.03.31
%% Detect HF1 & HF2
function [HF1leftpnt,HF2leftpnt]=HF_v1(mout)
global local_red height width f
%% %%%%%%%%%%%f坐标读取%%%%%%%%%%%%%%%%
fmin=f(1);
fmax=f(length(f));
n=1;
while local_red(n)==0
    n=n+1;
end
imstart=n;
n=width;
while local_red(n)==0
    n=n-1;
end
imend=n;
%%%%%%%%HF band boundary%%%%%%%%%%%
HF1stschpnt=200000; %HF1开始搜索的起始点 (200kHz)
HF1endschpnt=50000; %HF1终止搜索的起始点 (50kHz)
HF2stschpnt=1000000; %(1MHz)
HF2endschpnt=800000; %(80kHz)
fixedHF1leftpnt=600000; %如果在起始点与终止点之间没有发现二值图像的间断点，则就频域的分段点固定为一个值
fixedHF2leftpnt=1000000;

%%%%%%%%HF1%%%%%%%%%%%
imgHF1stschpnt=ceil(imstart+(HF1stschpnt-fmin)*(imend-imstart)/(fmax-fmin)); %HF1的起始点
imgHF1endschpnt=ceil(imstart+(HF1endschpnt-fmin)*(imend-imstart)/(fmax-fmin));
flag1=0;
flag2=0;
for i=imgHF1stschpnt:-1:imgHF1endschpnt %在HF1的固定范围从右向左扫描
    for j=1:height 
        if mout(j,i)==255 %白 图块最右
            break;
        end
        if j==height && mout(j,i)==0 %某列全黑。断点
            flag1=1;
        end
    end
    if flag1==1  %如有断点，则该断点位置为边界
        imgHF1leftpnt=i;
        break;
    end
    if flag1==0 && i==imgHF1endschpnt %如无断点，且图块横跨整个固定区域，标记flag2
        flag2=1;
    end
end
if flag2==0
    HF1leftpnt=fmin+(imgHF1leftpnt-imstart)*(fmax-fmin)/(imend-imstart);
elseif flag2==1
    HF1leftpnt=fixedHF1leftpnt;
end
disp('HF1');
disp(HF1leftpnt);
%%%%%%%%HF2%%%%%%%%%%%
imgHF2stschpnt=ceil(imstart+(HF2stschpnt-fmin)*(imend-imstart)/(fmax-fmin)); %HF2的起始点
imgHF2endschpnt=ceil(imstart+(HF2endschpnt-fmin)*(imend-imstart)/(fmax-fmin));
flag1=0;
flag2=0;
for i=imgHF2stschpnt:-1:imgHF2endschpnt %在HF1的固定范围从右向左扫描
    for j=1:height 
        if mout(j,i)==255 %白 图块最右
            break;
        end
        if j==height && mout(j,i)==0 %某列全黑。断点
            flag1=1;
        end
    end
    if flag1==1  %如有断点，则该断点位置为边界
        imgHF2leftpnt=i;
        break;
    end
    if flag1==0 && i==imgHF2endschpnt %如无断点，且图块横跨整个固定区域，标记flag2
        flag2=1;
    end
end
if flag2==0
    HF2leftpnt=fmin+(imgHF2leftpnt-imstart)*(fmax-fmin)/(imend-imstart);
elseif flag2==1
    HF2leftpnt=fixedHF2leftpnt;
end
disp('HF2');
disp(HF2leftpnt);