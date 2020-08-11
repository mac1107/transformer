%%
% function [acch,acca]=svm()
clc,clear all;
fid1=fopen('trainhaus1.txt','wt');%新建一个txt文件??
fid2=fopen('trainhaus2.txt','wt');
fid3=fopen('trainasp1.txt','wt');%新建一个txt文件??
fid4=fopen('trainasp2.txt','wt');
phns1='haus1.txt';%要读取的文档所在的路径??
phns2='asp1.txt';
fpn1=fopen(phns1,'rt'); %打开文档??
fpn2=fopen(phns2,'rt'); 
while feof(fpn1)~=1%用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0??
    file1=fgetl(fpn1);%获取文档第一行?? ? ? ? ? ? ? ? ? ? ? ? ?
    file2=fgetl(fpn2);
    new_str1=file1;
    new_str2=file2;
    r=rand();
    if r>0.5
        fprintf(fid1,'%s\n',new_str1);
        fprintf(fid3,'%s\n',new_str2);
    else
        fprintf(fid2,'%s\n',new_str1);
        fprintf(fid4,'%s\n',new_str2);
    end
end

fclose(fid1);
fclose(fid2);
fclose(fid3);
fclose(fid4);
fid1=fopen('trainhaus1.txt','a');%新建一个txt文件??
fid2=fopen('trainhaus2.txt','a');
fid3=fopen('trainasp1.txt','a');%新建一个txt文件??
fid4=fopen('trainasp2.txt','a');
phns1='haus2.txt';%要读取的文档所在的路径??
phns2='asp2.txt';
fpn1=fopen(phns1,'rt'); %打开文档??
fpn2=fopen(phns2,'rt'); 
while feof(fpn1)~=1%用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0??
    file1=fgetl(fpn1);%获取文档第一行?? ? ? ? ? ? ? ? ? ? ? ? ?
    file2=fgetl(fpn2);
    new_str1=file1;
    new_str2=file2;
    r=rand();
    if r>0.5
        fprintf(fid1,'%s\n',new_str1);
        fprintf(fid3,'%s\n',new_str2);
    else
        fprintf(fid2,'%s\n',new_str1);
        fprintf(fid4,'%s\n',new_str2);
    end
end
phns1='haus3.txt';%要读取的文档所在的路径??
phns2='asp3.txt';
fpn1=fopen(phns1,'rt'); %打开文档??
fpn2=fopen(phns2,'rt'); 
while feof(fpn1)~=1%用于判断文件指针p在其所指的文件中的位置，如果到文件末，函数返回1，否则返回0??
    file1=fgetl(fpn1);%获取文档第一行?? ? ? ? ? ? ? ? ? ? ? ? ?
    file2=fgetl(fpn2);
    new_str1=file1;
    new_str2=file2;
    r=rand();
    if r>0.5
        fprintf(fid1,'%s\n',new_str1);
        fprintf(fid3,'%s\n',new_str2);
    else
        fprintf(fid2,'%s\n',new_str1);
        fprintf(fid4,'%s\n',new_str2);
    end
end
fclose(fid1);
fclose(fid2);
%%
[label,input] = libsvmread('trainhaus1.txt');
[testlabel,testinput] = libsvmread('trainhaus2.txt');
% [input,pstrain] = mapminmax(input');
% pstrain.ymin = 0;
% pstrain.ymax = 1;
% [input,pstrain] = mapminmax(input,pstrain);
% 
% [testinput,pstest] = mapminmax(testinput');
% pstest.ymin = 0;
% pstest.ymax = 1;
% [testinput,pstest] = mapminmax(testinput,pstest);
% input=input';
% testinput=testinput';
% [bestacc,bestc,bestg] = SVMcg(label,input,-20,20,-20,20,3,0.5,0.5,0.9);
% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model=svmtrain(label,input,'-t 0 -c 1');
% model=svmtrain(label,input,cmd);
[predict_label,accuracy,d]=svmpredict(testlabel,testinput,model);
% acch=accuracy(1);
[label,input] = libsvmread('trainasp1.txt');
[testlabel,testinput] = libsvmread('trainasp2.txt');
model=svmtrain(label,input,'-t 0 -c 1');
[predict_label,accuracy,d]=svmpredict(testlabel,testinput,model);
% acca=accuracy(1);
% end