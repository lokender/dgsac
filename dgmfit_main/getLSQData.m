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

% LSQ hyps 
function [res_mat,sort_res_mat,sort_res_in,density_pts,density_sres,incl_list,outden_sres,outden_pts,out_sres,out_fil_sres_ind,model_par]=getLSQData(data_params,sort_ind,fracs,den_pts)


[distFun, hpFun, ~, ~, ~, npar] = set_model( data_params.model_type );  
 outden_sres=[];
 outden_pts=[];
 out_sres=[];
 out_fil_sres_ind =[];
 nh=size(sort_ind,1);
 model_par=zeros(npar,nh);
 nPts=size(sort_ind,2);
 res_mat=zeros(nh,nPts);
 density_pts=zeros(nh,nPts);
 density_sres=zeros(nh,nPts);
 frac_pts=round(fracs(:,1).*nPts);
 incl_list=[];
 for it=1:nh
 mss=sort_ind(it,1:frac_pts(it))';
 
 if length(mss)>=data_params.nElem
 pick_mss_siz=max([round(frac_pts(it)/2),2*data_params.nElem]);
 if pick_mss_siz>length(mss)
     pick_mss_siz=length(mss);
 end
 mss=mss(1:pick_mss_siz);    
 incl_list=[incl_list it];
 wts=den_pts(it,mss);
 wts=wts./norm(wts);

 M = hpFun(data_params.data,mss',wts); %hypothesis
 
 if strcmp(data_params.model_type,'vanishingpoint')
    residualss = dgsac_vpResiduals(M,data_params.endpoints,data_params.centroidd, distFun ); 
    residualss=residualss';  
    model_par(:,it)=M';
 else
     model_par(:,it)=M;
    residualss = res( data_params.data, M, distFun )';
 end
    
 
 [~,~,it_Gdensity_sRes,it_Gdensity_pts,~,~,~] = dgsac_ResidualDensity(residualss);
 res_mat(it,:)=residualss;
 density_pts(it,:)=it_Gdensity_pts;
 density_sres(it,:)= it_Gdensity_sRes;
 end
 [sort_res_mat,sort_res_in]=sort(res_mat,2);
 end
 res_mat=res_mat(incl_list,:);
 sort_res_mat=sort_res_mat(incl_list,:);
 sort_res_in=sort_res_in(incl_list,:);
 density_pts=density_pts(incl_list,:);
 density_sres=density_sres(incl_list,:);
 model_par = model_par(:,incl_list);
 
end