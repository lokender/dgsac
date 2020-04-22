function vp = estimateVP(linesEq,mss,wts)

   m=size(mss,1);
   linesEq=linesEq'; 
   vp=zeros( m,3); 
   for itr=1: m
       if isempty(wts)
          wts=ones(1,length(mss(itr,:)));
          wts=wts./norm(wts);
       end
       
       if size(wts,2)>size(wts,1)
           wts=wts';
       end
       [~,~,v]=svd(linesEq(mss(itr,:),:).*repmat(wts,[1 3]));
       vp(itr,:)=v(:,3)';
   end

   
   
end



% % %    m=size(mss,1);
% % %    linesEq=linesEq'; 
% % %    vp=zeros( m,3); 
% % %    for itr=1: m
% % %        vp(itr,:)=cross(linesEq(mss(itr,1),:),linesEq(mss(itr,2),:));
% % %        vp(itr,:)=vp(itr,:)./norm(vp(itr,:));
% % %    end
% % % 
% % % end