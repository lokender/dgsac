function dist = errorVP(vp,endpoints,centroidd)

nLines=size(endpoints,1)/2;

  dist=[];
for j=1:nLines
   % vp = vp./vp(3);
   l_cap=cross(centroidd(j,:),vp); 
   tmpLine=endpoints(2*j-1:2*j,:);
   
   d1=abs(l_cap*tmpLine(1,:)')/norm(l_cap(1:2));
   d2=abs(l_cap*tmpLine(2,:)')/norm(l_cap(1:2));
   
   
   if d2>d1
   %    dist=[dist d2];
   else
   %    dist=[dist d1];
   end
   tline = cross(tmpLine(1,:),tmpLine(2,:));
   tline = tline./norm(tline);
   l_cap = l_cap./norm(l_cap);
   d= abs((-tline(2)*l_cap(1)+tline(1)*l_cap(2))/(sqrt(tline(1)^2 + tline(2)^2)*sqrt(l_cap(1)^2 + l_cap(2)^2)));
   %d = norm(cross([tline(1:2) 1],[l_cap(1:2) 1]));
   dist= [dist d];
end

