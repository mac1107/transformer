[label,input] = libsvmread('traindata11.txt');
[testlabel,testinput] = libsvmread('testdata.txt');
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
model=svmtrain(label,input,'-t 0 -c 0.001');
% model=svmtrain(label,input,cmd);
[predict_label,accuracy,d]=svmpredict(testlabel,testinput,model);