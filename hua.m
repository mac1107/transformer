%% c gnd
clear,clc,close all;
load('data/gnd_c45.mat');
load('data/gnd_c50.mat');
load('data/gnd_c55.mat');
h=figure(1);
semilogx(gnd_c45(:,1),gnd_c45(:,2),'LineWidth',1);
hold on;
semilogx(gnd_c45(:,1),gnd_c45(:,3),'LineWidth',1);
semilogx(gnd_c50(:,1),gnd_c50(:,3),'LineWidth',1);
semilogx(gnd_c55(:,1),gnd_c55(:,3),'LineWidth',1);
legend('standard','c45 grounded','c50 grounded','c55 grounded');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/c_gnd.tif');
close(h);

%% b gnd
clear,clc,close all;
load('data/gnd_b45.mat');
load('data/gnd_b50.mat');
load('data/gnd_b55.mat');
h=figure(1);
semilogx(gnd_b45(:,1),gnd_b45(:,2),'LineWidth',1);
hold on;
semilogx(gnd_b45(:,1),gnd_b45(:,3),'LineWidth',1);
semilogx(gnd_b50(:,1),gnd_b50(:,3),'LineWidth',1);
semilogx(gnd_b55(:,1),gnd_b55(:,3),'LineWidth',1);
legend('standard','b45 grounded','b50 grounded','b55 grounded');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/b_gnd.tif');
close(h);

%% a gnd
clear,clc,close all;
load('data/gnd_a45.mat');
load('data/gnd_a50.mat');
load('data/gnd_a55.mat');
h=figure(1);
semilogx(gnd_a45(:,1),gnd_a45(:,2),'LineWidth',1);
hold on;
semilogx(gnd_a45(:,1),gnd_a45(:,3),'LineWidth',1);
semilogx(gnd_a50(:,1),gnd_a50(:,3),'LineWidth',1);
semilogx(gnd_a55(:,1),gnd_a55(:,3),'LineWidth',1);
legend('standard','a45 grounded','a50 grounded','a55 grounded');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/a_gnd.tif');
close(h);

%% radial_1
clear,clc,close all;
load('data/radial_1.mat');
h=figure(1);
semilogx(radial_1(:,1),radial_1(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(radial_1(:,1),radial_1(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','径向1面变形');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/radial_1.tif');
close(h);

%% radial_3
clear,clc,close all;
load('data/radial_3.mat');
h=figure(1);
semilogx(radial_3(:,1),radial_3(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(radial_3(:,1),radial_3(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','径向3面变形');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/radial_3.tif');
close(h);

%% shortedturn
clear,clc,close all;
load('data/shortedturn_b1_2.mat');
load('data/shortedturn_b1_3.mat');
load('data/shortedturn_b3_4.mat');
h=figure(1);
semilogx(shortedturn_b1_2(:,1),shortedturn_b1_2(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(shortedturn_b1_2(:,1),shortedturn_b1_2(:,3),'LineWidth',1,'Color',[1 0 0]);
% semilogx(shortedturn_b1_3(:,1),shortedturn_b1_3(:,3));
% semilogx(shortedturn_b3_4(:,1),shortedturn_b3_4(:,3));
legend('standard','B相1饼2饼短路');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/shortedturn.tif');
close(h);

%% axial
clear,clc,close all;
load('data/axial.mat');
h=figure(1);
semilogx(axial(:,1),axial(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(axial(:,1),axial(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','轴向变形');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/axial.tif');
close(h);

%% no_gnd
clear,clc,close all;
load('data/a_core_no_gnd.mat');
h=figure(1);
semilogx(a_core_no_gnd(:,1),a_core_no_gnd(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(a_core_no_gnd(:,1),a_core_no_gnd(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','A相铁芯未接地');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/a_core_no_gnd.tif');
close(h);

load('data/b_core_no_gnd.mat');
h=figure(1);
semilogx(b_core_no_gnd(:,1),b_core_no_gnd(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(b_core_no_gnd(:,1),b_core_no_gnd(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','B相铁芯未接地');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/b_core_no_gnd.tif');
close(h);

load('data/c_core_no_gnd.mat');
h=figure(1);
semilogx(c_core_no_gnd(:,1),c_core_no_gnd(:,2),'LineWidth',1,'Color',[0 0 1]);
hold on;
semilogx(c_core_no_gnd(:,1),c_core_no_gnd(:,3),'LineWidth',1,'Color',[1 0 0]);
legend('standard','C相铁芯未接地');
xlabel('Frequency/Hz');
ylabel('Magnitude/dB');
print('-dtiff','-r600','leizhu/C_core_no_gnd.tif');
close(h);

