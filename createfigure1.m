function frame=createfigure1(X1, Y1)
%CREATEFIGURE1(X1, Y1)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量

%  由 MATLAB 于 02-Oct-2019 23:12:21 自动生成

% 创建 figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1],...
    'Renderer','painters');

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(X1,Y1,'LineWidth',1,'Color',[0 0 1]);
set(gcf,'position',[1,1,3500,2625]);

% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(axes1,[1 7]);
% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(axes1,[-90 -30]);
% 取消以下行的注释以保留坐标轴的 Z 范围
% zlim(axes1,[-1 1]);
box(axes1,'on');
% 设置其余坐标轴属性
set(axes1,'LineWidth',1);
frame=getframe(figure1);