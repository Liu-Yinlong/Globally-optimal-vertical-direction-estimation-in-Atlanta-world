function [RS_direction,iter,L,U] = RotationSearch_vertical_info(data,epsilon)

Vec=[0;0;1];

R_best=zeros(3,1);
B=[-pi;-pi;-pi;pi;pi;pi];

best_branch=B;

branch=[];
new_upper=zeros(1,8);
new_lower=zeros(1,8);

best_lower=0;
iter=1;
% figure
% h1=animatedline;
% h2=animatedline;


while true
    
    new_branch=Branch(best_branch);
    
    for i=1:8
          [new_upper(i),new_lower(i)]=get_bound_Atlanta(Vec,data,new_branch(:,i),epsilon);
    end
    
    branch=[branch,[new_branch;new_upper;new_lower]];
    
    [best_upper,ind_upper]=max(branch(7,:));
    

    [new_best_lower,ind_lower]=max(branch(8,:));
    
    if(best_lower<new_best_lower)
        best_lower=new_best_lower;
        R_branch=branch(1:6,ind_lower);
        R_best=0.5*(R_branch(1:3)+R_branch(4:6));
    end
    
    best_branch=branch(1:6,ind_upper);
    
    branch(:,ind_upper)=[];
    branch(:,branch(7,:)<best_lower)=[];
    
    L(iter)=best_lower;
    U(iter)=best_upper;
%     addpoints(h1,iter,best_upper);
%     addpoints(h2,iter,best_lower);
% 
%     drawnow
    iter=iter+1;

    if(best_upper-best_lower<=1)
        break;  
    end

end

RS_direction=rotationVectorToMatrix(R_best)*[0;0;1];

end

