c=1;
p=[];
while c~=100
    p1=rand(6,1)*2*pi;
 x1=position(p1);
 t1=Tjuzhen(p1);
 x2=positionT(t1);
p1=x1;
p2=x2;
 if abs(distance(p1, p2))>0.1
     break
 end

 p=[p p1];
end