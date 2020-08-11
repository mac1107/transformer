%% Morphology operators
% function: erosion 
%     data: the ONE dimension signal;
%     se  : Martix (2*1); the first row is quanlity of se
%                         the second row is Subscript of se;
%     D   : the same length with data.

function D  = eros( data,se )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    temp = zeros(1,length(se(2,:)));
    D = zeros(1,length(data));
    for loop1 = (length(se(2,:))+1)/2:length(data)-length(se(2,:))
        for loop2 = 1:length(se(2,:))
            temp(loop2) = data(loop1+se(2,loop2))-se(1,loop2);
        end
        D(1,loop1) = min(temp);
    end

end
