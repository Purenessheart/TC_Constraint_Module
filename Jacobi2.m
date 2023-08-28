function J=Jacobi2(theta)
  du=pi/180;  %¶È

alpha=[0, pi/2 ,0 ,0,pi/2,-pi/2];
a=0.001*[300,0, -425 ,-392.5 ,0 ,0]; % 
d=0.001*[89.2 ,135,-122 ,96.3, 94.75,82.5];


 
i=1;
T1=[cos(theta(i))                  -sin(theta(i))                 0                 a(i);
   sin(theta(i))*cos(alpha(i))  cos(theta(i))*cos(alpha(i))  -sin(alpha(i))  -sin(alpha(i))*d(i);
   sin(theta(i))*sin(alpha(i))  cos(theta(i))*sin(alpha(i))  cos(alpha(i))   cos(alpha(i))*d(i);
   0                              0                              0                 1                       ];
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
 
T6_tool=[1 0 0 0;
       0 1 0 0;
       0 0 1 0;
       0 0 0 1];
T5_tool=T6*T6_tool;
T4_tool=T5*T5_tool;
T3_tool=T4*T4_tool;
T2_tool=T3*T3_tool;
T1_tool=T2*T2_tool;
%T0_6=T1*T1_6;

T0_1=T1;
T0_2=T0_1*T2;
T0_3=T0_2*T3;
T0_4=T0_3*T4;
T0_5=T0_4*T5;
T0_6=T0_5*T6;

%J1=Jacobian(T0_6(1:3,4),[theta(1),theta(2),theta(3),theta(4),theta(5),theta(6)]);
z1=T0_1(1:3,3);
z2=T0_2(1:3,3);
z3=T0_3(1:3,3);
z4=T0_4(1:3,3);
z5=T0_5(1:3,3);
z6=T0_6(1:3,3);

R0_6=T0_6(1:3,1:3);
R0_5=T0_5(1:3,1:3);
R0_4=T0_4(1:3,1:3);
R0_3=T0_3(1:3,1:3);
R0_2=T0_2(1:3,1:3);
R0_1=T0_1(1:3,1:3);

P1_tool=R0_1*T1_tool(1:3,4);
P2_tool=R0_2*T2_tool(1:3,4);
P3_tool=R0_3*T3_tool(1:3,4);
P4_tool=R0_4*T4_tool(1:3,4);
P5_tool=R0_5*T5_tool(1:3,4);
P6_tool=R0_6*T6_tool(1:3,4);

J1=[cross(z1,P1_tool);
    z1];
J2=[cross(z2,P2_tool);
    z2];
J3=[cross(z3,P3_tool);
    z3];
J4=[cross(z4,P4_tool);
    z4];
J5=[cross(z5,P5_tool);
    z5];
J6=[cross(z6,P6_tool);
    z6];
H=[J1 J2 J3 J4 J5 J6];
J=H;