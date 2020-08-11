Origin=load('FIXED_DATA2014.11.19\Fixed_p91-c1_1b.txt');
Def=load('FIXED_DATA2014.11.19\Fixed_p91-c1_1r.txt');
f=load('FIXED_DATA2014.11.19\fixed-f.txt');
RangePoint=[2834 67386.27 425178.6 719685.7];
LF1_up=0.5*(f(1)+RangePoint(1));
LF2_up=0.5*(RangePoint(1)+RangePoint(2));
MF1_up=RangePoint(2);
MF2_up=0.5*(RangePoint(2)+RangePoint(3));
MF3_up=RangePoint(3);
HF1_up=RangePoint(4);
HF2_up=f(length(f));
%% variables for cal cc
CC_LF1=0;
CC_LF2=0;
CC_MF1=0;
CC_MF2=0;
CC_MF3=0;
CC_HF1=0;
CC_HF2=0;
sum1CC_LF1=0;
sum1CC_LF2=0;
sum1CC_MF1=0;
sum1CC_MF2=0;
sum1CC_MF3=0;
sum1CC_HF1=0;
sum1CC_HF2=0;
sum2CC_LF1=0;
sum2CC_LF2=0;
sum2CC_MF1=0;
sum2CC_MF2=0;
sum2CC_MF3=0;
sum2CC_HF1=0;
sum2CC_HF2=0;

%% variables for cal I_MM
I_MM_LF1=0;
I_MM_LF2=0;
I_MM_MF1=0;
I_MM_MF2=0;
I_MM_MF3=0;
I_MM_HF1=0;
I_MM_HF2=0;
min_LF1=0;
max_LF1=0;
min_LF2=0;
max_LF2=0;
min_MF1=0;
max_MF1=0;
min_MF2=0;
max_MF2=0;
min_MF3=0;
max_MF3=0;
min_HF1=0;
max_HF1=0;
min_HF2=0;
max_HF2=0;
%%
for i=1:1:length(f)
    if f(i)<=LF1_up
       CC_LF1=CC_LF1+Origin(i)*Def(i);
       sum1CC_LF1=sum1CC_LF1+Origin(i)^2;
       sum2CC_LF1=sum2CC_LF1+Def(i)^2;
       min_LF1=min_LF1+min(abs(Origin(i)),abs(Def(i)));
       max_LF1=max_LF1+max(abs(Origin(i)),abs(Def(i)));
    end
    if f(i)>LF1_up && f(i)<=LF2_up
       CC_LF2=CC_LF2+Origin(i)*Def(i);
       sum1CC_LF2=sum1CC_LF2+Origin(i)^2;
       sum2CC_LF2=sum2CC_LF2+Def(i)^2;
       min_LF2=min_LF2+min(abs(Origin(i)),abs(Def(i)));
       max_LF2=max_LF2+max(abs(Origin(i)),abs(Def(i)));
    end
    if f(i)>LF2_up && f(i)<=MF1_up
       CC_MF1=CC_MF1+Origin(i)*Def(i);
       sum1CC_MF1=sum1CC_MF1+Origin(i)^2;
       sum2CC_MF1=sum2CC_MF1+Def(i)^2;
       min_MF1=min_MF1+min(abs(Origin(i)),abs(Def(i)));
       max_MF1=max_MF1+max(abs(Origin(i)),abs(Def(i)));       
    end
    if f(i)>MF1_up && f(i)<=MF2_up
       CC_MF2=CC_MF2+Origin(i)*Def(i);
       sum1CC_MF2=sum1CC_MF2+Origin(i)^2;
       sum2CC_MF2=sum2CC_MF2+Def(i)^2;
       min_MF2=min_MF2+min(abs(Origin(i)),abs(Def(i)));
       max_MF2=max_MF2+max(abs(Origin(i)),abs(Def(i)));
    end
    if f(i)>MF2_up && f(i)<=MF3_up
       CC_MF3=CC_MF3+Origin(i)*Def(i);
       sum1CC_MF3=sum1CC_MF3+Origin(i)^2;
       sum2CC_MF3=sum2CC_MF3+Def(i)^2;
       min_MF3=min_MF3+min(abs(Origin(i)),abs(Def(i)));
       max_MF3=max_MF3+max(abs(Origin(i)),abs(Def(i)));
    end
    if f(i)>MF3_up && f(i)<=HF1_up
       CC_HF1=CC_HF1+Origin(i)*Def(i);
       sum1CC_HF1=sum1CC_HF1+Origin(i)^2;
       sum2CC_HF1=sum2CC_HF1+Def(i)^2;
       min_HF1=min_HF1+min(abs(Origin(i)),abs(Def(i)));
       max_HF1=max_HF1+max(abs(Origin(i)),abs(Def(i)));
    end
    if f(i)>HF1_up
       CC_HF2=CC_HF2+Origin(i)*Def(i);
       sum1CC_HF2=sum1CC_HF2+Origin(i)^2;
       sum2CC_HF2=sum2CC_HF2+Def(i)^2;
       min_HF2=min_HF2+min(abs(Origin(i)),abs(Def(i)));
       max_HF2=max_HF2+max(abs(Origin(i)),abs(Def(i)));
    end
end

CC_LF1=CC_LF1/sqrt(sum1CC_LF1*sum2CC_LF1);
CC_LF2=CC_LF2/sqrt(sum1CC_LF2*sum2CC_LF2);
CC_MF1=CC_MF1/sqrt(sum1CC_MF1*sum2CC_MF1);
CC_MF2=CC_MF2/sqrt(sum1CC_MF2*sum2CC_MF2);
CC_MF3=CC_MF3/sqrt(sum1CC_MF3*sum2CC_MF3);
CC_HF1=CC_HF1/sqrt(sum1CC_HF1*sum2CC_HF1);
CC_HF2=CC_HF2/sqrt(sum1CC_HF2*sum2CC_HF2);

I_MM_LF1=1-min_LF1/max_LF1;
I_MM_LF2=1-min_LF2/max_LF2;
I_MM_MF1=1-min_MF1/max_MF1;
I_MM_MF2=1-min_MF2/max_MF2;
I_MM_MF3=1-min_MF3/max_MF3;
I_MM_HF1=1-min_HF1/max_HF1;
I_MM_HF2=1-min_HF2/max_HF2;



