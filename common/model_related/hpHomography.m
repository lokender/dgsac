function [ H ] = hpHomography( X, S, wts )
%HPFUNDAMENTAL Summary of this function goes here

m=size(S,1);
H=zeros(9,m); % preallocating for speed
for i=1:m

    x = X(1:3,S(i,:));
    y = X(4:6,S(i,:));

        if isempty(wts)
          wts=ones(1,size(x,2));
          wts=wts./norm(wts);
       end
       
       if size(wts,2)>size(wts,1)
           wts=wts';
       end
    %Omega=HomographyDLT(x,y);
    Omega= vgg_H_from_x_lin(x,y,wts);
    %[Omega,~] = vgg_H_from_x_nonlin(Omega,x,y);

    H(:,i)=Omega(:);

    
end



