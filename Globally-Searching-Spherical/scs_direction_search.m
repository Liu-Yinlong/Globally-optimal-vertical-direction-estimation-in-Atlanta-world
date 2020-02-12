function [scs_direction,iter] = scs_direction_search(data,epsilon)
%DIRECTION_SEARCH Summary of this function goes here
%   data:input surface normals
%   epsilon:inlier threshold(e.g., 0.0175)

 B=[-pi;-pi/2;pi;0];


branches=[];

new_upper=zeros(1,4);
new_lower=zeros(1,4);
best_branch=B;

iter=0;
E_lower=0;
H_direction_2d=zeros(2,1);
%  f=figure;
% hold on
% h1 = animatedline;
% h2 = animatedline;

while(best_branch(4)-best_branch(2)>1e-3)
     
    center_point_x=0.5*(best_branch(1)+best_branch(3));
    center_point_y=0.5*(best_branch(2)+best_branch(4));
    
    new_branch(:,1)=[best_branch(1);best_branch(2);center_point_x;center_point_y];
    new_branch(:,2)=[best_branch(1);center_point_y;center_point_x;best_branch(4)];
    new_branch(:,3)=[center_point_x;best_branch(2);best_branch(3);center_point_y];
    new_branch(:,4)=[center_point_x;center_point_y;best_branch(3);best_branch(4)];

    for i=1:4
        [new_lower(i),new_upper(i)] = scsMapping_bounds(new_branch(1:4,i),data,epsilon);
    end

    branches=[branches,[new_branch;new_lower;new_upper]];
   

    [E_lower_new,ind_min]=max(branches(5,:));%max value of the lower bound
    
    if(E_lower<E_lower_new)
        H_direction_2d=0.5*(branches(1:2,ind_min)+branches(3:4,ind_min));
        E_lower=E_lower_new;
    end
    
%      show_process(f,branches,[-pi,pi,-pi/2,0]);
    
    branches(:,branches(6,:)<E_lower)=[];% pruning
        
    [E_upper,ind_max]=max(branches(6,:));
      

    best_branch=branches(1:4,ind_max);
    
    branches(:,ind_max)=[];
    

    
    %==========
    iter=iter+1;
    if(E_upper<=E_lower) 
       
        break;
    end
%     addpoints(h1,iter,E_upper);
%     addpoints(h2,iter,E_lower);
%     drawnow
    
end

scs_direction = scsMapping_point_2d_3d(H_direction_2d);
end

