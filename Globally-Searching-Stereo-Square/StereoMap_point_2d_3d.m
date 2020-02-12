function  point_3d= StereoMap_point_2d_3d(point_2d)

x=point_2d(1,:);
y=point_2d(2,:);

X=2*x./(x.^2+y.^2+1);
Y=2*y./(x.^2+y.^2+1);
Z=(x.^2+y.^2-1)./(x.^2+y.^2+1);
point_3d=[X(:),Y(:),Z(:)]';

end

