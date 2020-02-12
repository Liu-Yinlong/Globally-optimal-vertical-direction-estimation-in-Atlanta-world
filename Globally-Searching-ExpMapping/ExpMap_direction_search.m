function [Exp_direction,iter] = ExpMap_direction_search(data,epsilon)
%DIRECTION_SEARCH Summary of this function goes here
%   data:input surface normals
%   epsilon:inlier threshold(e.g., 0.0175)
B=[0;0;pi/2];%[init-x,init-y,radius]
branches=[];

new_upper=zeros(1,4);
new_lower=zeros(1,4);
best_branch=B;

iter=0;
E_lower=0;
H_direction_2d=zeros(2,1);

while(best_branch(3)>1e-3)
     
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
    
    [E_lower_new,ind_min]=max(branches(4,:));%max value of the lower bound
    
    if(E_lower<E_lower_new)
        H_direction_2d=branches(1:2,ind_min);
        E_lower=E_lower_new;
    end
    
    
    branches(:,branches(5,:)<E_lower)=[];% pruning
        
    [E_upper,ind_max]=max(branches(5,:));
    
    best_branch=branches(1:3,ind_max);
    
    branches(:,ind_max)=[];
    
    %==========
    iter=iter+1;
    if(E_upper==E_lower) 
       
        break;
    end
end

Exp_direction = ExpMapping_point_2d_3d(H_direction_2d);

end

