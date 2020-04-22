function [ mss,H,R,tim] = dgsac_GenerateHyps(data_params, X, model,point_corr_rd ,pt_indic)


tim=0;
[distFun, hpFun, fit_model, cardmss, isdegen, ~] = set_model( model );

data_params.fitFunc=fit_model;
data_params.distFunc=distFun;
cardmss=cardmss;
n = size(X,2);


%if strcmp(sampling_type,'first_deterministic')
pt_idx=find(pt_indic==1);
mss=[];
for i = 1:length(pt_idx) 
      out_flag=1;
       if nnz(point_corr_rd(pt_idx(i),:)) >=cardmss && out_flag==1
           tmp_mss=pt_idx(i);
         
           tmp_second=point_corr_rd(pt_idx(i),:);
           flag=1;
           while flag
                for it=1:cardmss-1
                        tmp_second(1,tmp_mss)=0;
                        tmp_second = tmp_second./sum(tmp_second);
                        if ~isnan(tmp_second)
                        tmp_mss = [tmp_mss; randsample(n,1,true,tmp_second)]; 
                        else
                            flag=0;
                            break;
                        end
                            
                end 
                if ~((length(unique(tmp_mss))<cardmss) || isdegen( X(:,tmp_mss))||~flag) 
                    mss = [mss tmp_mss];
                    flag=0;
                else
                    tmp_mss=pt_idx(i);
                    out_flag=1;
                end
           end
       end
end

mss=mss';
wts=[];
H = hpFun(X,mss,wts); %hypotheses


if strcmp(data_params.model_type,'vanishingpoint')
    R = dgsac_vpResiduals(H,data_params.endpoints,data_params.centroidd, distFun ); disp('Residuals Computed')
else
    R = res( X, H, distFun ); 

end

R=R';
mss=mss';
