clear all;
close all;
A=imread('case3_phase_blue.tif');
blue=[];
bcount=1;
curvecount=1;
bcurve=[];
f=[];
for i=1:2635
    for j=1:715
        if A(j,i,1)==0 && A(j,i,2)==0 && A(j,i,3)==255
            blue(bcount)=j;
            bcount=bcount+1;
        end
    end
    bmax=max(blue);
    bmin=min(blue);   
    bmean=(bmax-bmin)/2+bmin;
    bdb=-bmean/715*80;
    fvalue=10^(i/2635*6+1);
    if ~isempty(bdb)
        bcurve(curvecount)=bdb;
        f(curvecount)=fvalue;
        curvecount=curvecount+1;
    end
    blue=[];
    bcount=1;
end
plotcount=1;
fplot=[];
bplot=[];
for i=1:10:curvecount
    fplot(plotcount)=f(i);
    bplot(plotcount)=bcurve(i);
    plotcount=plotcount+1;
end
figure,semilogx(fplot,bplot,'--b');