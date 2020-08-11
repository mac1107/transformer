clear all;
close all;
clc;
refdata=load('refdata.txt');
reff=refdata(:,1);
refmag=refdata(:,2);
crtdata=load('crtdata.txt');
crtf=crtdata(:,1);
crtmag=crtdata(:,2);
semilogx(reff,refmag,'-b','LineWidth',1.5);
hold on;
semilogx(crtf,crtmag,'r','LineWidth',1.5);
load('fix_f.mat');
finalrf=[];
finalcf=[];
finalr=[];
finalc=[];

for i=1: length(f);
    fixed_f=f(i);
    for j=1:length(reff)-1
        if reff(j)<fixed_f && reff(j+1)>fixed_f
            fixed_mag=refmag(j)-(refmag(j)-refmag(j+1))*(fixed_f-reff(j+1))/(reff(j)-reff(j+1));
            finalrf(i)=fixed_f;
            finalr(i)=fixed_mag;
        elseif reff(j)==fixed_f
            finalrf(i)=fixed_f;
            finalr(i)=refmag(j);
            
        end
    end
    for j=1:length(crtf)-1
        if crtf(j)<fixed_f && crtf(j+1)>fixed_f
            fixed_mag=crtmag(j)-(crtmag(j)-crtmag(j+1))*(fixed_f-crtf(j+1))/(crtf(j)-crtf(j+1));
            finalcf(i)=fixed_f;
            finalc(i)=fixed_mag;
        elseif crtf(j)==fixed_f
            finalcf(i)=fixed_f;
            finalc(i)=crtmag(j);
        end
    end
end

finaldata=[];
for i=1:length(finalrf)
    for j=1:length(finalcf)
        if finalrf(i)==finalcf(j)
            finaldata=[finaldata;finalrf(i) finalr(i) finalc(j)];
        end
    end
end

figure,semilogx(finaldata(:,1),finaldata(:,2),'-b','LineWidth',1.5);
hold on;
semilogx(finaldata(:,1),finaldata(:,3),'r','LineWidth',1.5);
save('data/changename.txt', 'finaldata','-ascii');
