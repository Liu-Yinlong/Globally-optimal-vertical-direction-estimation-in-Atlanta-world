function [Q_upper,Q_lower]= get_bound_Atlanta(Vec,data,B,epsilon)


B_c=0.5*(B(1:3)+B(4:6));
R_c=rotationVectorToMatrix(B_c);
delta_B=0.5*(norm(B(4:6)-B(1:3)));



direction=R_c*Vec;

dot=abs(direction'*data);


angle_middle=abs(acos(dot));

Q_lower=sum((angle_middle<=epsilon)|(angle_middle>=pi/2-epsilon));
Q_upper=sum((angle_middle<=epsilon+delta_B)|(angle_middle>=pi/2-epsilon-delta_B));

end