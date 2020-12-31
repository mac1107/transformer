function ASLE=calASLE(data,casename,subbands)
% subbands=detectsubbands_v5(data,casename);

ASLE=[];
for i=1:size(subbands,1)
    para=cal(data,casename,subbands(i,1),subbands(i,2));
    ASLE=[ASLE para];
end
save(strcat('ASLEresult\',casename,'.mat'),'ASLE');
end

function para=cal(data,casename,bound1,bound2)
casedata=getfield(data,casename);
[f,Ref,Measured,~,~,~,~,~,~,~,~,~,~,~,~]=getinformation(casedata);
sum=0;
count=0;
for i=1:size(f)
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        sum=sum+abs(Ref(i)-Measured(i));
        count=count+1;
    end
end
para=sum/count;
if isnan(para)
    para=0;
end
end