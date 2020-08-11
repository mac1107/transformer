%% Morphology
%% 2014.10.31
  clear all;
  close all;
%  tic
%% load FRA curve
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load('frequency_20-5M.mat');
% load('Exp_Mag_6Groups_20-5M.mat');
% f_2M=f(1:837);
% Origin=TB_5M(1:837,1);
% Def1=TB_5M(1:837,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
casename='radial1';
data=load(strcat('data/',casename,'.txt'));
f=data(:,1);
Origin=data(:,2);
Def1=data(:,3);
mino=min(Origin);
maxo=max(Origin);
mind=min(Def1);
maxd=max(Def1);
min_global=min(mino,mind);
max_global=max(maxo,maxd);
D=max_global-min_global;
figure(1),semilogx(f,Origin,'b','LineWidth',1.5);
hold on;
semilogx(f,Def1,'-r','LineWidth',1.5);
xlabel('f / Hz');
ylabel('·ùÖµ / db');
% legend('²Î¿¼ÆµÏìÇúÏß','Êµ²âÆµÏìÇúÏß');

print(1, '-dtiff',strcat('originalimage/',casename));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% call fun to get binary image
B_image=Binary_v5(casename);
%-------------------------------------------------
% plot for compare
%subplot(2,1,semilogx(f,Origin,'b','LineWidth',2),semilogx(f,Def1,'r','LineWidth',2));
   

%---------------------------------------------

M = round(0.1*D);
element = [M 1];
%M =  [1 1];
%originalBW = imread('binary_image.png');
%mout = ones(rev,size);
se = strel('rectangle',element);
mout = imerode(B_image,se);
% for i = 1:rev
%     for j = 1:size
% 
%         se = strel('rectangle',element);
%         %element = M(j);
%         %se = ones() ;
%         se = strel('rectangle',element);
%         %se = strel('square',element);
%         %mout(i,j) = imerode(originalBW(i,j),se);
%         mout(i,j) = imerode(B_image(i,j),se);
%         %mout = erode(originalBW,se);
% 
%     end

%end
save(strcat('mm_results\',casename,'.mat'),'mout');
imwrite(mout,strcat('mm_results\',casename,'.tif'),'tif');
% figure(1)
% %image(originalBW);
% image(mout);


% figure(2);
% for i = 1: a_p_max
%   for j = 1: size
%    plot(f(j),mout(i,j),'r--')
%       hold on
%   end
% end
% 
