function x=distance_p(p1,p2)
p=zeros(1,6);
for i=1:6
    p=p2(i)-p1(i);
end
x=sqrt(p*p');
end

