function [angle_min,angle_max] = Angle_point_side_elevation(data,a,b1,b2)
%ANGLE_POINT_SIDE Summary of this function goes here
%   Detailed explanation goes here
    NUM=size(data,2);
    angle_min=zeros(1,NUM);
    angle_max=zeros(1,NUM);
    
%     x=data(1,:);
%     y=data(2,:);
    
    
    
%     ind_in=(y<=b2 &y>=b1);
%     t=acos(cos(a-x(ind_in))).*y(ind_in);
     
    h2=atan2(data(3,:),data(1,:)*cos(a)+data(2,:)*sin(a));
    
     ind_in=(h2<=b2 &h2>=b1);
    
   
    vertex_2d=[repmat(a,1,size(h2(ind_in),2));h2(ind_in)];
    vertex_3d= scsMapping_point_2d_3d(vertex_2d);
    
    t=acos(dot(data(:,ind_in),vertex_3d));
    angle_min(ind_in)=t;
    angle_min(~ind_in)=nan;
        
%     ind_in=(y<=b2 &y>=b1);
    angle_max(ind_in)=t;
    angle_max(~ind_in)=nan;
    
end
