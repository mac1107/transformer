clear all;
close all;
data=load('½ÓµØ¶ÌÂ·');
casenames=fieldnames(data);
for i=1:length(casenames)
    casename=char(casenames(i));
    out=getfield(data,casename);
    f0=out(:,1);
    origin0=out(:,2);
    processdwt(f0,origin0,casename);
    break;
end
% close all;