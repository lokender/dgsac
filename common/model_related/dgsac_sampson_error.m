function [ d ] = dgsac_sampson_error( x,H )

F=reshape(H,3,3);
m1=x(1:2,:);
m2=x(4:5,:);

d = sqrt(sampson(F, m1, m2));
end

