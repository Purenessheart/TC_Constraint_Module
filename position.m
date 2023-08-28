function p=position(theta)
%   du=pi/180;  %¶È
% theta(2)=theta(2)-pi/2;
% theta(4)=theta(4)-pi/2;
alpha=[ pi/2 ,0 ,0,pi/2,-pi/2,0];
a=0.001*[0, -425 ,-392,0 ,0,0]; % 
d=0.001*[89.2 ,0,0 ,109.3, 94.75,82.5];
o=sqrt(2)/2;
i=1;
T1=[cos(theta(i))    0    sin(theta(i))  a(i)*cos(theta(i));
    sin(theta(i))     0    -cos(theta(i))  a(i)*sin(theta(i));
   0              1               0            d(i);
   0                              0                              0                 1                       ];
   T1= [1 0 0 0;
        0 sqrt(2)/2 -sqrt(2)/2 0;
        0 sqrt(2)/2 sqrt(2)/2 0.1512;
        0   0   0   1]*T1;
i=5;
T5=[cos(theta(i))    0     -sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))      0    cos(theta(i)) a(i)*sin(theta(i));
   0               -1              0            d(i);
   0                              0                              0                 1                       ];

i=6;
T6=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];

T2_4=[cos(theta(2)+theta(3)+theta(4)) 0  sin(theta(2)+theta(3)+theta(4)) -0.392*cos(theta(2)+ theta(3)) - 0.425*cos(theta(2));
      sin(theta(2)+theta(3)+theta(4)) 0 -cos(theta(2)+theta(3)+theta(4)) -0.392*sin(theta(2)+ theta(3)) - 0.425*sin(theta(2));
                    0              1              0                        0.1093;
                    0              0              0                             1];
T0_6=T1*T2_4*T5*T6;

p1=T0_6(1:3,4);


ry=atan2(-T0_6(3,1),sqrt(T0_6(3,2)^2+T0_6(3,3)^2));
if ry==pi/2
    rz=0;
    rx=atan2(T0_6(1,2),T0_6(2,2));
else
    if ry==-pi/2
        rz=0;
        rx=-atan2(T0_6(1,2),T0_6(2,2));
    else
        rz=atan2(T0_6(2,1),T0_6(1,1));
        rx=atan2(T0_6(3,2),T0_6(3,3));
    end
end

p2=[rz;ry;rx];
p=[p1;p2];