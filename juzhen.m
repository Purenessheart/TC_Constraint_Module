% clc;
% clear;

syms theta_1 theta_2 theta_3 theta_4 theta_5 theta_6 nx ox ax px  ny oy ay py  nz oz az pz al1 al2 al3 al4 al5 al6  a1 a2 a3 a4 a5 a5 a6 d1 d2 d3 d4 d5 d6;
% theta_1=pi/2; theta_2=-pi/2; theta_3 =0; theta_4=-pi/2; theta_5=0; theta_6=pi/2;
theta=[theta_1;theta_2;theta_3;theta_4;theta_5;theta_6];
alpha=[ al1 al2 al3 al4 al5 al6 ];
% alpha=[ pi/2 ,0 ,0,pi/2,-pi/2,0];
% a=0.001*[0, -425 ,-392.5 ,0 ,0,0]; %
a=0.001*[0  -425 -392.5 0 0 0 ]; % 

d=0.001*[89.2 ,0,0 ,109.3, 94.75,82.5];

% d=[ d1 d2 d3 d4 d5 d6];
t=[ theta_1 theta_2 theta_3 theta_4 theta_5 theta_6];%
i=1;
T1=[cos(theta(i))    0    sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))     0    -cos(theta(i)) a(i)*sin(theta(i)); 
   0              1               0            d(i);
   0                              0                              0                 1                       ];
nT1=[cos(theta(i))    sin(theta(i))   0  0;
               0                0    1  -d(i); 
   sin(theta(i))    -cos(theta(i))   0   0;
   0                0                0   1                       ];

i=2;
T2=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];
nT2=[cos(theta(i))     sin(theta(i))    0  -a(i);
  -sin(theta(i))      cos(theta(i))    0   0;
   0                  0                1   0;
   0                  0                0   1                       ];

i=3;
T3=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];

 nT3=[cos(theta(i))     sin(theta(i))    0  -a(i);
    -sin(theta(i))      cos(theta(i))    0   0;
     0                  0                1  0;
     0                  0                0   1                       ];


i=4;
T4=[cos(theta(i))    0     sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))     0    -cos(theta(i))  a(i)*sin(theta(i));
   0                 1              0            d(i);
   0                              0                              0                 1                       ];
nT4=[cos(theta(i))    sin(theta(i))   0  -a(i);
               0                0    1  -d(i); 
   sin(theta(i))    -cos(theta(i))   0   0;
   0                0                0   1                       ];

i=5;
T5=[cos(theta(i))    0     -sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))      0    cos(theta(i))   a(i)*sin(theta(i));
   0              -1              0            d(i);
   0               0               0             1                       ];
nT5=[cos(theta(i))              sin(theta(i))              0   -a(i);
   0                           0                         -1    d(i);
  -sin(theta(i))              cos(theta(i))               0    0;
   0               0               0             1                       ];

i=6;
T6=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];
 nT6=[cos(theta(i))     sin(theta(i))    0  -a(i);
    -sin(theta(i))      cos(theta(i))    0   0;
     0                  0                1  -d(i);
     0                  0                0   1                       ];


% T2_4=[cos(theta(2)+theta(3)+theta(4)) 0  sin(theta(2)+theta(3)+theta(4)) -0.392*cos(theta(2)+ theta(3)) - 0.425*cos(theta(2));
%       sin(theta(2)+theta(3)+theta(4)) 0 -cos(theta(2)+theta(3)+theta(4)) -0.392*sin(theta(2)+ theta(3)) - 0.425*sin(theta(2));
%                     0              1              0                        0.1093;
%                     0              0              0                             1];


Tgoal=[nx ox ax px;
       ny oy ay py;
       nz oz az pz;
       0   0  0  1];
% % h=(T1)^(-1)*Tgoal*(T6)^(-1);
% T=T1*Tgoal*T6;
% TT=T2_4*nT5;
T=T2*T3*T4*T5
% T(3,2)

nT=nT1*Tgoal*nT6
% nT(3,2)

