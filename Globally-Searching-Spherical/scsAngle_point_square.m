function [angle_min,angle_max] = scsAngle_point_square(data,B)
%SCSANGLE_POINT_SQUARE Summary of this function goes here
%   Detailed explanation goes here
    NUM=size(data,2);
    angle_min=zeros(1,NUM);
    angle_max=zeros(1,NUM);
    
    data_2d= scsMapping_point_3d_2d(data);
    x=data_2d(1,:);  
    y=data_2d(2,:);
    
    ind_x= (x>=B(1)) & (x<=B(3));
    ind_y= (y>=B(2)) & (y<=B(4));
    
    ind_in=ind_x&ind_y;
    
    data_2d=data_2d(:,~ind_in);
    
    [angle_min_1,angle_max_1] = Angle_point_side_azimuth(data_2d,B(2),B(1),B(3));
    [angle_min_2,angle_max_2] = Angle_point_side_azimuth(data_2d,B(4),B(1),B(3));
    
    [angle_min_3,angle_max_3] = Angle_point_side_elevation(data_2d,B(1),B(2),B(4));
    [angle_min_4,angle_max_4] = Angle_point_side_elevation(data_2d,B(3),B(2),B(4));
    
    vertex_2d = get_vertex(B);
    
    vertex_3d= scsMapping_point_2d_3d(vertex_2d);
    
    angle_Vertex=abs(acos(vertex_3d'*data(:,~ind_in)));

    
    angle_min(~ind_in)=min([angle_min_1;angle_min_2;angle_min_3;angle_min_4;angle_Vertex]);
    angle_max(~ind_in)=max([angle_max_1;angle_max_2;angle_max_3;angle_max_4;angle_Vertex]);


    
    angle_min(ind_in)=0;
    angle_max(ind_in)=nan;
    
end

