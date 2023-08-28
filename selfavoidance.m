function a = selfavoidance(theta)
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
 
T21=[1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T21=T1*T2*T21;
p21=T21(1:3,4);

T22=[1 0 0 -0.085;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T22=T1*T2*T22;
p22=T22(1:3,4);

T23=[1 0 0 -0.085*2;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T23=T1*T2*T23;
p23=T23(1:3,4);

T24=[1 0 0 -0.085*3;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T04=T1*T2*T24;
p24=T04(1:3,4);

T25=[1 0 0 -0.085*4;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T05=T1*T2*T25;
p25=T05(1:3,4);

T31=[1 0 0 0;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
     
T03=T1*T2*T3*T31;
p31=T03(1:3,4);

T32=[1 0 0 -0.098;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
     
T32=T1*T2*T3*T32;
p32=T32(1:3,4);

T33=[1 0 0 -0.098*2;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
     
T33=T1*T2*T3*T33;
p33=T33(1:3,4);

T34=[1 0 0 -0.098*3;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
     
T34=T1*T2*T3*T34;
p34=T34(1:3,4);

T41=[1 0 0 0;
         0 1 0 0;
         0 0 1 0;
         0 0 0 1];
T41=T1*T2*T3*T4*T41;
p41=T41(1:3,4);

T51=[1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
T51=T1*T2*T3*T4*T5*T51;
p51=T51(1:3,4);
l2=[p21 p22 p23 p24 p25];
l3=[p31 p32 p33 p34];
l4=p41;
l5=p51;
x=-1;
while x==-1
    for i=1:5
         if distance_x(l2(:,i),l4)<0.15
             x=0;
             break
         end
         if distance_x(l2(:,i),l5)<0.15
             x=0;
             break
         end
    end
    if x==0
        break
    end
    for j=1:4
         if distance_x(l3(:,j),l5)<0.1
             x=0;
             break
         end
     end
      if x==0
        break
      end
      x=1;
end
a=x;

%  plot3(p21(1),p21(2),p21(3),'x');
%  hold on
%  plot3(p22(1),p22(2),p22(3),'x');
%  plot3(p23(1),p23(2),p23(3),'x');
%  plot3(p24(1),p24(2),p24(3),'x');
%  plot3(p25(1),p25(2),p25(3),'x');
%  
%  plot3(p31(1),p31(2),p31(3),'x');
%  plot3(p32(1),p32(2),p32(3),'x');
%  plot3(p33(1),p33(2),p33(3),'x');
%  plot3(p34(1),p34(2),p34(3),'x');
%  
%  plot3(p41(1),p41(2),p41(3),'x');
%  
%  plot3(p51(1),p51(2),p51(3),'x');
