function [dist] = dgsac_line_res(X,P)
        
[~, npts] = size(X);
dist = zeros(npts,size(P,2));
for nP=1:size(P,2)
for i = 1:npts
    dist(i,:) = sqrt((P(1:2,nP)'*X(:,i)+P(3,nP)).^2  / (P(1,nP)^2+P(2,nP)^2));
end
end
end