function [Q_upper,Q_lower] = get_bound_Manhattan(start_axis,data,B,epsilon)
%GET_BOUND_MANHATTAN Summary of this function goes here
%   Detailed explanation goes here
B_c=0.5*(B(1:3)+B(4:6));
R_c=rotationVectorToMatrix(B_c);
delta_B=0.5*(norm(B(4:6)-B(1:3)));

axis=R_c*start_axis;


dot=abs(axis'*data);


angle_middle=abs(acos(dot));

Q_lower=sum(sum(angle_middle<=epsilon));
Q_upper=sum(sum(angle_middle<=epsilon+delta_B));

end

