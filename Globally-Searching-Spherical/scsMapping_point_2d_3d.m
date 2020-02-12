function [p_3d] = scsMapping_point_2d_3d(p_2d)
%H_POINT_2D_3D Summary of this function goes here
%   unit norm <- spherical coordinate system 

[x,y,z] = sph2cart(p_2d(1,:),p_2d(2,:),1);


p_3d=[x;y;z];


end

