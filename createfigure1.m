function frame=createfigure1(X1, Y1)
%CREATEFIGURE1(X1, Y1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��

%  �� MATLAB �� 02-Oct-2019 23:12:21 �Զ�����

% ���� figure
figure1 = figure('InvertHardcopy','off','Color',[1 1 1],...
    'Renderer','painters');

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot(X1,Y1,'LineWidth',1,'Color',[0 0 1]);
set(gcf,'position',[1,1,3500,2625]);

% ȡ�������е�ע���Ա���������� X ��Χ
% xlim(axes1,[1 7]);
% ȡ�������е�ע���Ա���������� Y ��Χ
% ylim(axes1,[-90 -30]);
% ȡ�������е�ע���Ա���������� Z ��Χ
% zlim(axes1,[-1 1]);
box(axes1,'on');
% ������������������
set(axes1,'LineWidth',1);
frame=getframe(figure1);