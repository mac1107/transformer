close all;
data=load('data/axial1.txt');
Origin=data(:,2);
Def=data(:,3);
f=data(:,1);
semilogx(f,Origin,'-b','LineWidth',1.5);
hold on;
semilogx(f,Def,'r','LineWidth',1.5);
se1 = [  0 0 0; -1 0 1  ];
output1 = eros(Origin,se1);
output2 = dila(output1,se1);
output3 = dila(output2,se1);
output4 = eros(output3,se1);
output = output1 - output2;
figure;
plot(Origin);%导出时使用固定线宽1磅
hold on;
plot(output4,'r');
%%
close all;
%semilogx(axial1(:,1),axial1(:,2));
semilogx(axial1c(:,1),axial1c(:,2),axial1r(:,1),axial1r(:,2));