function [f,Ref,Measured,minRef,maxRef,minMeasured,maxMeasured,min_global,max_global,D,flength,min_f,max_f,RefPhase,MeasuredPhase]=getinformation(data)
    f=data(:,1);
    Ref=data(:,2);
    Measured=data(:,3);
    RefPhase=0;%data(:,5);
    MeasuredPhase=0;%data(:,4);
    minRef=min(Ref);
    maxRef=max(Ref);
    minMeasured=min(Measured);
    maxMeasured=max(Measured);
    min_global=min(minRef,minMeasured);
    max_global=max(maxRef,maxMeasured);
    D=max_global-min_global;
    flength=length(f);
    min_f=f(1);
    max_f=f(flength);
end