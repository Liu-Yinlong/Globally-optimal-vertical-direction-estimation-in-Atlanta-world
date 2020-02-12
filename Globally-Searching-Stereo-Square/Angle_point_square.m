function [angle_min,angle_max] = Angle_point_square(data,B)
%POINT_SQUAR Summary of this function goes here
%   Detailed explanation goes here
    NUM=size(data,2);
    angle_min=zeros(1,NUM);
    angle_max=zeros(1,NUM);
    
    [x,y] = StereoMap_point_3d_2d_xy(data);
    
    ind_x= (x>=B(1)) & (x<=B(3));
    ind_y= (y>=B(2)) & (y<=B(4));
    
    [x_,y_] = StereoMap_point_3d_2d_xy(-data);
    
    ind_x_= (x_>=B(1)) & (x_<=B(3));
    ind_y_= (y_>=B(2)) & (y_<=B(4));
    
    ind_in=(ind_x&ind_y);
    ind_in_=(ind_x_&ind_y_);
    ind=ind_in|ind_in_;
    data=data(:,~ind);
    
    [angle_min_1,angle_max_1] = Angle_point_side_x_in(data,B(1),B(2),B(4));
    [angle_min_2,angle_max_2] = Angle_point_side_x_in(data,B(3),B(2),B(4));
    
    [angle_min_3,angle_max_3] = Angle_point_side_y_in(data,B(2),B(1),B(3));
    [angle_min_4,angle_max_4] = Angle_point_side_y_in(data,B(4),B(1),B(3));
    
    vertex_2d = get_vertex(B);
    
    vertex_3d= StereoMap_point_2d_3d(vertex_2d);
    
    angle_Vertex=abs(acos(vertex_3d'*data));

    
    angle_min(~ind)=min([angle_min_1;angle_min_2;angle_min_3;angle_min_4;angle_Vertex]);
    angle_max(~ind)=max([angle_max_1;angle_max_2;angle_max_3;angle_max_4;angle_Vertex]);
    
    angle_min(ind_in)=0;
    angle_max(ind_in)=nan;
    
    angle_min(ind_in_)=nan;
    angle_max(ind_in_)=pi;
end

