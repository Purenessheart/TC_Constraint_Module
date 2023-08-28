function jie=nislotion1(p)
nx=cos(p(4))*cos(p(5));
ny=sin(p(4))*cos(p(5));
nz=-sin(p(5));

ox=cos(p(4))*sin(p(5))*sin(p(6))-sin(p(4))*cos(p(6));
oy=sin(p(4))*sin(p(5))*sin(p(6))+cos(p(4))*cos(p(6));
oz=cos(p(5))*sin(p(6));

ax=cos(p(4))*sin(p(5))*cos(p(6))+sin(p(4))*sin(p(6));
ay=sin(p(4))*sin(p(5))*cos(p(6))-cos(p(4))*sin(p(6));
az=cos(p(5))*cos(p(6));

px=p(1);
py=p(2);
pz=p(3);

t1=0.1093/sqrt((0.0825*ay-py)^2+(px-0.0825*ax)^2);
if abs(t1-1)<10^(-5)
    t1=1;
else
    if abs(t1+1)<10^(-5)
        t1=1;
    end
end
t11=px-0.0825*ax;
t12=0.0825*ay-py;
    if abs(t12)<10^(-5)
    t12=0;
    end
    if abs(t11)<10^(-5)
    t11=0;
    end
theta(1,1:4)= acos(t1)+atan2(t11,t12);
theta(1,5:8)=-acos(t1)+atan2(t11,t12);
% m=0.0825*ay-py;
% n=0.0825*ax-px;
% % if m^2+n^2-0.193^2<0
% %     
% %     jie=[100;100;100;100;100;100];
% % 
% % else
%     
% theta(1,1:4)= atan2(m,n)+atan2(0.0825,sqrt(m^2+n^2-0.193^2));
% theta(1,5:8)= atan2(m,n)+atan2(0.0825,-sqrt(m^2+n^2-0.193^2));

t611=ox*sin(theta(1,1))-oy*cos(theta(1,1));
t612=(nx*sin(theta(1,1))-ny*cos(theta(1,1)));
    if abs(t612)<10^(-3)
    t612=0;
    end
    if abs(t611)<10^(-3)
    t611=0;
    end
    
t621=ox*sin(theta(1,5))-oy*cos(theta(1,5));
t622=nx*sin(theta(1,5))-ny*cos(theta(1,5));
    if abs(t622)<10^(-5)
    t622=0;
    end
    if abs(t621)<10^(-5)
    t621=0;
    end
theta(6,1:4)=atan2(-t611,t612);
theta(6,5:8)=atan2(-t621,t622);

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

m1=(0.09475*cos(theta(6,1))*((ox*cos(theta(1,1))) + (oy*sin(theta(1,1))))) + (0.09475*sin(theta(6,1))*((nx*cos(theta(1,1))) + (ny*sin(theta(1,1)))))/(1) - (0.0825*ax*cos(theta(1,1))) + (px*cos(theta(1,1))) - (0.0825*ay*sin(theta(1,1))) + (py*sin(theta(1,1)));
m2=(0.09475*cos(theta(6,4))*((ox*cos(theta(1,4))) + (oy*sin(theta(1,4))))) + (0.09475*sin(theta(6,4))*((nx*cos(theta(1,4))) + (ny*sin(theta(1,4)))))/(1) - (0.0825*ax*cos(theta(1,4))) + (px*cos(theta(1,4))) - (0.0825*ay*sin(theta(1,4))) + (py*sin(theta(1,4)));

n1= 1.0*pz - 0.0825*az + (0.09475*cos(theta(6,1))*(1.0*oz  )) + (0.09475*sin(theta(6,1))*(1.0*nz)) - 0.0892;
n2= 1.0*pz - 0.0825*az + (0.09475*cos(theta(6,4))*(1.0*oz  )) + (0.09475*sin(theta(6,4))*(1.0*nz)) - 0.0892;

t31=(m1^2+n1^2-0.425^2-0.392^2)/(2*0.425*0.392);
if abs(t31-1)<10^(-5)
    t31=1;
else
    if abs(t31+1)<10^(-5)
        t31=1;
    end
end
if abs(t31)-1>10^(-5)
    t=[100;100;100;100;100;100];
else
theta(3,1:4)=acos(t31);
theta(3,2:3)=-acos(t31);
end
t32=(m2^2+n2^2-0.425^2-0.392^2)/(2*0.425*0.392);
if abs(t32-1)<10^(-2)
    t32=1;
else
    if abs(t32+1)<10^(-5)
        t32=1;
    end
end
theta(3,5:8)=acos(t32);
theta(3,6:7)=-acos(t32);

theta(2,1:4)=atan2((n1*(-0.425-0.392*cos(theta(3,1)))-m1*(-0.392)*sin(theta(3,1))),(m1*(-0.425-0.392*cos(theta(3,1)))+n1*(-0.392)*sin(theta(3,1))));
theta(2,2:3)=atan2((n1*(-0.425-0.392*cos(theta(3,3)))-m1*(-0.392)*sin(theta(3,3))),(m1*(-0.425-0.392*cos(theta(3,3)))+n1*(-0.392)*sin(theta(3,3))));
 
