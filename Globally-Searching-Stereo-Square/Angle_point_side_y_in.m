function [angle_min,angle_max] = Angle_point_side_y_in(point,side_y,side_x_l,side_x_u)
%OUR_POINT_SIDE Summary of this function goes here
%   Detailed explanation goes here
a=-2*point(1,:);
b=4*point(3,:)-4*point(2,:).*side_y;
c=2*point(1,:).*side_y.^2+2*point(1,:);

delta=b.^2-4.*a.*c;
x_1=(-b+sqrt(delta))./(2*a);
x_2=(-b-sqrt(delta))./(2*a);

ind_zero=abs(a)<1e-6;

x_1(ind_zero)=0;
x_2(ind_zero)=0;


ind_1=(x_1>=side_x_l) & (x_1<=side_x_u);
ind_2=(x_2>=side_x_l) & (x_2<=side_x_u);


opt_3d_1= StereoMap_point_2d_3d_xy(x_1,side_y);
angle_x_1=abs(acos(sum(opt_3d_1.*point)));

angle_x_1(~ind_1)=nan;



opt_3d_2= StereoMap_point_2d_3d_xy(x_2,side_y);
angle_x_2=abs(acos(sum(opt_3d_2.*point)));

angle_x_2(~ind_2)=nan;


angle_min=min([angle_x_1;angle_x_2]);
angle_max=max([angle_x_1;angle_x_2]);

end





