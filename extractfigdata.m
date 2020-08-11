function [] = extractfigdata( figname,figcolor,figheight,figwidth,xmax,xmin,ymax,ymin)
%% definition of some function parameters
% xmax x轴最大值对应的10的幂数
% xmin x轴最小值对应的10的幂数
% ymax y轴的最大值
% ymin y轴的最小值

A=imread(figname);
carray=[]; %存放每一列所提取颜色像素点的矩阵
ccount=1;
curvecount=1;
ccurve=[];
f=[];
for i=1:figwidth
    for j=1:figheight
        % 根据颜色确定所需要提取的像素点的rgb值
        if strcmp(figcolor,'blue')
            if A(j,i,1)==0 && A(j,i,2)==0 && A(j,i,3)==255
                carray(ccount)=j;
                ccount=ccount+1;
            end
        end
        if strcmp(figcolor,'red')
            if A(j,i,1)==255 && A(j,i,2)==0 && A(j,i,3)==0
                carray(ccount)=j;
                ccount=ccount+1;
            end
        end
    end
    cmax=max(carray); %该像素列中具有所求颜色值的像素点中的最大值
    cmin=min(carray); %该像素列中具有所求颜色值的像素点中的最小值  
    cmean=(cmax+cmin)/2;
    cdb=ymax-cmean/figheight*(ymax-ymin); %将像素坐标转化为实际的db值
    fvalue=10^(i/figwidth*(xmax-xmin)+xmin); %%将像素坐标转化为实际的f值
    if ~isempty(cdb) %检验某一列是否存在所读颜色的像素点
        ccurve(curvecount)=cdb;
        f(curvecount)=fvalue;
        curvecount=curvecount+1;
    end
    carray=[];
    ccount=1;

end
plotcount=1;
fplot=[];
cplot=[];
%每间隔10个像素点取一个值
for i=1:10:curvecount
    fplot(plotcount)=f(i);
    cplot(plotcount)=ccurve(i);
    plotcount=plotcount+1;
end
figure,semilogx(fplot,cplot,'--b');
fplot=fplot';
cplot=cplot';
data=[fplot cplot];
datafilename = strrep(figname,'tif','txt');
save(datafilename, 'data','-ascii');
end

