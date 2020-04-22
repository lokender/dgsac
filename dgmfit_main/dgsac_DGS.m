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


%% DGSAC- DGS Sampling
function [output,data_params] =dgsac_DGS(data_params)



% Almost all notations are consistent with the paper

data=data_params.data;                      % data
model_type=data_params.model_type;          % model type
n=data_params.nPts;                         % number of datapoints
nu=ones(1,n);                               % nu
P = ones(n,n);                              % Point Correlation
alpha=data_params.gen_th;                   % Param in Algorithm 1
T=data_params.top;                          % No of Top Hyps

R=[];                                       % Residual Matrix
D=[];                                       % Density Matrix
H=[];                                       % Hypotheses




tau_prev=zeros(1,data_params.nPts);

itr_c=1;
while(1)
    disp('Iteration...');
    disp(itr_c);
    disp('Generating hyps and Computing density...');

    
[ H_hat,~,R_hat,~,] = dgsac_GenerateHyps(data_params,data,model_type,P,nu); %random,true_90,first_deterministic

if isempty(R_hat)
    break;
end

[~, ~,~,D_hat,~,~,~] = dgsac_ResidualDensity(R_hat);

T=data_params.win_den;        % Window for den corr
R = [R ;R_hat];
D = [D;D_hat];
H = [H H_hat];

disp('Updating corr');
[V,point_pref_d]=sort(D,1,'descend');    % points pref (density)
%sum_pts_pref_den_prev=sum(val_pts_pref_den,1);

tau_curr=sum(V(1:T,:),1);
pts_changed_pref=(abs(tau_curr-tau_prev)>(alpha*tau_prev));


nu(pts_changed_pref==0)=0;

if nnz(nu)<data_params.nElem
    disp('break');
    break;
end

nu=zeros(1,n);
nu(pts_changed_pref==1)=1;

tau_prev=tau_curr;
[P]=dgsac_ComputerDensityBasedPC(P,point_pref_d,T,pts_changed_pref);
itr_c=itr_c+1;
end

[~,T5]=sort(D,1,'descend');
T5=T5(1:T,:);
unique_T5=unique(T5);

output.density_pts=D(unique_T5,:);
output.Gres_mat=R(unique_T5,:);
output.hypsG=H(:,unique_T5);
output.point_corr_d=P;
end