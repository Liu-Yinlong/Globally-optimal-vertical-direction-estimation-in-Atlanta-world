function [new_lower,new_upper] = scsMapping_bounds(B,Vec_any,epsilon)
%BOUNDS 
%   c_solid: center of the branch
% 	half_side:half_side of the branch
%   Vec_any: input normals
%   epsilon:inlier threshold

% B=[c_solid-half_side;c_solid+half_side];
c_solid=0.5*(B(1:2,:)+B(3:4,:));
Point_middle_3d = scsMapping_point_2d_3d(c_solid);

dot_middle=abs(Vec_any'*Point_middle_3d);


[angle_min,angle_max] = scsAngle_point_square(Vec_any,B);


new_upper_pi_2=(((pi/2<=angle_max+epsilon) & (pi/2>=angle_min-epsilon)));

new_upper_0=(epsilon>=angle_min);

new_upper_pi=(pi-epsilon<=angle_max);


alpha_=cos(epsilon);
beta_=sin(epsilon);

new_upper=sum(new_upper_0|new_upper_pi_2|new_upper_pi);
new_lower=sum((dot_middle>=alpha_)|(dot_middle<=beta_));

end

