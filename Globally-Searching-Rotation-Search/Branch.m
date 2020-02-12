function out=Branch(branch)
%对输入的区间进行2^3分支
%   a是下界
%   b是上界

a=branch(1:3);
b=branch(4:end);
c=0.5*(a+b);
M=[a,c,b];
out=zeros(6,8);
for i=1:8
    out(1,i)= M(1,bitget(i,1)+1);
    out(2,i)= M(2,bitget(i,2)+1);
    out(3,i)= M(3,bitget(i,3)+1);
    out(4,i)= M(1,bitget(i,1)+2);
    out(5,i)= M(2,bitget(i,2)+2);
    out(6,i)= M(3,bitget(i,3)+2);
end

end