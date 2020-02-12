function inlier_num = calculate_inlier_num(direction,data,MaxThreshold)
%CALCULATE_DIRECTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
dot_vec=abs(direction'*data);

angle=abs(acos(dot_vec));

inlier_num=sum((angle<=MaxThreshold)|(angle>=pi/2-MaxThreshold));
end

