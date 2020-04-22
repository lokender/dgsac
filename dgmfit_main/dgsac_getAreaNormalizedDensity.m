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

function [norm_den_byarea,norm_den_byarea_pts,area_frac]=dgsac_getAreaNormalizedDensity(density_sres,sorted_res,sort_ind,fracs)

nh=size(density_sres,1);
nPts=size(density_sres,2);
[~,origind]=sort(sort_ind,2);
norm_den_byarea=zeros(nh,nPts);
norm_den_byarea_pts=zeros(nh,nPts);
area_frac=zeros(nh,1);

for oi=1:nh  
   res_diff=diff([sorted_res(oi,1:end)]); 
   areasum=sum(((density_sres(oi,1:end-1)+density_sres(oi,2:end))./2).*res_diff);
   norm_den_byarea(oi,1:end)=density_sres(oi,1:end)./areasum;
   norm_den_byarea_pts(oi,:)=norm_den_byarea(oi,origind(oi,:));

   res_diff_frac=diff([sorted_res(oi,1:fracs(oi))]); 
   areasum_frac=sum(((norm_den_byarea(oi,1:fracs(oi)-1)+norm_den_byarea(oi,2:fracs(oi)))./2).*res_diff_frac);
   area_frac(oi,1)=areasum_frac;

end
end