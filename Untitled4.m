c=1;
p=[];
while c~=100
    p1=rand(6,1)*2*pi;
 T1=Tjuzhen(p1);
 p2=nislotionT(T1,p1);
 if abs(distance(p1, p2))>0.1
     break
 end

 p=[p p1];
end