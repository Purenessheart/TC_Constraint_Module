nx=1;
ny=0;
nz=0;

ox=0;
oy=0;
oz=1;

ax=0;
ay=-1;
az=0;

 
px=0;
py=-0.1918;
pz=1.00095;
t1=0.1093/sqrt((0.0825*ay-py)^2+(px-0.0825*ax)^2);
if abs(t1-1)<10^(-5)
    t1=1;
else
    if abs(t1+1)<10^(-5)
        t1=1;
    end
end
theta(1,1:4)= acos(t1)+atan2((px-0.0825*ax),(0.0825*ay-py));
theta(1,5:8)=-acos(t1)+atan2((px-0.0825*ax),(0.0825*ay-py));

theta(6,1:4)=atan2(-(ox*sin(theta(1,1))-oy*cos(theta(1,1))),( nx*sin(theta(1,1))-ny*cos(theta(1,1))));
theta(6,5:8)=atan2(-(ox*sin(theta(1,5))-oy*cos(theta(1,5))),(nx*sin(theta(1,5))-ny*cos(theta(1,5))));

t21=ax*sin(theta(1,1))-ay*cos(theta(1,1));
if abs(t21-1)<10^(-5)
    t21=1;
else
    if abs(t21+1)<10^(-5)
        t21=1;
    end
end

theta(5,1:2)=acos(t21);
theta(5,3:4)=-acos(t21);

t22=ax*sin(theta(1,5))-ay*cos(theta(1,5));
if abs(t22-1)<10^(-5)
    t22=1;
else
    if abs(t22+1)<10^(-5)
        t22=1;
    end
end

theta(5,5:6)= acos(t22);
theta(5,7:8)=-acos(t22);


m1=(0.09475*cos(theta(6,1))*((ox*cos(theta(1,1))) + (oy*sin(theta(1,1))))) + (0.09475*sin(theta(6,1))*((nx*cos(theta(1,1))) + (ny*sin(theta(1,1)))))/(cos(theta(6,1))^2 + sin(theta(6,1))^2) - (0.0825*ax*cos(theta(1,1))) + (px*cos(theta(1,1))) - (0.0825*ay*sin(theta(1,1))) + (py*sin(theta(1,1)));
m2=(0.09475*cos(theta(6,4))*((ox*cos(theta(1,4))) + (oy*sin(theta(1,4))))) + (0.09475*sin(theta(6,4))*((nx*cos(theta(1,4))) + (ny*sin(theta(1,4)))))/(cos(theta(6,4))^2 + sin(theta(6,4))^2) - (0.0825*ax*cos(theta(1,4))) + (px*cos(theta(1,4))) - (0.0825*ay*sin(theta(1,4))) + (py*sin(theta(1,4)));

n1= 1.0*pz - 0.0825*az + (0.09475*cos(theta(6,1))*(1.0*oz  )) + (0.09475*sin(theta(6,1))*(1.0*nz)) - 0.0892;
n2= 1.0*pz - 0.0825*az + (0.09475*cos(theta(6,4))*(1.0*oz  )) + (0.09475*sin(theta(6,4))*(1.0*nz)) - 0.0892;

t31=(m1^2+n1^2-0.425^2-0.392^2)/(2*0.425*0.392);  
theta(3,1:4)=acos(t31);
theta;