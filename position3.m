function p=position3(theta)  
du=pi/180;  %¶È
% theta(2)=theta(2)-pi/2;
% theta(4)=theta(4)-pi/2;
alpha=[0, pi/2 ,0 ,0,pi/2,-pi/2];
a=0.001*[0,0, -425 ,-392 ,0 ,0]; % 
d=0.001*[89.2 ,135,-122 ,96.3, 94.75,82.5];



i=1;
T1=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];

   T1= [1 0 0 0;
        0 sqrt(2)/2 -sqrt(2)/2 0;
        0 sqrt(2)/2 sqrt(2)/2 0.1512;
        0   0   0   1]*T1;
i=2;
T2=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
i=3;
T3=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
i=4;
T4=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
i=5;
T5=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
i=6;
T6=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
T0_6=T1*T2*T3*T4*T5*T6;
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