function hauspara= calHausdorff(data,casename)
%CALHAUSDORFF 此处显示有关此函数的摘要
%   此处显示详细说明
subbands=detectsubbands_v5(data,casename);

hauspara=[];
for i=1:size(subbands,1)
    para=cal(data,casename,subbands(i,1),subbands(i,2));
    hauspara=[hauspara para];
end
end

function para=cal(data,casename,bound1,bound2)
casedata=getfield(data,casename);
[f,Ref,Measured,~,~,~,~,~,~,~,~,~,~,~,~]=getinformation(casedata);
%% h1
h1=0;
for i=1:size(f)
    minimum=100000;
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        for j=1:size(f)
            minimum=min(sqrt((log10(f(i))-log10(f(j)))^2+(Ref(i)-Measured(j))^2),minimum);
        end
    end
    h1=max(h1,minimum);
end
%% h2
h2=0;
for i=1:size(f)
    minimum=100000;
    if f(i)<bound1
        continue
    elseif f(i)>bound2
        break
    else
        for j=1:size(f)
            minimum=min(sqrt((log10(f(i))-log10(f(j)))^2+(Measured(i)-Ref(j))^2),minimum);
        end
    end
    h2=max(h2,minimum);
end
para=max(h1,h2);
end

