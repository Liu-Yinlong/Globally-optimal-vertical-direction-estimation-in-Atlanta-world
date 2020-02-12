function [out_data,vertical_direction] = gen_syn_data(Normal_NUM_inlier_vertical,Normal_NUM_inlier_horizontal,Normal_NUM_outlier,noise_level)
%GEN_SYN_DATA generate synthetic data
%   out_data:out normal data
%   Normal_NUM_inlier_vertical:number of vertical inlier
%   Normal_NUM_inlier_horizontal:number of horizontal inlier
%   Normal_NUM_outlier:number of inlier
%   noise_level:noise_level*[-1,1](Uniformly distributed) 
vec_any=(rand(3,1)-0.5)*2;
vertical_direction=vec_any./norm(vec_any);
if(vertical_direction(3)>0)
   vertical_direction=-vertical_direction;
end
    
Normal_inlier_vertical=repmat(vertical_direction,1,Normal_NUM_inlier_vertical);

Plan_inlier_horizontal=null(vertical_direction');

xy=(rand(2,Normal_NUM_inlier_horizontal)-0.5)*2;

Normal_inlier_horizontal_non_unit=Plan_inlier_horizontal*xy;
Normal_inlier_horizontal=Normal_inlier_horizontal_non_unit./vecnorm(Normal_inlier_horizontal_non_unit);

Normal_outlier_non_unit=(rand(3,Normal_NUM_outlier)-0.5)*2;
Normal_outlier=Normal_outlier_non_unit./vecnorm(Normal_outlier_non_unit);

out_data_non_unit=[Normal_inlier_vertical,Normal_inlier_horizontal,Normal_outlier]+noise_level*(rand(3,Normal_NUM_inlier_vertical+Normal_NUM_inlier_horizontal+Normal_NUM_outlier)-0.5)*2;
out_data=out_data_non_unit./vecnorm(out_data_non_unit);
N=size(out_data,2);
for i=1:N
    if(out_data(3,i)>0)
       out_data(:,i)=-out_data(:,i);
    end
end

end

