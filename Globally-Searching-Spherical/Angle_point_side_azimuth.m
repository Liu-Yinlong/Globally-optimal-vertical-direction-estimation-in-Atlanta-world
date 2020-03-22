function [angle_min,angle_max] = Angle_point_side_azimuth(data,a,b1,b2)
%ANGLE_POINT_SIDE Summary of this function goes here
%   Detailed explanation goes here
    NUM=size(data,2);
    angle_min=zeros(1,NUM);
    angle_max=zeros(1,NUM);
    
    x=data(1,:);
    y=data(2,:);
    ind_in_min=(x<=b2 &x>=b1);
    angle_min(ind_in_min)=abs(a-y(ind_in_min));
    angle_min(~ind_in_min)=nan;
        
    x_=x;
    x_(x<0)=x(x<0)+pi;
    x_(x>0)=x(x>0)-pi;
    
    ind_in_max=(x_<=b2 &x_>=b1);
    angle_max(ind_in_max)=abs(pi-abs(-y(ind_in_max)-a));
    angle_max(~ind_in_max)=nan;
    
end

