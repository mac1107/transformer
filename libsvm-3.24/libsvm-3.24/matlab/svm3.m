%% step 1
clc,clear all;
casename={'haus','cc','ASLE','MM'};
calander=[];
j=1;
result={};
model={};
label={};
input={};
predict_label={};
testlabel={};
testinput={};
accuracy={};

while j<=41
    r=rand();
    if r<0.5
        calander=[calander;j];
    end
    j=j+1;
end

for j=1:size(casename,2)
    split(char(casename(j)),calander,'');
    [label{j},input{j}] = libsvmread(strcat('train_',char(casename(j)),'.txt'));
    [testlabel{j},testinput{j}] = libsvmread(strcat('test_',char(casename(j)),'.txt'));
    model{j}=svmtrain(label{j},input{j},'-t 0 -c 5 -b 1');
    [predict_label{j},accuracy{j},prob{j}]=svmpredict(testlabel{j},testinput{j},model{j}, '-b 1');
    result{j,1}=char(casename(j));
    result{j,2}=accuracy{j}(1);
end
%% step 2
iter=50;

iter_predict_label={};
iter_testlabel={};
iter_testinput={};
iter_accuracy={};
score=zeros(1,4);
for i=1:iter
    list=[];
    while j<=41
        r=rand();
        if r<0.5
            list=[list;j];
        end
        j=j+1;
    end
    for j=1:size(casename,2)
    split(char(casename(j)),list,'iter_');
    [iter_testlabel{i,j},iter_testinput{i,j}] = libsvmread(strcat('iter_test_',char(casename(j)),'.txt'));
    [iter_predict_label{i,j},iter_accuracy{i,j},~]=svmpredict(iter_testlabel{i,j},iter_testinput{i,j},model{j});
    iter_result{i,j}=char(casename(j));
    iter_result{i,j}=iter_accuracy{i,j}(1);
    
    tf=iter_testlabel{i,j}==iter_predict_label{i,j};
    score(j)=score(j)+sum(tf(:)==1)-sum(tf(:)==0);
    end
end
weights=score/sum(score);
n=size(testlabel{1},1);
final=zeros(n,1);
for i=1:n
    temp=zeros(1,3);
    for j=1:4
%         index=predict_label{j}(i);
        for k=1:3
            temp(k)=temp(k)+prob{j}(i,k)*weights(j);
        end
    end
    max_index=-1;
    maximum=0;
    for j=1:3
        if temp(j)>maximum
            max_index=j;
            maximum=temp(j);
        end
    end
    final(i)=max_index;
end
tf=final==testlabel{1};
result
acc=sum(tf(:)==1)/n