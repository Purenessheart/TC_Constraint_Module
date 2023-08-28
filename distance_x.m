function x=distance_x(p1,p2)
c=p2(1:3)-p1(1:3);
x=sqrt(c(1)^2+c(2)^2+c(3)^2);