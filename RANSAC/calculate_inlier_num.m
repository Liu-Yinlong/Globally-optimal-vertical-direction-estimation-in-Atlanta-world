function inlier_num = calculate_inlier_num(direction,data,MaxThreshold)
%CALCULATE_DIRECTION 此处显示有关此函数的摘要
%   此处显示详细说明
dot_vec=abs(direction'*data);

angle=abs(acos(dot_vec));

inlier_num=sum((angle<=MaxThreshold)|(angle>=pi/2-MaxThreshold));
end

