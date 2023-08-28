function jie=nislotionT(T,p2)
T=[1 0 0  0;
    0 sqrt(2)/2 sqrt(2)/2 -0.1069;
    0 -sqrt(2)/2 sqrt(2)/2 -0.1069;
     0 0 0 1]*T;
nx=T(1,1);
ny=T(2,1);
nz=T(3,1);

ox=T(1,2);
oy=T(2,2);
oz=T(3,2);

ax=T(1,3);
ay=T(2,3);
az=T(3,3);


 
px=1000*T(1,4);
py=1000*T(2,4);
pz=1000*T(3,4);
a=[0, -425 ,-392,0 ,0,0]; % 
d=[89.2 ,0,0 ,109.3, 94.75,82.5];

t1=d(4)/sqrt((d(6)*ay-py)^2+(px-d(6)*ax)^2);

t11=px-d(6)*ax;
t12=d(6)*ay-py;

theta(1,1)= acos(t1)+atan2(t11,t12);
if dist(theta(1,1),p2(1))>dist(theta(1,1)+pi,p2(1))
    theta(1,1)=(theta(1,1)+pi);
end

theta(1,2)=-acos(t1)+atan2(t11,t12);
if dist(theta(1,2),p2(1))>dist(theta(1,2)+pi,p2(1))
    theta(1,2)=(theta(1,1)+pi);
end

if dist(theta(1,1),p2(1))>dist(theta(1,2),p2(1))
    theta(1,1)=theta(1,2);
end
if imag(theta(1,1))~=0
     jie=[100;100;100;100;100;100];
else


t21=ax*sin(theta(1,1))-ay*cos(theta(1,1));
% t211=sin(theta(6,1))*(oy*cos(theta(1,1)) - ox*sin(theta(1,1))) - cos(theta(6,1))*(ny*cos(theta(1,1)) - nx*sin(theta(1,1)));
% if abs(t21-1)<10^(-5)
%     t21=1;
% else
%     if abs(t21+1)<10^(-5)
%         t21=1;
%     end
% end

theta(5,1)=acos(t21);
theta(5,2)=-theta(5,1);
if dist(theta(5,1),p2(5))>dist(theta(5,2),p2(5))
    theta(5,1)=theta(5,2);
end


if imag(theta(5,1))~=0
     jie=[100;100;100;100;100;100];
else
%     if sin(theta(5,1))==0
%          jie=[100;100;100;100;100;100];
%     else
%         a6=-oz*sin(theta(5,1));
%         b6=nz*sin(theta(5,1));
%         c6=-az*cos(theta(5,1));
t611=-ox*sin(theta(1,1))+oy*cos(theta(1,1));
t612=-nx*sin(theta(1,1))+ny*cos(theta(1,1));
%     if abs(t612)<10^(-3)
%     t612=0;
%     end
%     if abs(t611)<10^(-3)
%     t611=0;
%     end
    
    if abs(t612)<10^(-6)
    t612=0;
    end
    if abs(t611)<10^(-6)
    t611=0;
    end
    theta(6,1)=atan(-t611/t612);
    theta(6,2)=theta(6,1)+pi;

  if dist(theta(6,1),p2(6))>dist(theta(6,2),p2(6))
    theta(6,1)=theta(6,2);
  end
  d5=sin(theta(6,1))*(nx*cos(theta(1,1))+ny*sin(theta(1,1)))+cos(theta(6,1))*(ox*cos(theta(1,1))+oy*sin(theta(1,1)));
  d6=ax*cos(theta(1,1))+ay*sin(theta(1,1));

  %m1=(d(5)*cos(theta(6,1))*((ox*cos(theta(1,1))) + (oy*sin(theta(1,1))))) + (d(5)*sin(theta(6,1))*((nx*cos(theta(1,1))) + (ny*sin(theta(1,1))))) - (d(6)*ax*cos(theta(1,1))) + (px*cos(theta(1,1))) - (d(6)*ay*sin(theta(1,1))) + (py*sin(theta(1,1)));
 m1=d(5)*d5-d(6)*d6+px*cos(theta(1,1))+py*sin(theta(1,1));
  
  % m2=(d(5)*cos(theta(6,4))*((ox*cos(theta(1,4))) + (oy*sin(theta(1,4))))) + (d(5)*sin(theta(6,4))*((nx*cos(theta(1,4))) + (ny*sin(theta(1,4))))) - (d(6)*ax*cos(theta(1,4))) + (px*cos(theta(1,4))) - (d(6)*ay*sin(theta(1,4))) + (py*sin(theta(1,4)));
