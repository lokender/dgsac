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

function plotLabeledData(lbl,data,out_lbl,ms)

lbl=lbl+1;
out_lbl=out_lbl+1;

nlbl=nnz(unique(lbl));
ulbl=unique(lbl);
color_list=[1 0 0;0 1 0;0 0 1;1 1 0; 1 0 1; 0 1 1;0.5 0.5 1;0.3 0.1 0.6 ];
% if ~isempty(out_lbl)
% hold on; plot(data(1,lbl==out_lbl),data(2,lbl==out_lbl),'g.','MarkerSize',ms);
% end
%figure(randi(100))
for i=1:nlbl
if ~isempty(out_lbl) && ulbl(i)==out_lbl
  hold on; plot(data(1,lbl==out_lbl),data(2,lbl==out_lbl),'k.','MarkerSize',ms);

else    
%color=[abs(rand(1)-0.3) abs(rand(1)-0.3) 0];   
color=color_list(i,:);
hold on; plot(data(1,lbl==ulbl(i))',data(2,lbl==ulbl(i))','.','color',color,'MarkerSize',ms);
end
end
    
end