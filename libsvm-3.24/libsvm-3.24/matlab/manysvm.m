acch=0;
acca=0;
for i=1:20
    [temp1 temp2]=svm();
    acch=acch+temp1;
    acca=acca+temp2;
end
acch=acch/20;
acca=acca/20;