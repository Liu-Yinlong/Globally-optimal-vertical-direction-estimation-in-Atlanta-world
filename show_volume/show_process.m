function show_process(f,branches,ax_bound)
%SHOW_PROCESS Summary of this function goes here
%   Detailed explanation goes here
figure(f);
clf(f);
axis(ax_bound);
hold on
NUM=size(branches,2);
for i=1:NUM
    p=get_vertex(branches(1:4,i));
    fill(p(1,:),p(2,:),'r')
    hold on
end


end

