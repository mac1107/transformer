clc,clear all;
casename={'asp','haus','cc','ASLE','MM'};
calander=[];
i=1;
result={};
while i<=41
    r=rand();
    if r<0.5
        calander=[calander;i];
    end
    i=i+1;
end
for i=1:size(casename,2)
    split(char(casename(i)),calander);
    [label,input] = libsvmread(strcat('train_',char(casename(i)),'.txt'));
    [testlabel,testinput] = libsvmread(strcat('test_',char(casename(i)),'.txt'));
    model=svmtrain(label,input,'-t 0 -c 100');
    [predict_label,accuracy,d]=svmpredict(testlabel,testinput,model);
    result{i,1}=char(casename(i));
    result{i,2}=accuracy(1);
end
result