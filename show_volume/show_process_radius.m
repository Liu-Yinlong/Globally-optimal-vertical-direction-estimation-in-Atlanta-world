function show_process_radius(f,branches,ax_bound)
%SHOW_PROCESS Summary of this function goes here
%   Detailed explanation goes here
figure(f);
clf(f);
title('dynamic changing of branches')
axis(ax_bound);
hold on
NUM=size(branches,2);
for i=1:NUM
    B=[branches(1:2,i)-branches(3,i);branches(1:2,i)+branches(3,i)];
    p=get_vertex(B);
    fill(p(1,:),p(2,:),'r')
    hold on
end


end

