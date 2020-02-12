function [plane_data] = gen_syn_data_plane(number,P1,P2,P3)
%GEN_SYN_DATA_PLANE Summary of this function goes here
%   
%   number: point number of the plane
%   P1:left-down point of the plane
%   P2:left-up point of the plane
%   P3:right-down point of the plane
n1=P2-P1;
n2=P3-P1;
plane_data=P1+[n1,n2]*rand(2,number);

end

