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

function plotLineHypotheses(data,hypsG,gt_frac,msel,elbl)

nHyps=size(hypsG,2);
figure(randi(100))
hold on;plot(data(1,:)',data(2,:)','k.','MarkerSize',15);
range=[-1 1;-1 1];

if isempty(msel)

    for i=1:nHyps
        pts=[data(:,hypsG(1,i)) data(:,hypsG(2,i))];
        plotExtendedLine(pts,[1 1 0],range);
    end

    for i=1:nHyps
        if gt_frac(i) ~=0
            pts=[data(:,hypsG(1,i)) data(:,hypsG(2,i))];
            plotExtendedLine(pts,[0.75 0.75 0.75],range);
        end
    end
    title('Yellow- All generated Hyps, Grey- Good Hyps')
else
for i=1:nHyps
        pts=[data(:,hypsG(1,i)) data(:,hypsG(2,i))];
%         color=[rand(1) rand(1) rand(1)];
%         plotExtendedLine(pts,color,range);
%         if ~isempty(elbl)
%             hold on; plot(data(1,elbl==i)',data(2,elbl==i)','.', 'color',color,'MarkerSize',15);
%         end
        color_list=[1 0 0;0 1 0;0 0 1;1 1 0; 1 0 1; 0 1 1;0.5 0.5 1;0.3 0.1 0.6 ];
        plotExtendedLine(pts,color_list(i,:),range);
        if ~isempty(elbl)
           hold on; plot(data(1,elbl==i)',data(2,elbl==i)','.', 'color',color_list(i,:),'MarkerSize',15);
        end
end
    
    
end
end



%end