function [data,Manhattan_axis] = gen_syn_data_Manhattan(inlier,outlier,noise)
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

data_1=repmat(Manhattan_axis(:,1),1,num_1);
data_2=repmat(Manhattan_axis(:,2),1,num_2);
data_3=repmat(Manhattan_axis(:,3),1,num_3);

start_data=[data_1,data_2,data_3];

data_non_unit=[start_data,(rand(3,outlier)-0.5)*2]+(rand(3,outlier+inlier)-0.5)*noise;
data=data_non_unit./vecnorm(data_non_unit);

n=size(data,2);
for i=1:n
    if(data(3,i)>0)
        data(:,i)=-data(:,i);
    end
end

end