theta(2,5:8)=atan2((n2*(-0.425-0.392*cos(theta(3,5)))-m2*(-0.392)*sin(theta(3,5))),(m2*(-0.425-0.392*cos(theta(3,5)))+n2*(-0.392)*sin(theta(3,5))));
theta(2,6:7)=atan2((n2*(-0.425-0.392*cos(theta(3,8)))-m2*(-0.392)*sin(theta(3,8))),(m2*(-0.425-0.392*cos(theta(3,8)))+n2*(-0.392)*sin(theta(3,8))));

theta(4,1)=atan2( cos(theta(5,1))*(nz*cos(theta(6,1))-oz*sin(theta(6,1)))-az*sin(theta(5,1)),cos(theta(5,1))*(cos(theta(6,1))*(cos(theta(1,1))*nx+sin(theta(1,1))*ny)-sin(theta(6,1))*(cos(theta(1,1))*ox+sin(theta(1,1))*oy))-sin(theta(5,1))*(cos(theta(1,1))*ax+sin(theta(1,1))*ay))-theta(3,1)-theta(2,1);
theta(4,2)=atan2( cos(theta(5,2))*(nz*cos(theta(6,2))-oz*sin(theta(6,2)))-az*sin(theta(5,2)),cos(theta(5,2))*(cos(theta(6,2))*(cos(theta(1,2))*nx+sin(theta(1,2))*ny)-sin(theta(6,2))*(cos(theta(1,2))*ox+sin(theta(1,2))*oy))-sin(theta(5,2))*(cos(theta(1,2))*ax+sin(theta(1,2))*ay))-theta(3,2)-theta(2,2);

theta(4,3)=atan2( cos(theta(5,3))*(nz*cos(theta(6,3))-oz*sin(theta(6,3)))-az*sin(theta(5,3)),cos(theta(5,3))*(cos(theta(6,3))*(cos(theta(1,3))*nx+sin(theta(1,3))*ny)-sin(theta(6,3))*(cos(theta(1,3))*ox+sin(theta(1,3))*oy))-sin(theta(5,3))*(cos(theta(1,3))*ax+sin(theta(1,3))*ay))-theta(3,3)-theta(2,3);
theta(4,4)=atan2( cos(theta(5,4))*(nz*cos(theta(6,4))-oz*sin(theta(6,4)))-az*sin(theta(5,4)),cos(theta(5,4))*(cos(theta(6,4))*(cos(theta(1,4))*nx+sin(theta(1,4))*ny)-sin(theta(6,4))*(cos(theta(1,4))*ox+sin(theta(1,4))*oy))-sin(theta(5,4))*(cos(theta(1,4))*ax+sin(theta(1,4))*ay))-theta(3,4)-theta(2,4);

theta(4,5)=atan2( cos(theta(5,5))*(nz*cos(theta(6,5))-oz*sin(theta(6,5)))-az*sin(theta(5,5)),cos(theta(5,5))*(cos(theta(6,5))*(cos(theta(1,5))*nx+sin(theta(1,5))*ny)-sin(theta(6,5))*(cos(theta(1,5))*ox+sin(theta(1,5))*oy))-sin(theta(5,5))*(cos(theta(1,5))*ax+sin(theta(1,5))*ay))-theta(3,5)-theta(2,5);
theta(4,6)=atan2( cos(theta(5,6))*(nz*cos(theta(6,6))-oz*sin(theta(6,6)))-az*sin(theta(5,6)),cos(theta(5,6))*(cos(theta(6,6))*(cos(theta(1,6))*nx+sin(theta(1,6))*ny)-sin(theta(6,6))*(cos(theta(1,6))*ox+sin(theta(1,6))*oy))-sin(theta(5,6))*(cos(theta(1,6))*ax+sin(theta(1,6))*ay))-theta(3,6)-theta(2,6);
 
theta(4,7)=atan2( cos(theta(5,7))*(nz*cos(theta(6,7))-oz*sin(theta(6,7)))-az*sin(theta(5,7)),cos(theta(5,7))*(cos(theta(6,7))*(cos(theta(1,7))*nx+sin(theta(1,7))*ny)-sin(theta(6,7))*(cos(theta(1,7))*ox+sin(theta(1,7))*oy))-sin(theta(5,7))*(cos(theta(1,7))*ax+sin(theta(1,7))*ay))-theta(3,7)-theta(2,7);
theta(4,8)=atan2( cos(theta(5,8))*(nz*cos(theta(6,8))-oz*sin(theta(6,8)))-az*sin(theta(5,8)),cos(theta(5,8))*(cos(theta(6,8))*(cos(theta(1,8))*nx+sin(theta(1,8))*ny)-sin(theta(6,8))*(cos(theta(1,8))*ox+sin(theta(1,8))*oy))-sin(theta(5,8))*(cos(theta(1,8))*ax+sin(theta(1,8))*ay))-theta(3,8)-theta(2,8);

s=0;
% t=[];
for g=1:8
p_ord=position(theta(:,g));
if abs(distance(p_ord,p))<0.01
    s=s+1;
    t(:,s)=theta(:,g);
%     t=[t p3];
    
end
end

for i=1:6
    for j=1:s
        while t(i,j)>2*pi||t(i,j)<0
            if t(i,j)>2*pi
                t(i,j)=t(i,j)-2*pi;
            else
                if t(i,j)<0
                    t(i,j)=t(i,j)+2*pi;
                end
            end
        end

    end

end


  jie=t;
end
% for z=1:s
%     c2=distance_p(theta(:,z),p2);
%     if c1>c2
%         c1=c2;
%         jie=t(:,z);
%     end
% end
% end
