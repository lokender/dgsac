function [ F ] = fund( x,y,wts )
% Compute the fundamental matrix from npts pair of correspondence x,y.
%   INPUT:  
%           x a 3xnpts matrix of homogeneous points
%           y a 3xnpts matrix of homogeneous points
%   OUTPUT: 
%           vectorize fundamental matrix 
%

npts= size(x,2);


[Tx,xN]=precond2(x(1:2,:));
x(:,:)=[xN;ones(1,npts)];
[Ty,yN]=precond2(y(1:2,:));
y(:,:)=[yN;ones(1,npts)];

for i=1:npts
    A(i,:) = (kron(x(:,i)',y(:,i)'))*wts(i);
end

[~,~,v] = svd(A);
FF{1} = reshape(v(:,end-1),[3 3]);
FF{2} = reshape(v(:,end  ),[3 3]);
if(npts>=8)
    [u,s,v] = svd(FF{2});
    s(3,3)=0;
    f=u*s*v';
    f= Ty'*f*Tx;
    F=f(:);
else
    warning('at least 8 points are required')
end


end

