%% Edit by Lin Huan
%% Re-edit by ZZW
%% 2015.03.27
%% ×¢ÊÍBinary_v4_test.m
function [bimage,D]=Binary_v5(casename)
originalimage=strcat('originalimage\',casename,'.tif');
A=imread(originalimage);
red=A(:,:,1);
blue=A(:,:,3);
Asize=size(A);
height=Asize(1);
width=Asize(2);
bimage=zeros(height,width);
     local_blue=zeros(1,width);
     local_red=zeros(1,width);
for i=1:width
     red_exist=0;
     blue_exist=0;
    for j=1:height
        if red(j,i)>240 && blue(j,i)<40
            local_blue(i)=j;
            blue_exist=1;
        elseif red(j,i)<40 && blue(j,i)>240
            local_red(i)=j;
            red_exist=1;
        else
        end
    end
         for j=1:height
             if blue_exist && red_exist && ((j-local_red(i))*(j-local_blue(i)))<0           
                bimage(j,i)=1;
             end
         end

end
max_r=max(local_red);
min_r=min(local_red);
max_b=max(local_blue);
min_b=min(local_blue);
max_global=max(max_r,max_b);
min_global=min(min_r,min_b);
D = max_global-min_global;
imwrite(bimage,strcat('trans_binary_image\',casename,'.tif'),'tif');
% close;