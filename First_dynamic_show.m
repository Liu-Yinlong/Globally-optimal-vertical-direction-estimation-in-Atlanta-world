clc;clear;close all;
addpath('./syn-data-create/')
addpath('./Globally-Searching-ExpMapping/')
addpath('./show_volume/')

Normal_NUM_inlier_vertical=100;
Normal_NUM_inlier_horizontal=500;
noise_level=0.01;
Normal_NUM_outlier=200;
[out_data,vertical_direction] = gen_syn_data(Normal_NUM_inlier_vertical,Normal_NUM_inlier_horizontal,Normal_NUM_outlier,noise_level);
epsilon=0.0175;
data=out_data;

tic
[exp_direction,iter_exp] = ExpMap_direction_info(data,epsilon);
tim_exp=toc;

error_exp=acosd(abs(exp_direction'*vertical_direction));

disp(['error(deg):' num2str(error_exp)])
disp(['runtime:' num2str(tim_exp)])