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


function [lbl,cs] = dgsac_pointModelAssignment(pref,density)


density=density.*pref;
out=sum(pref,2);
[~,idx]=max(density,[],2);
idx(out==0)=0;
uidx=unique(idx);
tn_st=unique(idx);
cs=zeros(length(tn_st),1);
for it=1:length(tn_st)
   cs(it)=nnz(find(idx==uidx(it))); 
end


lbl=idx;


end