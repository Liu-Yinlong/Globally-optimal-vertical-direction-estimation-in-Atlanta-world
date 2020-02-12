function [p_3d] = ExpMapping_point_2d_3d(p_2d)
%H_POINT_2D_3D Summary of this function goes here
%   unit norm <- exp 

theta=vecnorm(p_2d);

n=p_2d./theta;

p_3d=[cos(theta);

      n.*sin(theta)];


end

