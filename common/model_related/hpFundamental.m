function [ H ] = hpFundamental(X,S,wts)

m=size(S,1);
 H=zeros(9,3*m); 
        cont=1;
        for i=1:m
            x=X(1:3,S(i,:));
            y=X(4:6,S(i,:));
            if(any(x(3,:)==0)|| any(y(3,:)==0))
                F=rand(9,1);
            else
                if isempty(wts)
                   cwts=ones(1,size(x,2));
                   cwts=cwts./norm(cwts);
                else
                    cwts=wts;
                end
                F=fund(x,y,cwts);
            end
            numSol=size(F,2);
            for j=1:numSol
                H(:,cont)=F(:,j);
                cont=cont+1;
            end
            
        end
        
        H=H(:,1:cont-1); 
end

