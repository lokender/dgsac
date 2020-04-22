figure(randi(100));
hold on;imshow(data_params.img);

endpoints= data_params.orig_endpoints;
est_inliers=result_out.lbl;
for k=1:data_params.nPts
    TL=endpoints((2*k-1):(2*k),:);
    if est_inliers(k)==1
    hold on;plot(TL(:,1),TL(:,2),'r-','LineWidth',4);
    end
    if est_inliers(k)==2
    hold on;plot(TL(:,1),TL(:,2),'g-','LineWidth',4);
    end
    if est_inliers(k)==3
    hold on;plot(TL(:,1),TL(:,2),'b-','LineWidth',4);
    end
     if est_inliers(k)==4
    hold on;plot(TL(:,1),TL(:,2),'m-','LineWidth',4);
     end
     if est_inliers(k)==5
    hold on;plot(TL(:,1),TL(:,2),'c-','LineWidth',4);
     end
     if est_inliers(k)==6
    hold on;plot(TL(:,1),TL(:,2),'k-','LineWidth',4);
     end
     if est_inliers(k)==7
    hold on;plot(TL(:,1),TL(:,2),'y-','LineWidth',4);
     end
    
    if est_inliers(k)==0
    hold on;plot(TL(:,1),TL(:,2),'c-','LineWidth',4);
    
    end
    
end
