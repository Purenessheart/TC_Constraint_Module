c=1;
p=[];
while c~=100
    p1=rand(6,1)*2*pi;
 X=position(p1);
 c1=nislotion2(X,p1);
 if abs(distance(c1, p1))>0.1
     break
 end
 c=c1(1);
 p=[p p1];
end