% sin(theta_5)*(nz*cos(theta_6) - oz*sin(theta_6)) + az*cos(theta_5)=0
(33*ay*cos(theta_1))/400 - (379*sin(theta_6)*(ny*cos(theta_1) - nx*sin(theta_1)))/4000 - py*cos(theta_1) - (33*ax*sin(theta_1))/400 + px*sin(theta_1) - (379*cos(theta_6)*(oy*cos(theta_1) - ox*sin(theta_1)))/4000
 
% J1=diff(T(3,4),theta_3);
% subs(J1,{theta_1 theta_2 theta_3 theta_4 theta_5 theta_6},{0 0 0 0  0 0})

% theta11=acos(0.1092/sqrt((0.0825*ay-py)^2+(px-0.0825*ax)^2))+atan2((px-0.0825*ax)/(0.0825*ay_py));
% theta12=-acos(0.1092/sqrt((0.0825*ay-py)^2+(px-0.0825*ax)^2))+atan2((px-0.0825*ax)/(0.0825*ay_py));

% theta511=acos(ax*sin(theta11)-ay*cos(theta21));
% theta512=-acos(ax*sin(theta11)-ay*cos(theta21));
% theta521=acos(ax*sin(theta21)-ay*cos(theta21));
% theta522=-acos(ax*sin(theta21)-ay*cos(theta21));

% theta6=atan(-(ox*sin(theta1)-oy*cos(theta1))/(nx*sin(theta1)-ny*cos(theta1)))

% m=0.09475*((nx*cos(theta1)+ny*sin(theta1))*sin(theta6)+(ox*cos(theta1)+oy*sin(theta1))*cos(theta6))-d6(ax*cos(theta1)+ay*sin(theta1))+px*cos(theta1)+py*sin(theta1);
% n=0.09475*(nz*sin(theta6)+oz*cos(theta6))-d6*az+pz-0.0892;
% theta3=acos((m^2+n^2-0.425^2-0.3925^2)/(2*0.425*0.3925));
% theta2=atan((n*(-0.425-0.3925*cos(theta_3))-m*(-0.3925)*sin(theta3))/(m*(-0.425-0.3925*cos(theta_3))+n*(-0.3925)*sin(theta3)));
% theta123=-asin(pz/sin(theta5));
% T1_6=T1*T2_4*T5*T6;%*T5*T6;
% l=T1_5(1:3,4);
% T14=[ cos(theta_2 + theta_3 + theta_4)*cos(theta_1),      sin(theta_1),  sin(theta_2 + theta_3 + theta_4)*cos(theta_1),   0.1093*sin(theta_1) - 1.0*cos(theta_1)*(0.392*cos(theta_2 + theta_3) + 0.425*cos(theta_2));
%    cos(theta_2 + theta_3 + theta_4)*sin(theta_1), -1.0*cos(theta_1), sin(theta_2 + theta_3 + theta_4)*sin(theta_1), - 0.1093*cos(theta_1) - 1.0*sin(theta_1)*(0.392*cos(theta_2 + theta_3) + 0.425*cos(theta_2)) + 0.425*sin(theta_2);  
% sin(theta_2 + theta_3 + theta_4), 0, -1.0*cos(theta_2 + theta_3 + theta_4),  0.0892 - 0.425*sin(theta_2) - 0.392*sin(theta_2 + theta_3); 
% 0, 0, 0, 1.0];

