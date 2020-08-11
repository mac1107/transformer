clear all;
close all;
Origin=load('data\radial2r.txt');
Degree=load('data\radial2c.txt');
f=linspace(1000,5e6,1000);
Origin2=Origin(1:200);
Degree2=Degree(1:200);
f2=f(1:200);
figure,semilogx(f2,Origin2,'r','LineWidth',2),hold on;
         semilogx(f2,Degree2,'--k','LineWidth',1.5),grid on;