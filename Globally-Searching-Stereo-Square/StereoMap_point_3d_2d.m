function [point_2d] = StereoMap_point_3d_2d(point_3d)
%OUR_POINT_3D_2D Summary of this function goes here
%   Detailed explanation goes here
x=point_3d(1,:)./(1-point_3d(3,:));
y=point_3d(2,:)./(1-point_3d(3,:));
point_2d=[x;y];

end

