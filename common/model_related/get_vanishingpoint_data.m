function  [data,gt_data, data_params] = get_vanishingpoint_data(data_params)
data=[];
gt_data=[];
base_path = data_params.basePath;
seq_name = data_params.seq_name;
addpath(strcat(base_path,seq_name,'/'));
fname = strcat(seq_name,'LinesAndVP','.mat');

img=imread(strcat(seq_name,'.jpg'));

tlines=load(fname,'lines','vp_association');
tvp_association=load(fname,'vp_association');
endpoints=tlines.lines;
data_params.orig_endpoints=endpoints;

endpoints=[endpoints ones(size(endpoints,1),1)];
[endpoints, ~] = normalise2dpts(endpoints');
endpoints=endpoints';
nLines=size(endpoints,1)/2;
centroids=zeros(nLines,3);
linesEq=zeros(nLines,3);

for k=1:nLines
   linesEq(k,:)=cross( endpoints(2*k-1,:) ,endpoints(2*k,:) );
   centroids(k,:)=sum(endpoints(2*k-1:2*k,:),1)./2 ;   
end
data_params.data=linesEq';
data_params.centroidd=centroids;
data_params.gt_data=tvp_association.vp_association;
gt_data=tvp_association.vp_association;
data_params.endpoints=endpoints;
data_params.nPts=nLines;
data_params.img=img;

return;
end





