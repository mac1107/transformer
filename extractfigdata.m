function [] = extractfigdata( figname,figcolor,figheight,figwidth,xmax,xmin,ymax,ymin)
%% definition of some function parameters
% xmax x�����ֵ��Ӧ��10������
% xmin x����Сֵ��Ӧ��10������
% ymax y������ֵ
% ymin y�����Сֵ

A=imread(figname);
carray=[]; %���ÿһ������ȡ��ɫ���ص�ľ���
ccount=1;
curvecount=1;
ccurve=[];
f=[];
for i=1:figwidth
    for j=1:figheight
        % ������ɫȷ������Ҫ��ȡ�����ص��rgbֵ
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
    cmax=max(carray); %���������о���������ɫֵ�����ص��е����ֵ
    cmin=min(carray); %���������о���������ɫֵ�����ص��е���Сֵ  
    cmean=(cmax+cmin)/2;
    cdb=ymax-cmean/figheight*(ymax-ymin); %����������ת��Ϊʵ�ʵ�dbֵ
    fvalue=10^(i/figwidth*(xmax-xmin)+xmin); %%����������ת��Ϊʵ�ʵ�fֵ
    if ~isempty(cdb) %����ĳһ���Ƿ����������ɫ�����ص�
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
%ÿ���10�����ص�ȡһ��ֵ
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

