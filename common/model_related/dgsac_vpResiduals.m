function  R  = dgsac_vpResiduals( H, endpoints, centroidd, distFun )

points = size(endpoints,1)/2;
m = size(H,1);
R=zeros(points,m);
for j=1:m 
        R(:,j) = distFun(H(j,:),endpoints,centroidd);
end


