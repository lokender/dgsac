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

function [point_corr_d]=dgsac_ComputerDensityBasedPC(point_corr_d,point_pref_d,win_den,pp_den)

pp_den=find(pp_den==1);

nPts = size(point_pref_d,2);
nhyps = size(point_pref_d,1);
   

if floor((nPts*nPts)/2)  <= length(pp_den)*nPts
   
    point_corr_d=zeros(nPts,nPts) + eye(nPts);
    for p_out=1:nPts
        d_arr1 =zeros(1,nhyps);
        d_arr1(1,point_pref_d(1:win_den,p_out))=1; 
    
    for p_in=p_out+1:nPts
        d_arr2 =zeros(1,nhyps);
        d_arr2(1,point_pref_d(1:win_den,p_in))=1;
        point_corr_d(p_out,p_in) = nnz(all([d_arr1;d_arr2],1))/win_den;
    end
    end
    point_corr_d = point_corr_d + point_corr_d' - eye(nPts);
else
    
for p_out=1:length(pp_den)
        d_arr1 =zeros(1,nhyps);
        d_arr1(1,point_pref_d(1:win_den,pp_den(p_out)))=1; 
    
    for p_in=1:nPts
        d_arr2 =zeros(1,nhyps);
        d_arr2(1,point_pref_d(1:win_den,p_in))=1;
        point_corr_d(pp_den(p_out),p_in) = nnz(all([d_arr1;d_arr2],1))/win_den;
    end
    point_corr_d(:,pp_den(p_out))=point_corr_d(pp_den(p_out),:)';
 end
    
end

return;

end

