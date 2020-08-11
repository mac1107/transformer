clear all;
close all;
casename='radial1';

newMImage=strcat('trans_binary_image/',casename,'.tif');
newM=imread(newMImage);
Msize=size(newM);
height=Msize(1);
width=Msize(2);

transM=zeros(height,width);

for i=1:height
    for j=1:width
        if newM(i,j)==255
            transM(i,j)=0;
        elseif newM(i,j)==0
            transM(i,j)=255;
        end
    end
end

imwrite(transM,strcat('trans/',casename,'1.tif'),'tif');