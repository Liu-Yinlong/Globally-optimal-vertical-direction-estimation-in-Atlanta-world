function [Vertex] = get_vertex(B)
%OUR_GET_SIDE Summary of this function goes here
%   Detailed explanation goes here

x_l=B(1);
y_l=B(2);

x_u=B(3);
y_u=B(4);

point_1=[x_l;y_l];
point_2=[x_u;y_l];
point_3=[x_u;y_u];
point_4=[x_l;y_u];

Vertex=[point_1,point_2,point_3,point_4];



end

