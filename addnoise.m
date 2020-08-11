clear all;
close all;
casename='axial3';
data=load(strcat('data/',casename,'.txt'));
f=data(:,1);
Origin=data(:,2);
Def1=data(:,3);
y=awgn(Origin(17:77),0.0005);
for i=17:77
    Origin(i)=y(i-16);
end
figure(1),semilogx(f,Origin,'b','LineWidth',1.5);
hold on;
semilogy(f,Def1,'r','LineWidth',1.5);
datawithnoise=[f Origin Def1];
save('axial3withnoise.txt','datawithnoise','-ascii');