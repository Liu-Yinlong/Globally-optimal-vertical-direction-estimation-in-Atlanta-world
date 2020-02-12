function [H_direction,iter,L,U,branches] = ExpMap_direction_info(data,epsilon)
%H_DIRECTION_SEARCH Summary of this function goes here
%   Detailed explanation goes here
B=[0;0;pi/2];
branches=[];

new_upper=zeros(1,4);
new_lower=zeros(1,4);
best_branch=B;


figure;
title('Evolution of the bounds of exp-map')
hold on
grid
h_l=animatedline('color','r');
h_u=animatedline('color','b');
legend('upper bound','lower bound')
figure
title('Evolution of the bounds of exp-map')
h_v=animatedline('color','k');
legend('volume remaning')
grid
figure
title('Evolution of the bounds of exp-map')
h_v_num=animatedline('color','k');
legend('number of branches')
grid
f_b=figure;



iter=0;
E_lower=0;
H_direction_2d=zeros(2,1);

while(1)

    new_half_side=0.5*best_branch(3);
    
    s_1=[best_branch(1)+new_half_side;best_branch(2)+new_half_side];
    s_2=[best_branch(1)-new_half_side;best_branch(2)+new_half_side];
    s_3=[best_branch(1)+new_half_side;best_branch(2)-new_half_side];
    s_4=[best_branch(1)-new_half_side;best_branch(2)-new_half_side];
    
    c_solid=[s_1,s_2,s_3,s_4];
    

    for i=1:4
        [new_lower(i),new_upper(i)] = ExpMapping_bounds(c_solid(:,i),new_half_side,data,epsilon);
    end
    
    branches=[branches,[c_solid;ones(1,4)*new_half_side;new_lower;new_upper]];
    
    [volume,v_num]=get_volume_2d_radius(branches);
    show_process_radius(f_b,branches,[-pi/2,pi/2,-pi/2,pi/2]);
    
    
    [E_lower_new,ind_min]=max(branches(4,:));
    
    if(E_lower<E_lower_new)
        H_direction_2d=branches(1:2,ind_min);
        E_lower=E_lower_new;
    end
    
    
    branches(:,branches(5,:)<E_lower)=[];
        
    [E_upper,ind_max]=max(branches(5,:));
    
    best_branch=branches(1:3,ind_max);
    
    branches(:,ind_max)=[];
    
    %==========
    iter=iter+1;
    
    L(iter)=E_lower;
    U(iter)=E_upper;
    
    addpoints(h_l,iter,E_upper);
    addpoints(h_u,iter,E_lower);
    addpoints(h_v,iter,volume);
    addpoints(h_v_num,iter,v_num);
    drawnow
    %==========
    
    if(E_upper==E_lower) 
                
        H_direction = ExpMapping_point_2d_3d(H_direction_2d);
        
        break;
    end
end


end

