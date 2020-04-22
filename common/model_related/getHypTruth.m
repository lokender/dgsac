function [output]=getHypTruth(output,data_params)

mss=output.hypsG;
[~,sres_ind]=sort(output.Gres_mat,2);
gt_data=data_params.gt_data;
true_fracs=data_params.true_fracs;
gd_th=output.gd_th;

nh = size(mss,2);
lbls = unique(gt_data);
nl = length(lbls);
gt_mss = zeros(nh,1);
gt_frac = zeros(nh,1);

true_fracs = round(true_fracs*length(gt_data));
gt_frac_olap=zeros(nh,nl);
for i=1:nh
  t_mss = unique(mss(:,i));
  t_nn = sres_ind(i,:);      
  tmp_frac_o = zeros(1,nl);
 
    for it=1:nl
        if all(gt_data(t_mss) == lbls(it)) ~= 0
            gt_mss(i,1)=lbls(it);
        end
        
        tmp_frac_o(1,it) = nnz(gt_data(t_nn(1:true_fracs(it))) == lbls(it))/true_fracs(it);
        
    end
    gt_frac_olap(i,:)=tmp_frac_o;
         [~,mind]=max( tmp_frac_o(1,:));  
         if (tmp_frac_o(1,mind) >=gd_th)
         gt_frac(i,1)=lbls(mind);
         end
    
end

stats_in_per_mss=zeros(4,nl);
stats_in_per_gtfrac=zeros(4,nl);
for it=1:nl
    stats_in_per_mss(1,it)=mean(gt_frac_olap(gt_mss==lbls(it),it));
    stats_in_per_mss(2,it)=median(gt_frac_olap(gt_mss==lbls(it),it));
    stats_in_per_mss(3,it)=max(gt_frac_olap(:,it));
    stats_in_per_mss(4,it)=min(gt_frac_olap(:,it));
    
    stats_in_per_gtfrac(1,it)=mean(gt_frac_olap(gt_frac==lbls(it),it));
    stats_in_per_gtfrac(2,it)=median(gt_frac_olap(gt_frac==lbls(it),it));
    stats_in_per_gtfrac(3,it)=max(gt_frac_olap(:,it));
    stats_in_per_gtfrac(4,it)=min(gt_frac_olap(:,it));
end

per_good_mss=nnz(gt_mss)/nh;
per_good_frac=nnz(gt_frac)/nh;

output.gt_mss=gt_mss;
output.gt_frac=gt_frac;
output.gt_frac_olap = gt_frac_olap;
output.stats_in_per_mss=stats_in_per_mss;
output.stats_in_per_gtfrac=stats_in_per_gtfrac;
output.per_good_mss=per_good_mss;
output.per_good_frac=per_good_frac;

end