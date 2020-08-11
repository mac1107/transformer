data=load('treateddata.mat');
casenames=fieldnames(data);
for i=1:size(casenames)-1
    casename=char(casenames(i));
    casedata=getfield(data, casename);
    casedata=casedata(:,1:3);
    temp=casedata(:,3);
    casedata(:,3)=casedata(:,2);
    casedata(:,2)=temp;
    eval([casename,'=','casedata',';']);
end
clear temp i casenames data casename casedata;