% T=[           cos(theta_6)*(sin(theta_1)*sin(theta_5) + cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*cos(theta_5)) - 1.0*sin(theta_2 + theta_3 + theta_4)*cos(theta_1)*sin(theta_6), - 1.0*sin(theta_6)*(sin(theta_1)*sin(theta_5) + cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*cos(theta_5)) - 1.0*sin(theta_2 + theta_3 + theta_4)*cos(theta_1)*cos(theta_6),       cos(theta_5)*sin(theta_1) - 1.0*cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*sin(theta_5), 0.1093*sin(theta_1) + 0.0825*cos(theta_5)*sin(theta_1) + 0.09475*sin(theta_2 + theta_3 + theta_4)*cos(theta_1) - 1.0*cos(theta_1)*(0.392*cos(theta_2 + theta_3) + 0.425*cos(theta_2)) - 0.0825*cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*sin(theta_5);
%     - 1.0*cos(theta_6)*(cos(theta_1)*sin(theta_5) - 1.0*cos(theta_2 + theta_3 + theta_4)*cos(theta_5)*sin(theta_1)) - 1.0*sin(theta_2 + theta_3 + theta_4)*sin(theta_1)*sin(theta_6),   sin(theta_6)*(cos(theta_1)*sin(theta_5) - 1.0*cos(theta_2 + theta_3 + theta_4)*cos(theta_5)*sin(theta_1)) - 1.0*sin(theta_2 + theta_3 + theta_4)*cos(theta_6)*sin(theta_1), - 1.0*cos(theta_1)*cos(theta_5) - 1.0*cos(theta_2 + theta_3 + theta_4)*sin(theta_1)*sin(theta_5), 0.09475*sin(theta_2 + theta_3 + theta_4)*sin(theta_1) - 0.0825*cos(theta_1)*cos(theta_5) - 0.1093*cos(theta_1) - 1.0*sin(theta_1)*(0.392*cos(theta_2 + theta_3) + 0.425*cos(theta_2)) - 0.0825*cos(theta_2 + theta_3 + theta_4)*sin(theta_1)*sin(theta_5);
%                                                                           cos(theta_2 + theta_3 + theta_4)*sin(theta_6) + sin(theta_2 + theta_3 + theta_4)*cos(theta_5)*cos(theta_6),                                                               cos(theta_2 + theta_3 + theta_4)*cos(theta_6) - 1.0*sin(theta_2 + theta_3 + theta_4)*cos(theta_5)*sin(theta_6),                                               -1.0*sin(theta_2 + theta_3 + theta_4)*sin(theta_5),                                                                                              0.0892 - 0.392*sin(theta_2 + theta_3) - 0.425*sin(theta_2) - 0.0825*sin(theta_2 + theta_3 + theta_4)*sin(theta_5) - 0.09475*cos(theta_2 + theta_3 + theta_4);
%                                                                                                                                                                                    0,                                                                                                                                                                            0,                                                                                                0,                                                                                                                                                                                                                                                       1.0];
%    
% vpa(T,5)

% T1_1=T1;
% T1_2=T1*T2;
% T1_3=T1*T2*T3;
% T1_4=T1*T2*T3*T4;
% T1_5=T1*T2*T3*T4*T5;
% T1_6=T1*T2*T3*T4*T5*T6;
% y1=T1_1(1:3,4);
% y2=T1_2(1:3,4);
% y3=T1_3(1:3,4);
% y4=T1_4(1:3,4);
% y5=T1_5(1:3,4);
% y6=T1_6(1:3,4);
% vpa(y1);
% vpa(y2);
% vpa(y3);
% vpa(y4);
% vpa(y5);
% vpa(y6);
% J1=[diff(y1,theta_1) diff(y1,theta_2) diff(y1,theta_3) diff(y1,theta_4) diff(y1,theta_5) diff(y1,theta_6)];
% J2=[diff(y2,theta_1) diff(y2,theta_2) diff(y2,theta_3) diff(y2,theta_4) diff(y2,theta_5) diff(y2,theta_6)];
% J3=[diff(y3,theta_1) diff(y3,theta_2) diff(y3,theta_3) diff(y3,theta_4) diff(y3,theta_5) diff(y3,theta_6)];
% J4=[diff(y4,theta_1) diff(y4,theta_2) diff(y4,theta_3) diff(y4,theta_4) diff(y4,theta_5) diff(y4,theta_6)];
% J5=[diff(y5,theta_1) diff(y5,theta_2) diff(y5,theta_3) diff(y5,theta_4) diff(y5,theta_5) diff(y5,theta_6)];
% J6=[diff(y6,theta_1) diff(y6,theta_2) diff(y6,theta_3) diff(y6,theta_4) diff(y6,theta_5) diff(y6,theta_6)]
% 
 
