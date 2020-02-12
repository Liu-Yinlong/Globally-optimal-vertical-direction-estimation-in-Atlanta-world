function [angle_min,angle_max] = Angle_point_side_x_in(point,side_x,side_y_l,side_y_u)
%OUR_POINT_SIDE Summary of this function goes here
%   Detailed explanation goes here
a=-2*point(2,:);
b=4*point(3,:)-4*point(1,:).*side_x;
c=2*point(2,:).*side_x.^2+2*point(2,:);


delta=b.^2-4.*a.*c;

y_1=(-b+sqrt(delta))./(2*a);
y_2=(-b-sqrt(delta))./(2*a);

ind_zero=abs(a)<1e-6;
y_1(ind_zero)=0;
y_2(ind_zero)=0;



ind_1=(y_1>=side_y_l) & (y_1<=side_y_u);
ind_2=(y_2>=side_y_l) & (y_2<=side_y_u);

opt_3d_1= StereoMap_point_2d_3d_xy(side_x,y_1);
angle_y_1=abs(acos(sum(opt_3d_1.*point)));

angle_y_1(~ind_1)=nan;


opt_3d_2= StereoMap_point_2d_3d_xy(side_x,y_2);

angle_y_2=abs(acos(sum(opt_3d_2.*point)));

angle_y_2(~ind_2)=nan;


angle_min=min([angle_y_1;angle_y_2]);
angle_max=max([angle_y_1;angle_y_2]);

end





