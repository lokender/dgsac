function P = dgsac_line_fit(data,mss,wts)

P=[];
if isempty(wts)
   wts=ones(1,size(mss,2));
   wts=wts./norm(wts);
end
if size(wts,1)>size(wts,1)
    wts=wts';
end
for nmss=1:size(mss,1)
    X= data(:,mss(nmss,:));
    N = size(X,2);
    A = [X; ones(1,N)]';
    A = A.*repmat(wts',[1 3]);
    [~, ~, V] = svd(A);
    P = [P V(:,3)];
end
end