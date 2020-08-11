%% Edit by ZZW
%% 2015.03.31
%% Detect HF1 & HF2
function [HF1leftpnt,HF2leftpnt]=HF_v1(mout)
global local_red height width f
%% %%%%%%%%%%%f�����ȡ%%%%%%%%%%%%%%%%
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
HF1stschpnt=200000; %HF1��ʼ��������ʼ�� (200kHz)
HF1endschpnt=50000; %HF1��ֹ��������ʼ�� (50kHz)
HF2stschpnt=1000000; %(1MHz)
HF2endschpnt=800000; %(80kHz)
fixedHF1leftpnt=600000; %�������ʼ������ֹ��֮��û�з��ֶ�ֵͼ��ļ�ϵ㣬���Ƶ��ķֶε�̶�Ϊһ��ֵ
fixedHF2leftpnt=1000000;

%%%%%%%%HF1%%%%%%%%%%%
imgHF1stschpnt=ceil(imstart+(HF1stschpnt-fmin)*(imend-imstart)/(fmax-fmin)); %HF1����ʼ��
imgHF1endschpnt=ceil(imstart+(HF1endschpnt-fmin)*(imend-imstart)/(fmax-fmin));
flag1=0;
flag2=0;
for i=imgHF1stschpnt:-1:imgHF1endschpnt %��HF1�Ĺ̶���Χ��������ɨ��
    for j=1:height 
        if mout(j,i)==255 %�� ͼ������
            break;
        end
        if j==height && mout(j,i)==0 %ĳ��ȫ�ڡ��ϵ�
            flag1=1;
        end
    end
    if flag1==1  %���жϵ㣬��öϵ�λ��Ϊ�߽�
        imgHF1leftpnt=i;
        break;
    end
    if flag1==0 && i==imgHF1endschpnt %���޶ϵ㣬��ͼ���������̶����򣬱��flag2
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
imgHF2stschpnt=ceil(imstart+(HF2stschpnt-fmin)*(imend-imstart)/(fmax-fmin)); %HF2����ʼ��
imgHF2endschpnt=ceil(imstart+(HF2endschpnt-fmin)*(imend-imstart)/(fmax-fmin));
flag1=0;
flag2=0;
for i=imgHF2stschpnt:-1:imgHF2endschpnt %��HF1�Ĺ̶���Χ��������ɨ��
    for j=1:height 
        if mout(j,i)==255 %�� ͼ������
            break;
        end
        if j==height && mout(j,i)==0 %ĳ��ȫ�ڡ��ϵ�
            flag1=1;
        end
    end
    if flag1==1  %���жϵ㣬��öϵ�λ��Ϊ�߽�
        imgHF2leftpnt=i;
        break;
    end
    if flag1==0 && i==imgHF2endschpnt %���޶ϵ㣬��ͼ���������̶����򣬱��flag2
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