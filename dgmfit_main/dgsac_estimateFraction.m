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

function [fractions,slope_all,std_all] = dgsac_estimateFraction(fil_sres,fil_den_sRes,nElem,model_type)


nh = size(fil_sres,1);
nPts = size(fil_sres,2);
slope_all= zeros(nh,1);
std_all= zeros(nh,1);

sres_ptsstd = zeros(nh,nPts);
den_ratio = zeros(nh,nPts);
fractions=zeros(nh,2);


if strcmp(model_type,'vanishing_point')
nE = nElem;
else
nE = max([round(0.05*nPts),2*nElem]);
end
    
fil_sres_padd = [fil_sres(:,2:nE+1) fil_sres fil_sres(:,end-nE:end-1)];
nPts_pad=size(fil_sres_padd,2);
for oit=1:nh
     for iit=nE+1:nPts_pad-nE
        ord_residx = iit-nE:iit+nE;
        sres_ptsstd(oit,iit-nE) = std(fil_sres_padd(oit,ord_residx));   
     end
     
if strcmp(model_type,'vanishing_point')
    nE2 = nElem+1; 
else
    nE2 = 2*nElem+1; 
end


cut_th=(fil_sres(oit,nE2))+10e-5;      
cutind=find(fil_sres(oit,:)<=40*cut_th); 
cutind=cutind(end);

dnorm = (fil_den_sRes(oit,:))./sum((fil_den_sRes(oit,:)));


[~,maxdnorm_ind]=find(dnorm==dnorm(1),1,'last');

maxdnorm_ind=max([maxdnorm_ind,nE2]); 
if maxdnorm_ind~=nPts 
maxdnorm = dnorm(maxdnorm_ind);
slope= abs(dnorm-maxdnorm);
slope= slope(1,maxdnorm_ind:end)./sum(slope(1,maxdnorm_ind:end));
stdnorm = sres_ptsstd(oit,maxdnorm_ind:end)./sum(sres_ptsstd(oit,maxdnorm_ind:end));

slope_nan=isnan(slope);
if nnz(isnan(slope))==length(slope)
    fractions(oit,1)= 1;
    fractions(oit,2)= std(fil_sres(oit,1:nPts));
    return;
end
slope_nan= find(slope_nan==1);

for it=1:length(slope_nan)
  nind= find(slope(1,slope_nan(it):end)>=0);
  slope(1,slope_nan(it))=slope(1,slope_nan(it)+nind(1)-1);
end

if any(isnan(slope))
    disp('nan');
end

cutind_rel= (cutind-maxdnorm_ind)+1;
if cutind_rel>0
slope_std_score = (slope.*stdnorm);
[~,max_score_id]=max(slope_std_score(1:cutind_rel));
else
    slope_std_score = (slope.*stdnorm);
[~,max_score_id]=max(slope_std_score);
end


frac_id = max_score_id+maxdnorm_ind-1;
slope_all(oit,1)=slope(1,max_score_id);
std_all(oit,1)=stdnorm(1,max_score_id);


fractions(oit,1)= frac_id./nPts;
fractions(oit,2)= std(fil_sres(oit,1:frac_id));



else
    if maxdnorm_ind<cutind
        fractions(oit,1)= cutind./nPts;
        fractions(oit,2)= std(fil_sres(oit,1:cutind));
    else
    fractions(oit,1)= 1;
    fractions(oit,2)= std(fil_sres(oit,1:nPts));
end
end
end

end


