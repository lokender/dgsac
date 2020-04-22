function  R  = res( X, H, distFun )
%RES residual computation 
%  INPUT: 
%           X data points
%           H hypotheses
%           distFun distance function between point and model
%  OUTPUT:
%           R residual matrix

points = size(X,2);
m = size(H,2);
R=zeros(points,m);
%for i=1:points 
%without_t = tic    ;
for j=1:m 
        R(:,j) = distFun(X,H(:,j));
end
%    without_t_end= toc(without_t)
%end

