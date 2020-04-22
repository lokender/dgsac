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

function [vol_all,sorted_ind_pts,density_norm,density_pts,Gres_mat_norm,comb_prob,max_ind_inds] = dgsac_ResidualDensity(res_matG)


Gres_mat_norm=[];
comb_prob=[];
nDim_res = 1; 
nFracs=40;
nPts = size(res_matG,2);
nHyps = size(res_matG,1);
winSize = ceil(nPts/nFracs);
win = ones(1,winSize)/winSize;


[dist_sorted_array,sorted_ind_pts] = sort(res_matG,2,'ascend');
dist_sorted_array=dist_sorted_array+1e-3;

dist_padded = [dist_sorted_array(:,floor(winSize/2):-1:1),dist_sorted_array,dist_sorted_array(:,end-(floor(winSize/2))+1:end)];
vol_all=zeros(nHyps,(floor(length(win)/2)*2)+nPts);
for hyp_i = 1:nHyps
    vol_all(hyp_i,:) = conv(dist_padded(hyp_i,:),win,'same');
end
vol_all=vol_all(:,floor(winSize/2)+1:floor(winSize/2)+nPts);
assert(size(vol_all,2)==nPts);



density_all = (ones(nHyps,1)*((1:nPts).^(1/nDim_res)))./vol_all;

density_pts = zeros(size(density_all));
[~,inds_orig] = sort(sorted_ind_pts,2);

density_norm=zeros(size(density_all,1),size(density_all,2));
max_ind_inds=[];
for hyp_i = 1:nHyps
    [max_val,max_ind]=max(density_all(hyp_i,:));
    density_all(hyp_i,1:max_ind)=max_val;
    density_norm(hyp_i,:)=density_all(hyp_i,:);
    density_pts(hyp_i,:) = density_norm(hyp_i,inds_orig(hyp_i,:));   
    
end
return;
end