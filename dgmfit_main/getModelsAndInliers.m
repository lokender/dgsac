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


function result_out=getModelsAndInliers(output,data_params)     



gt_data=data_params.gt_data;
fil_den_pts = output.density_pts;
fil_res=output.Gres_mat;
fil_den_sRes = sort(output.density_pts,2,'descend');
[fil_sres,fil_sres_ind] = sort(output.Gres_mat,2);
nPts = length(gt_data);

    
[fractions,~,~] = dgsac_estimateFraction(fil_sres,fil_den_sRes,data_params.nElem,data_params.model_type);

if data_params.do_lsq==1
[lsq_fil_res,lsq_fil_sres,lsq_fil_sres_ind,~,lsq_fil_den_sRes,~,~,~,~,~,~]=getLSQData(data_params,fil_sres_ind,fractions,fil_den_pts);

[lsq_fractions,~,~] = dgsac_estimateFraction(lsq_fil_sres,lsq_fil_den_sRes,data_params.nElem,data_params.model_type);

else
 lsq_fractions=fractions;
 lsq_fil_res=fil_res;
 lsq_fil_sres=fil_sres;
 lsq_fil_sres_ind=fil_sres_ind;
 lsq_fil_den_sRes=fil_den_sRes;
end 


clear fil_den_pts fil_den_sRes fil_res fil_sres fil_sres_ind 
% clear fractions    
%--------------------------------------------
fractions_pts=round(lsq_fractions(:,1).*nPts);

%--------------------------density normalization---------------
[~,act_norm_den_pts,area_frac]=dgsac_getAreaNormalizedDensity(lsq_fil_den_sRes,lsq_fil_sres,lsq_fil_sres_ind, fractions_pts);

lsq_frac_pts=round(lsq_fractions(:,1)*nPts);

%-----------Preference Matrix-----------------
nh=size(lsq_fil_sres_ind,1);
pref_mat=zeros(nh,nPts);
for h=1:nh
     pref_mat(h,lsq_fil_sres_ind(h,1:round(lsq_fractions(h,1)*nPts)))=1;
end


nh=size(pref_mat,1);
mean_res=zeros(nh,1); % r_hat_gi
median_den=zeros(nh,1); % d_hat
ratio_den_med=zeros(nh,1); % Pi_i
per5=max([round(0.05*nPts),2*data_params.nElem]);
for it=1:nh
    mean_res(it)=mean(lsq_fil_sres(it,1:lsq_frac_pts(it)))+10e-5;
    median_den(it)=median(lsq_fil_den_sRes(it,1:lsq_frac_pts(it)));
    ratio_den_med(it)=median(lsq_fil_den_sRes(it,1:lsq_frac_pts(it)))/(median(lsq_fil_den_sRes(it,lsq_frac_pts(it)+1:min([(lsq_frac_pts(it)+per5+1) ;nPts])))+10e-5); 
    if isnan(ratio_den_med(it))
        ratio_den_med(it)=0;
    end
        
end

% Conservatively removing very bad hypotheses with flat density curves
% based on the ratio of the detected inliers vs outlier densities
% This is fixed for all type of models and experiments
d_th=data_params.d_th;
fil_hyps=[];
for ri=1:length(ratio_den_med)
    if ratio_den_med(ri) >= d_th 
     fil_hyps=[fil_hyps ri];
    end
end

pref_mat=pref_mat(fil_hyps,:);
lsq_fil_sres_ind=lsq_fil_sres_ind(fil_hyps,:);
ratio_den_med=ratio_den_med(fil_hyps);
median_den=median_den(fil_hyps);
area_frac=area_frac(fil_hyps);
mean_res=mean_res(fil_hyps);
act_norm_den_pts=act_norm_den_pts(fil_hyps,:);
%---------------------------------------------------------------------------

%-------------Pairwise hypothesis correlation-------------%
% Equation (4) and (5) in the paper

pref2=pref_mat';
resinx= lsq_fil_sres_ind';
nh= size(pref2,2);
hyp_corr_Z=zeros(nh,nh);
for out=1:nh
    for in=out+1:nh          
        min_frac=min([nnz(pref2(:,out)) nnz(pref2(:,in))]);
        hyp_corr_Z(out,in)=topkSpearmanMatrix(resinx(:,out),resinx(:,in),min_frac);      
    end
end
hyp_corr_Z=hyp_corr_Z+hyp_corr_Z'+eye(nh);
%----------------------------------------------------%


%----------Greedy Model Selection---------------%

HPi=(median_den.*ratio_den_med);
HS=(area_frac./mean_res);

[~,HS_ind]=sort(HS,'descend');
hth=data_params.hth;
intD_th=(hyp_corr_Z>=hth);

track=ones(1,length(HS_ind));
var_theta=[];

ell=find(track(HS_ind)==1);
while ~isempty(ell)
    track_hyps=find(track==1);
    eii=HS_ind(ell(1));
    curr_corr_hyps_K=track_hyps(intD_th(eii,track_hyps)==1);
    [~,RHO]=max(HPi(curr_corr_hyps_K));
    sel_hyp_RHO = curr_corr_hyps_K(RHO);
    var_theta=[var_theta; sel_hyp_RHO];
    track(curr_corr_hyps_K)=0;
    ell=find(track(HS_ind)==1);
end

%------------------------------------------------%

%-------------------Density Based Point to Model Assignment-----%
[lbl,~]=dgsac_pointModelAssignment(pref_mat(var_theta,:)',act_norm_den_pts(var_theta,:)');

%-----------------------------------------------------------


result_out.lbl=lbl;
result_out.pref_mat=pref_mat;
result_out.act_norm_den_pts=act_norm_den_pts;
result_out.lsq_fil_res=lsq_fil_res(fil_hyps,:);
result_out.lHS=HPi;
result_out.gHS=HS;
result_out.intD=hyp_corr_Z;
result_out.finalH=var_theta;
result_out.fil_hyps=fil_hyps;

return;

