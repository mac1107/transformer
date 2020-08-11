clear all,close all, clc;
data=load('linshi');
load('linshi');
standard=fuck1;
clear fuck1;
casenames=fieldnames(data);
for i=1:size(casenames)-1
    casename=char(casenames(i));
    casedata=getfield(data, casename);
    fcase=casedata(:,1);
    pin=1;
%     casedata(:,4)=casedata(:,3);
    for j=1:size(fcase,1)
        while fcase(j)~=standard(pin,1)
            pin=pin+1;
        end
        casedata(j,3)=standard(pin,2);%magnitude
%         casedata(j,5)=standard(pin,3);%phase
        pin=pin+1;
    end
    eval([casename,'=','casedata',';']);
end

figure;
% subplot(2,1,1);
semilogx(fuck2(:,1),fuck2(:,2));
hold on;
semilogx(fuck2(:,1),fuck2(:,3));
semilogx(fuck3(:,1),fuck3(:,2));
semilogx(fuck3(:,1),fuck3(:,3));
semilogx(fuck4(:,1),fuck4(:,2));
semilogx(fuck4(:,1),fuck4(:,3));
% legend('gnd1','standard');
% subplot(2,1,2);
% semilogx(gnd1(:,1),gnd1(:,4));
% hold on;
% semilogx(gnd1(:,1),gnd1(:,3));
% legend('gnd1','standard');
clear casenames casename casedata fcase pin i j data standard;