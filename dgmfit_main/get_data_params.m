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

function data_params = get_data_params(data_params)

data_params.gen_th=.01;
data_params.top=5;
data_params.d_th=3;
data_params.hth=0.15;
    
switch(lower(data_params.model_type))
    case {'line'}
        load(data_params.seq_name)
        data_params.data = data;
        data_params.gt_data = gt_data;
        data_params.nPts=size(data_params.data,2);
        data_params.nElem=2;
        data_params.win_den=5;
        data_params.frac_b=ceil(0.025*data_params.nPts);
                  
          
    case 'homography'
            load(data_params.seq_name)
            data_params.im1=img1;
            data_params.im2=img2;
            data_params.orig_data=data;
            X1 = data(1:3,:);
            X2 = data(4:6,:);
            [X1_norm, ~] = normalise2dpts(X1);
            [X2_norm, ~] = normalise2dpts(X2);
            data = [X1_norm;X2_norm];
            data_params.ds_name='homography';
            data_params.model_type='homography';
            data_params.nElem = 4;
            data_params.degenFunc = @isdegenerate_homography;
            data_params.fitFunc = @homography2d_fit;
            data_params.distFunc = @homog2d_dist;
    
            data_params.nPts=size(data,2);
            data_params.data=data;
            data_params.gt_data=label;    
            nPts=size(data,2);
            data_params.win_den=5;
            data_params.frac_b=max(round(0.025*nPts),2*data_params.nElem);

    case 'fundamental'
                    
            load(data_params.seq_name)
            data_params.im1=img1;
            data_params.im2=img2;
            data_params.orig_data=data;
            X1 = data(1:3,:);
            X2 = data(4:6,:);
            [X1_norm, ~] = normalise2dpts(X1);
            [X2_norm, ~] = normalise2dpts(X2);
            data = [X1_norm;X2_norm];
            data_params.ds_name='fundamental';
            data_params.model_type='fundamental';
            data_params.nElem = 8;
            data_params.degenFunc = @isdegenerate_fundamental;
            data_params.fitFunc = @fundmatrix;
            data_params.distFunc = @funddistance;
    
            data_params.nPts=size(data,2);
            data_params.data=data;
            data_params.gt_data=label;    
            nPts=size(data,2);
            data_params.win_den=5;
            data_params.frac_b=max(round(0.025*nPts),2*data_params.nElem);

    case 'vanishingpoint'
             data_params.nElem = 2;
             data_params.degenFunc = @isdegenerate_dummy;
             data_params.fitFunc = @estimateVP;
             data_params.distFunc = @errorVP;
  
            [~,~, data_params] = get_vanishingpoint_data(data_params);
            nPts=size(data_params.data,2);
            data_params.nPts=nPts;
            data_params.win_den=5;
            data_params.frac_b=3;
    otherwise
        error('invalid dataset name');
end

return;

















end