% 
% T=T2_4*T5*T6;
% 
% % 
% 
% p=[0.1093*sin(theta_1) + 0.0825*cos(theta_5)*sin(theta_1) + 0.09475*sin(theta_2 + theta_3 + theta_4)*cos(theta_1) - 1.0*cos(theta_1)*(0.345*cos(theta_2 + theta_3) + 0.425*cos(theta_2)) - 0.0825*cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*sin(theta_5);
% 0.09475*sin(theta_2 + theta_3 + theta_4)*sin(theta_1) - 0.0825*cos(theta_1)*cos(theta_5) - 0.1093*cos(theta_1) - 1.0*sin(theta_1)*(0.345*cos(theta_2 + theta_3) + 0.425*cos(theta_2)) - 0.0825*cos(theta_2 + theta_3 + theta_4)*sin(theta_1)*sin(theta_5);
%  - 0.345*sin(theta_2 + theta_3) - 0.425*sin(theta_2) - 0.09475*cos(theta_2 + theta_3 + theta_4) - 0.0825*sin(theta_2 + theta_3 + theta_4)*sin(theta_5) + 0.0892];
% % vpa(p,5)
% vpa(T(1:3,4),5)
% 
%  h1=[cos(theta_6)*(sin(theta_1)*sin(theta_5) + cos(theta_2 + theta_3 + theta_4)*cos(theta_1)*cos(theta_5)) - 1.0*sin(theta_6)*( sin(theta_2 + theta_3 + theta_4)*cos(theta_1));
% sin(theta_6)*( - 1.0*sin(theta_2 + theta_3 + theta_4)*sin(theta_1)) - 1.0*cos(theta_6)*(cos(theta_1)*sin(theta_5) - 1.0*cos(theta_2 + theta_3 + theta_4)*cos(theta_5)*sin(theta_1));
% cos(theta_2 + theta_3 + theta_4)*sin(theta_6) + cos(theta_6)*( + sin(theta_2 + theta_3 + theta_4)*cos(theta_5))];
% 
% h2=[-sin(theta_6)*(sin(theta_1)*sin(theta_5)+cos(theta_2+theta_3+theta_4)*cos(theta_1)*cos(theta_5))-sin(theta_2+theta_3+theta_4)*cos(theta_1)*cos(theta_6);
% sin(theta_6)*(cos(theta_1)*sin(theta_5)-cos(theta_2+theta_3+theta_4)*cos(theta_5)*sin(theta_1))-sin(theta_2+theta_3+theta_4)*cos(theta_6)*sin(theta_1);
% cos(theta_2+theta_3+theta_4)*cos(theta_6)-sin(theta_2+theta_3+theta_4)*cos(theta_5)*sin(theta_6)];
% 
% h3=[cos(theta_5)*sin(theta_1)-1.0*cos(theta_2+theta_3+theta_4)*cos(theta_1)*sin(theta_5);
% -1.0*cos(theta_1)*cos(theta_5)-1.0*cos(theta_2+theta_3+theta_4)*sin(theta_1)*sin(theta_5);
% - 1.0*sin(theta_2 + theta_3 + theta_4)*sin(theta_5)];
% % theta_1=1; theta_2=2; theta_3 =3; theta_4=4; theta_5=5; theta_6=6;
% R=[h1 h2 h3];
% fx=1/2*(R(3,2)-R(2,3));
% fy=1/2*(R(1,3)-R(3,1));
% fz=1/2*(R(2,1)-R(1,2));
% the=1/sqrt(fx^2+fy^2+fz^2);
% fz=-cos(theta_1+theta_6)*sin(theta_5)+cos(theta_5)*cos(theta_2+theta_3+theta_4)*sin(theta_1+theta_6)+sin(theta_2+theta_3+theta_4)*cos(theta_1+theta_6);
% % v=solve(h1==[0;0;1]);
