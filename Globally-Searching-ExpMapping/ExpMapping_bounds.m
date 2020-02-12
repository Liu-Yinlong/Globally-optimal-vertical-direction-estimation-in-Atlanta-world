function [new_lower,new_upper] = ExpMapping_bounds(c_solid,half_side,Vec_any,epsilon)
%BOUNDS 
%   c_solid: center of the branch
% 	half_side:half_side of the branch
%   Vec_any: input normals
%   epsilon:inlier threshold

[Vec_center] = ExpMapping_point_2d_3d(c_solid);

dot_middle=abs(Vec_any'*Vec_center);

angle_radius=sqrt(2)*half_side;

% since max-angle_radius=sqrt(2)*pi/2/pi*180<128
% and  epsilon<10
% so max angle_radius+epsilon<<180
% then we do not check (angle_radius+epsilon>180?)

alpha=cos(angle_radius+epsilon);
beta=sin(angle_radius+epsilon);

alpha_=cos(epsilon);
beta_=sin(epsilon);

new_upper=sum((dot_middle>=alpha)|(dot_middle<=beta));

new_lower=sum((dot_middle>=alpha_)|(dot_middle<=beta_));

end

