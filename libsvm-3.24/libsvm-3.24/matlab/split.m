function split(filename,calander,iter)
fid1=fopen(strcat(iter,'train_',filename,'.txt'),'wt');
fid2=fopen(strcat(iter,'test_',filename,'.txt'),'wt');
phns=strcat(filename,'.txt');
fpn=fopen(phns,'rt'); 
count=1;
while feof(fpn)~=1
    new_str=fgetl(fpn);
    if ismember(count,calander)
        fprintf(fid1,'%s\n',new_str);
    else
        fprintf(fid2,'%s\n',new_str);
    end
    count=count+1;
end
fclose(fid1);
fclose(fid2);
fclose(fpn);