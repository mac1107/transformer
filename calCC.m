function cc=calCC(data,casename,subbands)
% subbands=detectsubbands_v5(data,casename);

cc=[];
for i=1:size(subbands,1)
    para=cal(data,casename,subbands(i,1),subbands(i,2));
    cc=[cc para];
end
save(strcat('CCresult\',casename,'.mat'),'cc');
end

function para=cal(data,casename,bound1,bound2)
casedata=getfield(data,casename);
[f,Ref,Measured,~,~,~,~,min_global,max_global,~,~,~,~,~,~]=getinformation(casedata);
sum1=0;
sum2=0;
count=0;
for i=1:size(f)
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        sum1=sum1+Ref(i);
        sum2=sum2+Measured(i);
        count=count+1;
    end
end
up=0;
down1=0;
down2=0;
avg1=sum1/count;
avg2=sum2/count;
for i=1:size(f)
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        sub1=Ref(i)-avg1;
        sub2=Measured(i)-avg2;
        up=up+sub1*sub2;
        down1=down1+sub1^2;
        down2=down2+sub2^2;
    end
end
para=up/sqrt(down1*down2);
if isnan(para)
    para=0;
end
end