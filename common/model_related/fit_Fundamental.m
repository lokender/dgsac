function [ M ] = fit_Fundamental( X, C )



if  ~exist('C','var') || isempty(C)

    x = X(1:3,:);
    y = X(4:6,:);
    
    
    f_start = fund(x,y);
    f_start=reshape(f_start,3,3);
    f_nonlin = F_from_x_nonlin(f_start,x,y);
    M = f_nonlin(:);
    
else
    
   label = sort(unique(C));
    N = length(label); 
    M = nan(9,N);      
    
    for i=1:N
        
        L  = label(i);
        points2fit = X(:,C==L);
        x = points2fit(1:3,:);
        y = points2fit(4:6,:);
         
        f_start = fund(x,y);
        f_start = reshape(f_start ,3,3); 
        
        % non linear refinement
        f_nonlin = F_from_x_nonlin(f_start,x,y);       
        M(:,i) = f_nonlin(:);
     
        
    end
end


