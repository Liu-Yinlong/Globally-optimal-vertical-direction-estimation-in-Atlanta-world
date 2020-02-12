function [V,num] = get_volume_2d_radius(branches)
%GET_VOLUME_2D_RADIUS Summary of this function goes here
%   Detailed explanation goes here
num=size(branches,2);
V=4*sum(branches(3,:).^2);
end

