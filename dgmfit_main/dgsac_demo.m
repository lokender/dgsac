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



close all;
clear all;

%test_case='line';
test_case='VP';
%test_case='homography';
%test_case='fundamental';

data_params.do_lsq=0;
if strcmp(test_case,'line')
    %----------------Line ----------------------------%
    % Input= 2xN [N data points in 2D grid]
    % Ouput= label for each data point (inlier or outlier) [label 0 is for gross outliers]
    data_params.model_type='line';
    data_params.seq_name='dgsac_line.mat';
    data_params=get_data_params(data_params);
    
    
    hyp_gen_t=tic;
    [output,data_params]=dgsac_DGS(data_params); 
    hyp_gen_total=toc(hyp_gen_t);
    
    opt_time=tic;
    result_out=getModelsAndInliers(output,data_params);
    opt_t_end=toc(opt_time);
    [CA,~,~,~,~]=compute_clustering_performance(data_params.gt_data,result_out.lbl);

    plotLineHypotheses(data_params.data,output.hypsG(:,result_out.fil_hyps(result_out.finalH)),[],1,result_out.lbl);
    plotLabeledData(result_out.lbl,data_params.data,0,15);
    fprintf('Clustering Accuracy is %2f\n',CA*100);
    
end

if strcmp(test_case,'VP')
    %-----------------VP------------------------------%
    % Input= end points of line segments [Check York Urban Database for
    % exact format
    % Ouput= label for each data point(line) (inlier or outlier) [label 0 is for gross outliers]
    
    data_params.basePath='./';
    data_params.seq_name='P1020816';
    data_params.model_type='vanishingpoint';
    data_params = get_data_params(data_params);
    [output,data_params]=dgsac_DGS(data_params); 
 
    opt_time=tic;
    result_out=getModelsAndInliers(output,data_params);
    opt_t_end=toc(opt_time);
    [CA,~,~,~,~]=compute_clustering_performance(data_params.gt_data,result_out.lbl);
    fprintf('Clustering Accuracy is %2f\n',CA*100);
    plotVPs;
end



if strcmp(test_case,'homography')
    %---------------Homography-------------------------%
    % Input= Point correspondences
    % Ouput= label for each data point(point correspondence) (inlier or outlier) [label 0 is for gross outliers]
    
    data_params.do_lsq=1;
    data_params.model_type='homography';
    data_params.seq_name='dgsac_nese.mat';
    data_params = get_data_params(data_params);
    [output,data_params]=dgsac_DGS(data_params); 
    data_params.do_lsq=1;
    opt_time=tic;
    result_out=getModelsAndInliers(output,data_params);
    opt_t_end=toc(opt_time);
    [CA,~,~,~,~]=compute_clustering_performance(data_params.gt_data,result_out.lbl);
    fprintf('Clustering Accuracy is %2f\n',CA*100);
    figure(1)
    hold on; imshow(data_params.im1);
    hold on; plotLabeledData(result_out.lbl,data_params.orig_data(1:2,:),0,15);

end


if strcmp(test_case,'fundamental')
    %------------Fundamental----------------------------%
    % Input= Point correspondences
    % Ouput= label for each data point(point correspondence) (inlier or outlier) [label 0 is for gross outliers]
    
    data_params.do_lsq=1;
    data_params.model_type='fundamental';
    data_params.seq_name='dgsac_biscuitbookbox.mat';
    data_params = get_data_params(data_params);
    tic
    [output,data_params]=dgsac_DGS(data_params); 
    toc
    opt_time=tic;    
    result_out=getModelsAndInliers(output,data_params);
    opt_t_end=toc(opt_time);
    [CA,~,~,~,~]=compute_clustering_performance(data_params.gt_data,result_out.lbl);
    fprintf('Clustering Accuracy is %2f\n',CA*100);
    
    figure(1)
    hold on; imshow(data_params.im1);
    hold on; plotLabeledData(result_out.lbl,data_params.orig_data(1:2,:),0,15);
    
   
end






