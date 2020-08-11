data=load('case2.txt');
f=data(:,1);
mag=data(:,2);
phase=data(:,3);
plotcount=1;
fplot=[]
magplot=[];
phaseplot=[];
for i=1:10:length(f)
    fplot(plotcount)=f(i);
    magplot(plotcount)=mag(i);
    phaseplot(plotcount)=phase(i);
    plotcount=plotcount+1;
end
fplot=fplot';
magplot=magplot';
phaseplot=phaseplot';