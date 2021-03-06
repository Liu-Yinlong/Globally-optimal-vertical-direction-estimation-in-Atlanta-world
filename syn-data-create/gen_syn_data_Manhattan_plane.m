function [data,Manhattan_axis] = gen_syn_data_Manhattan_plane(inlier,outlier,noise)
%GEN_SYN_DATA_MANHATTAN Summary of this function goes here
%   Detailed explanation goes here
start_axis=eye(3);

Vec_any=rand(3,1);

rot_vec=Vec_any./norm(Vec_any);

Rot_mat=rotationVectorToMatrix(rot_vec);

Manhattan_axis=Rot_mat*start_axis;

num_1=round(inlier/3);
num_2=round(inlier/3);
num_3=inlier-num_1-num_2;

[plane_data_1] = gen_syn_data_plane(num_1,[0;0;0],[0;0;1],[1;0;0]);
[plane_data_2] = gen_syn_data_plane(num_2,[0;0;0],[0;1;0],[0;0;1]);
[plane_data_3] = gen_syn_data_plane(num_3,[0;0;0],[1;0;0],[0;1;0]);

start_data=[plane_data_1,plane_data_2,plane_data_3];

data=[Rot_mat*start_data,(rand(3,outlier)-0.5)*2]+(rand(3,outlier+inlier)-0.5)*noise;

end

