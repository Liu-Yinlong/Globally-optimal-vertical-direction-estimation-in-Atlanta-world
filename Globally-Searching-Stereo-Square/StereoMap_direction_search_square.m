function [StereoMap_direction,iter] = StereoMap_direction_search_square(data,epsilon)
%OUR_DIRECTION_SEARCH Summary of this function goes here
B=[0;0;1];
branches=[];

new_upper=zeros(1,4);
new_lower=zeros(1,4);
best_branch=B;

iter=0;
E_lower=0;
Our_direction_2d=zeros(2,1);



while(best_branch(3)>1e-3)

    new_half_side=0.5*best_branch(3);
    
    s_1=[best_branch(1)+new_half_side;best_branch(2)+new_half_side];
    s_2=[best_branch(1)-new_half_side;best_branch(2)+new_half_side];
    s_3=[best_branch(1)+new_half_side;best_branch(2)-new_half_side];
    s_4=[best_branch(1)-new_half_side;best_branch(2)-new_half_side];
    
    c_solid=[s_1,s_2,s_3,s_4];
    

    for i=1:4
        [new_lower(i),new_upper(i)] = Square_bounds(c_solid(:,i),new_half_side,data,epsilon);
    end
    
    branches=[branches,[c_solid;ones(1,4)*new_half_side;new_lower;new_upper]];
    
    [E_lower_new,ind_min]=max(branches(4,:));
    
    if(E_lower<E_lower_new)
        Our_direction_2d=branches(1:2,ind_min);
        E_lower=E_lower_new;
    end
        

    
    branches(:,branches(5,:)<E_lower)=[];
        
    [E_upper,ind_max]=max(branches(5,:));
    
    
    
    best_branch=branches(1:3,ind_max);
    
    branches(:,ind_max)=[];
    

    iter=iter+1;

   
    
    if(E_upper<=E_lower) 

        break;
    end
    
end
StereoMap_direction = StereoMap_point_2d_3d(Our_direction_2d);

end