d52=oz*cos(theta(6,1))+nz*sin(theta(6,1));
%n1= pz - d(6)*az + (d(5)*cos(theta(6,1))*(oz  )) + (d(5)*sin(theta(6,1))*(nz)) - d(1);
n1=pz-d(1)-az*d(6)+d(5)*d52;
% n2= pz - d(6)*az + (d(5)*cos(theta(6,4))*(oz  )) + (d(5)*sin(theta(6,4))*(nz)) - d(1);

t31=(m1^2+n1^2-a(2)^2-a(3)^2)/(2*a(2)*a(3));
% if abs(t31-1)<10^(-5)
%     t31=1;
% else
%     if abs(t31+1)<10^(-5)
%         t31=1;
%     end
% end
% if abs(t31)-1>10^(-5)
%     jie=[100;100;100;100;100;100];
% else
theta(3,1)=acos(t31);
theta(3,2)=-theta(3,1);
if dist(theta(3,1),p2(3))>dist(theta(3,2),p2(3))
    theta(3,1)=theta(3,2);
end
if imag(theta(3,1))~=0
     jie=[100;100;100;100;100;100];
else
% t32=(m2^2+n2^2-a(2)^2-a(3)^2)/(2*a(2)*a(3));
% if abs(t32-1)<10^(-2)
%     t32=1;
% else
%     if abs(t32+1)<10^(-5)
%         t32=1;
%     end
% end
% theta(3,5:8)=acos(t32);
% theta(3,6:7)=-acos(t32);

theta(2,1)=atan2((n1*(a(2)+a(3)*cos(theta(3,1)))-m1*(a(3))*sin(theta(3,1))),(m1*(a(2)+a(3)*cos(theta(3,1)))+n1*(a(3))*sin(theta(3,1))));
% theta(2,2)=atan2((n1*(a(2)+a(3)*cos(theta(3,3)))-m1*(a(3))*sin(theta(3,3))),(m1*(a(2)+a(3)*cos(theta(3,3)))+n1*(a(3))*sin(theta(3,3))));
%  
% theta(2,5:8)=atan2((n2*(a(2)+a(3)*cos(theta(3,5)))-m2*(a(3))*sin(theta(3,5))),(m2*(a(2)+a(3)*cos(theta(3,5)))+n2*(a(3))*sin(theta(3,5))));
% theta(2,6:7)=atan2((n2*(a(2)+a(3)*cos(theta(3,8)))-m2*(a(3))*sin(theta(3,8))),(m2*(a(2)+a(3)*cos(theta(3,8)))+n2*(a(3))*sin(theta(3,8))));
theta(2,2)=theta(2,1)+pi;
if dist(theta(2,1),p2(2))>dist(theta(2,2),p2(2))
    theta(2,1)=theta(2,2);
end

theta(4,1)=atan2( cos(theta(5,1))*(nz*cos(theta(6,1))-oz*sin(theta(6,1)))-az*sin(theta(5,1)),cos(theta(5,1))*(cos(theta(6,1))*(cos(theta(1,1))*nx+sin(theta(1,1))*ny)-sin(theta(6,1))*(cos(theta(1,1))*ox+sin(theta(1,1))*oy))-sin(theta(5,1))*(cos(theta(1,1))*ax+sin(theta(1,1))*ay))-theta(3,1)-theta(2,1);

theta(4,2)=theta(4,1)+pi;
if dist(theta(4,1),p2(4))>dist(theta(4,2),p2(4))
    theta(4,1)=theta(4,2);
end
j=1;
    for i=1:6
        while theta(i,j)>2*pi||theta(i,j)<0
            if theta(i,j)>2*pi
                theta(i,j)=theta(i,j)-2*pi;
            else
                if theta(i,j)<0
                    theta(i,j)=theta(i,j)+2*pi;
                end
            end
        end

    end
jie=theta(:,1);
end
    end
end
end
% end

% p_ord=position(theta(:,g));
