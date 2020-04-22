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

function plotVanishingPoint(im1, endpoints, gt_data, model_par, vpplot)

nLines = size(endpoints,1)/2;
model_par= model_par./model_par(3,:);
%figure(randi(100));
lw = 8;
if ~isempty(im1)
hold on;imshow(im1); 
end
for k=1:nLines
    TL=endpoints((2*k-1):(2*k),:);
    if gt_data(k)==1
    hold on;plot(TL(:,1),TL(:,2),'r-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'r.','MarkerSize',35);
    if vpplot==1
    hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'r-','LineWidth',4);        
    end
    end
    if gt_data(k)==2
    hold on;plot(TL(:,1),TL(:,2),'g-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'g.','MarkerSize',35);
    if vpplot ==1
    hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'g-','LineWidth',4);        
 
    end
    end
    if gt_data(k)==3
    hold on;plot(TL(:,1),TL(:,2),'b-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'b.','MarkerSize',35);
    if vpplot ==1
       hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'b-','LineWidth',4);        
    end
    end
     if gt_data(k)==4
    hold on;plot(TL(:,1),TL(:,2),'m-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'m.','MarkerSize',35);
    if vpplot ==1
   hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'m-','LineWidth',4);        
    end
     end
     if gt_data(k)==5
    hold on;plot(TL(:,1),TL(:,2),'y-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'y.','MarkerSize',35);
    if vpplot ==1
   hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'c-','LineWidth',4);       
    end
     end
     if gt_data(k)==6
    hold on;plot(TL(:,1),TL(:,2),'k-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'k.','MarkerSize',35);
    if vpplot ==1
      hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'k-','LineWidth',4);         
    end
     end
     if gt_data(k)==7
    hold on;plot(TL(:,1),TL(:,2),'c-','LineWidth',lw);
    %hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'c.','MarkerSize',35);
    if vpplot ==1
      hold on;plot([model_par(1,gt_data(k)); TL(2,1) ],[model_par(2,gt_data(k)); TL(2,2) ],'y-','LineWidth',4);       
    end
     end
    
    if gt_data(k)==0
    hold on;plot(TL(:,1),TL(:,2),'c-','LineWidth',lw);
%     if vpplot
%     hold on;plot(model_par(1,gt_data(k)),model_par(2,gt_data(k)),'c-','LineWidth',4);        
%     end
    
    end
    
end


end