function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1,YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 30-Mar-2015 10:51:18

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XScale','log','XMinorTick','on');
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to semilogx
semilogx1 = semilogx(X1,YMatrix1);
set(semilogx1(2),'Color',[1 0 0]);

% Create line
annotation(figure1,'line',[0.5234375 0.522916666666667],...
    [1 0.12807881773399]);

% Create line
annotation(figure1,'line',[0.3703125 0.369791666666667],...
    [0.912811007268951 0.115264797507788]);

% Create textbox
annotation(figure1,'textbox',...
    [0.202041666666667 0.395730706075534 0.027125 0.0443349753694578],...
    'String',{'LF1'},...
    'HorizontalAlignment','center',...
    'FontSize',14,...
    'FitBoxToText','off');

