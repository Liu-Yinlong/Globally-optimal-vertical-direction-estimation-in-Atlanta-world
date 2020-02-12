function [opt_direction,MaxNumTrials] = Two_samples_RANSAC(data,outlier_ratio,MaxThreshold,omega)
%TWO_SAMPLE_RANSAC 此处显示有关此函数的摘要
%   此处显示详细说明
opt_inlier_Num=0;
opt_direction=zeros(3,1);
NUM=size(data,2);
p=0.99;
MaxNumTrials=omega*ceil(log(1-p)./(log(1-(1-outlier_ratio)^2)));

index_sample=randi(NUM,2,MaxNumTrials);

for i=1:MaxNumTrials
    
    A=data(:,index_sample(1,i));
    B=data(:,index_sample(2,i));    
    C_non_unit=cross(A,B);
    C=C_non_unit./norm(C_non_unit);
    
    A_inlier_num = calculate_inlier_num(A,data,MaxThreshold);
    B_inlier_num = calculate_inlier_num(B,data,MaxThreshold);
    C_inlier_num = calculate_inlier_num(C,data,MaxThreshold);
    

    sumMatrix=[A_inlier_num, B_inlier_num,C_inlier_num];
      
    [max_inlier,ind]=max(sumMatrix);
    if(opt_inlier_Num>=max_inlier)
        continue;
    end
    opt_inlier_Num=max_inlier;
    sumDirections=[A,B,C];
    opt_direction=sumDirections(:,ind);
    
end


end

