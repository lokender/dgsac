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

function plotHypotheses(data_params,dgs_params)

if strcmp(data_params.model_type,'line')
data=data_params.data;
gt_data=data_params.gt_data;
nHyps=size(dgs_params.hypsG,2);
hypsG=dgs_params.hypsG;
figure(randi(100))
hold on;plot(data(1,:)',data(2,:)','b.');
range=[-1 1;-1 1];
for i=1:nHyps
    pts=[data(:,hypsG(1,i)) data(:,hypsG(2,i))];
    plotExtendedLine(pts,[1 1 0],range);
end

for i=1:nHyps
    if dgs_params.gt_frac(i) ~=0
        pts=[data(:,hypsG(1,i)) data(:,hypsG(2,i))];
        plotExtendedLine(pts,[0.75 0.75 0.75],range);
    end
end
title('Yellow- All generated Hyps, Grey- Good Hyps')
        
end



end