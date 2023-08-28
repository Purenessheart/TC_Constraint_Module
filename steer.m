function s=steer(q,q_rondom)
v=vx(q,qr);

dta=[1 -v(6) v(5) v(1);
    v(6) 1 -v(4) v(2);
    -v(5) v(4) 1 v(3);
    0 0 0 1];

Tt=Tjuzhen(q);

dt=((Tt)^(-1))*dta*Tt;
% dt=[1 0 0 0 ;
%     0 1 0 0;
%     0 0 1 0;
%     0 0 0 1]+dt;
p1=dt(1:3,4);
ry=atan2(-dt(3,1),sqrt(dt(3,2)^2+dt(3,3)^2));
rz=atan2(dt(2,1),dt(1,1)); 
rx=atan2(dt(3,2),dt(3,3));
p2=[rz;ry;rx];
p=[p1;p2];
p=const.*p;
nx=cos(p(4))*cos(p(5));
ny=sin(p(4))*cos(p(5));
nz=-sin(p(5));

ox=cos(p(4))*sin(p(5))*sin(p(6))-sin(p(4))*cos(p(6));
oy=sin(p(4))*sin(p(5))*sin(p(6))+cos(p(4))*cos(p(6));
oz=cos(p(5))*sin(p(6));

ax=cos(p(4))*sin(p(5))*cos(p(6))+sin(p(4))*sin(p(6));
ay=sin(p(4))*sin(p(5))*cos(p(6))-cos(p(4))*sin(p(6));
az=cos(p(5))*cos(p(6));
t=[nx ox ax p(1);
   ny oy ay p(2);
   nz oz az p(3);
   0  0  0  1];

ts=Tt*t;
ps=nislotionT(ts,q);
xs=positionT(ts);

s=[xs,ps];