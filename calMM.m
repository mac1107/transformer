function MM=calMM(data,casename,subbands)
% subbands=detectsubbands_v5(data,casename);

MM=[];
for i=1:size(subbands,1)
    para=cal(data,casename,subbands(i,1),subbands(i,2));
    MM=[MM para];
end
save(strcat('MMresult\',casename,'.mat'),'MM');
end

function para=cal(data,casename,bound1,bound2)
casedata=getfield(data,casename);
[f,Ref,Measured,~,~,~,~,~,~,~,~,~,~,~,~]=getinformation(casedata);
sum1=0;
sum2=0;
for i=1:size(f)
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        sum1=sum1+min(Ref(i),Measured(i));
        sum2=sum2+max(Ref(i),Measured(i));
    end
end
para=sum1/sum2;
if isnan(para)
    para=0;
end
end