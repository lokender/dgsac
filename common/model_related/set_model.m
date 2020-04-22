function [ distFun, hpFun, fit_model, cardmss, isdegen, d  ] = set_model( model_type )


switch model_type
    case 'line'
        distFun = @dgsac_line_res;
        hpFun = @dgsac_line_fit;
        fit_model = @dgsac_line_fit;
        isdegen = @dgsac_line_degen;
        cardmss = 2;
        d=3;

    case 'fundamental'
        distFun = @distPointFm;
        hpFun = @hpFundamental;
        fit_model = [];
        cardmss = 8;
        
        isdegen=@isdummy_degen;
        d=9;
    case 'homography'
        distFun =@distPointH;
        hpFun = @hpHomography;
        fit_model = @fit_Homography;
        cardmss = 4;
        d=9;
        isdegen=@isdegenerate_homography;

    
    case 'vanishingpoint'
        distFun = @errorVP;
        hpFun = @estimateVP;
        fit_model = @estimateVP;
        cardmss = 2;
        isdegen= @isdegenVP;
        d = 3;     
    
    otherwise
        warning('model not yet supported: possible models are line, segment,circle, homography, fundamental, subspace4')
end



end

