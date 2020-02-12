function [V,num] = get_volume_2d(branches)
%GET_VOLUME_2D Summary of this function goes here
%   Detailed explanation goes here
num=size(branches,2);
s1=branches(3,:)-branches(1,:);
s2=branches(4,:)-branches(2,:);
V=sum(s1.*s2);
end

