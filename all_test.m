clc;clear;close all;
addpath('./syn-data-create/')
addpath('./Globally-Searching-ExpMapping/')
addpath('./Globally-Searching-Stereo-Square/')
addpath('./Globally-Searching-Stereo-Circle/')
addpath('./Globally-Searching-Spherical/')
addpath('./Globally-Searching-Rotation-Search/') 
%addpath('./show_volume/')
addpath('./aboxplot/')
addpath('./RANSAC/')
outlier_rate=0.1:0.1:0.5;
re_num=100;
N=length(outlier_rate);
sum_num=500;
noise_level=0.01;
iter_num=1;
for ii=1:N
    for jj=1:re_num
        [error(iter_num,:),time(iter_num,:),iter(iter_num,:)]=once(sum_num, outlier_rate(ii),noise_level);
        disp([ii,jj])
        iter_num=iter_num+1;
    end
end

figure
aboxplot(data_reshape(error,re_num),'Colormap',parula(6),'OutlierMarker','*','OutlierMarkerSize',10);
legend('exp','ste-circle','ste-square','scs-square','rs','ransac')
figure
aboxplot(data_reshape(time,re_num),'Colormap',parula(6));
legend('exp','ste-circle','ste-square','scs-square','rs','ransac')
figure
aboxplot(data_reshape(iter,re_num),'Colormap',parula(6));
legend('exp','ste-circle','ste-square','scs-square','rs','ransac')

function [error,time,iter]=once(sum_num, outlier_rate,noise_level)

Normal_NUM_outlier=round(sum_num*outlier_rate);
Normal_NUM_inlier=sum_num-Normal_NUM_outlier;
Normal_NUM_inlier_vertical=round(Normal_NUM_inlier/3);
Normal_NUM_inlier_horizontal=Normal_NUM_inlier-Normal_NUM_inlier_vertical;

[out_data,vertical_direction] = gen_syn_data(Normal_NUM_inlier_vertical,Normal_NUM_inlier_horizontal,Normal_NUM_outlier,noise_level);
epsilon=0.0175;
data=out_data;

tic
[exp_direction,iter_exp] = ExpMap_direction_search(data,epsilon);
tim_exp=toc;

error_exp=acosd(abs(exp_direction'*vertical_direction));

tic
[StereoMap_direction_circle,iter_ste] = StereoMap_direction_search_circle(data,epsilon);
tim_ste=toc;
error_ste=acosd(abs(StereoMap_direction_circle'*vertical_direction));

tic
[StereoMap_direction_square,iter_square] = StereoMap_direction_search_square(data,epsilon);
tim_square=toc;
error_square=acosd(abs(StereoMap_direction_square'*vertical_direction));


tic
[scs_direction,iter_scs] = scs_direction_search(data,epsilon);
tim_scs=toc;
error_scs=acosd(abs(scs_direction'*vertical_direction));

tic
[RS_direction,iter_rs] = RotationSearch_vertical_direction(data,epsilon);
tim_rs=toc;
error_rs=acosd(abs(RS_direction'*vertical_direction));

tic
outlier_ratio=Normal_NUM_outlier./(Normal_NUM_inlier_vertical+Normal_NUM_inlier_horizontal+Normal_NUM_outlier);
[ransac_direction,iter_ransac] = Two_samples_RANSAC(data,outlier_ratio,epsilon,1);
tim_ransac=toc;

error_ransac=acosd(abs(ransac_direction'*vertical_direction));

error=[error_exp, error_ste,error_square,error_scs,error_rs,error_ransac];
iter=[iter_exp, iter_ste,iter_square,iter_scs,iter_rs,iter_ransac];
time=[tim_exp, tim_ste,tim_square,tim_scs,tim_rs,tim_ransac];

% disp([error_exp, error_ste,error_square,error_scs,error_rs,error_ransac])
% disp([iter_exp, iter_ste,iter_square,iter_scs,iter_rs])
% disp([tim_exp, tim_ste,tim_square,tim_scs,tim_rs,tim_ransac])
end



