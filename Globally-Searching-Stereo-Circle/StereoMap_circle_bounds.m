function [new_lower,new_upper] = StereoMap_circle_bounds(c_solid,half_side,Vec_any,epsilon)
%CIRCLE_BOUND 
%   c_solid: center of the branch
% 	half_side:half_side of the branch
%   Vec_any: input normals
%   epsilon:inlier threshold

Point_1_2d=c_solid+sqrt(2)*half_side;
Point_2_2d=c_solid-sqrt(2)*half_side;
Point_3_2d=[c_solid(1)-sqrt(2)*half_side;c_solid(2)+sqrt(2)*half_side];

Point_1_3d= StereoMap_point_2d_3d(Point_1_2d);
Point_2_3d= StereoMap_point_2d_3d(Point_2_2d);
Point_3_3d= StereoMap_point_2d_3d(Point_3_2d);


Point_middle_3d_non_unit=cross(Point_1_3d-Point_3_3d,Point_2_3d-Point_3_3d);
Point_middle_3d=Point_middle_3d_non_unit./norm(Point_middle_3d_non_unit);

angle_radius=abs(acos(Point_middle_3d'*Point_1_3d));

dot_middle=abs(Vec_any'*Point_middle_3d);

alpha=cos(angle_radius+epsilon);
beta=sin(angle_radius+epsilon);

alpha_=cos(epsilon);
beta_=sin(epsilon);

new_upper=sum((dot_middle>=alpha)|(dot_middle<=beta));

new_lower=sum((dot_middle>=alpha_)|(dot_middle<=beta_));


end

