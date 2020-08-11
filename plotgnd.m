clear all;
close all;
data=load('½ÓµØ¶ÌÂ·');
load('standard');
casenames=fieldnames(data);
for i=1:length(casenames)-1
    casename=char(casenames(i));
    out=getfield(data,casename);
    f0=out(:,1);
    f1=log10(f0);
    origin0=out(:,2);
    createfigure2(f1,origin0,log10(standard(:,1)),standard(:,2));
    print('-dtiffn','-r600',strcat(casename,'.tif'));
    close;
%     break;
end