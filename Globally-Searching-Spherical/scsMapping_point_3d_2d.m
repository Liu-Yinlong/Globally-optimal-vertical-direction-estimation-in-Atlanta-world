function [p_2d] = scsMapping_point_3d_2d(p_3d)
%H_POINT_2D_3D Summary of this function goes here
%   unit norm <- spherical coordinate system 

[azimuth,elevation,~] = cart2sph(p_3d(1,:),p_3d(2,:),p_3d(3,:));


p_2d=[azimuth;elevation];


end

