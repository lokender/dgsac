%##########################################################################
%% DGSAC: Density Guided SAmpling and Consensus
%% This package contains the source code which implements DGSAC (A Robust Multi-Model Fitting Pipeline) proposed in
% L. Tiwari, and S. Anand 
% DGSAC: Density Guided SAmpling and Consensus, 
% In Proceedings of the Winter Conference on Applications of Computer Vision (WACV),
% March 2018, Lake Tahoe, Nevada, USA
% 
% Copyright (c) 2018 L. Tiwari (lokendert@iiitd.ac.in)
% Infosys Center for Artificial Intelligence,
% Dept. of Computer Science and Engineering, IIIT-Delhi, India
% https://lokender.bitbucket.io/
%% Please acknowledge the authors by citing the above paper in any academic 
%  publications that have made use of this package or part of it.
%##########################################################################

%% Please report any bug to lokendert@iiitd.ac.in %%

function plotExtendedLine(Y,color,range)
    x = Y(1,:);
    y = Y(2,:);
    Points=[0;0];
    
    slope=(y(2)-y(1))/(x(2)-x(1));
        
    yg=range(2,2);
    xc1 = x(2) - ((y(2) - (yg)) * (x(2)-x(1)))/(y(2)-y(1));
    yg=range(2,1); 
    xc2 = x(2) - ((y(2) - (yg)) * (x(2)-x(1)))/(y(2)-y(1));
   
        
    
    xg=range(1,2);
    yc1 = y(2) - (((x(2) - (xg)) * (y(2)-y(1)))/(x(2)-x(1)));
    xg=range(1,1); 
    yc2 = y(2) - ((x(2) - (xg)) * (y(2)-y(1)))/(x(2)-x(1));
   
    if (xc1 <= range(1,2))  &&  (xc1 >= range(1,1))
        p = [xc1;range(2,2)];
        Points=[Points p];
    end
    if (xc1 < range(1,1))  %&&  (xc1 > range(1,1))
        p = [range(1,1);yc2];
        Points=[Points p];
    end
    if (xc1 > range(1,2))  %&&  (xc1 >= range(1,1))
        p = [range(2,2);yc1];
        Points=[Points p];
    end
    
   if (xc2 <= range(1,2))  &&  (xc2 >= range(1,1))
        p = [xc2;range(2,1)];
        Points=[Points p];
    end
    if (xc2 < range(1,1))  %&&  (xc1 > range(1,1))
        p = [range(1,1);yc2];
        Points=[Points p];
    end
    if (xc2 > range(1,2))  %&&  (xc1 >= range(1,1))
        p = [range(2,2);yc1];
        Points=[Points p];
    end

    
    Points=Points(:,2:end);
    
    hold on; plot(Points(1,:),Points(2,:),'color',color,'LineWidth',4);
    
    
    
    
end
