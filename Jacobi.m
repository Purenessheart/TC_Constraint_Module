function J=Jacobi(theta)
%% D-H参数这里可以改
alpha=[ pi/2 ,0 ,0,pi/2,-pi/2,0];
a=0.001*[0, -425 ,-392.5 ,0 ,0,0]; %%
d=0.001*[89.2 ,0,0 ,109.3, 94.75,82.5];
%%
%% 标准的DH建模
i=1;
T1=[cos(theta(i))    0    sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))     0    -cos(theta(i)) a(i)*sin(theta(i)); 
   0              1               0            d(i);
   0                              0                              0                 1                       ];


i=2;
T2=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];


i=3;
T3=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];



i=4;
T4=[cos(theta(i))    0     sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))     0    -cos(theta(i))  a(i)*sin(theta(i));
   0                 1              0            d(i);
   0                              0                              0                 1                       ];


i=5;
T5=[cos(theta(i))    0     -sin(theta(i))  a(i)*cos(theta(i));
   sin(theta(i))      0    cos(theta(i))   a(i)*sin(theta(i));
   0              -1              0            d(i);
   0               0               0             1                       ];

i=6;
T6=[cos(theta(i))    -sin(theta(i))    0 a(i)*cos(theta(i));
   sin(theta(i))      cos(theta(i))   0  a(i)*sin(theta(i));
   0             0              1           d(i);
   0                              0                              0                 1                       ];

%%
T6_tool=[1 0 0 0;%%TCP到第六个关节的旋转变化这里可以改
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
  %%
T5_tool=T6*T6_tool;
T4_tool=T5*T5_tool;
T3_tool=T4*T4_tool;
T2_tool=T3*T3_tool;
T1_tool=T2*T2_tool;


T0_1=T1;
T0_2=T0_1*T2;
T0_3=T0_2*T3;
T0_4=T0_3*T4;
T0_5=T0_4*T5;
T0_6=T0_5*T6;


z1=[0;0;1];
z2=[0;0;1];
z3=[0;0;1];
z4=[0;0;1];
z5=[0;0;1];
z6=[0;0;1];

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
