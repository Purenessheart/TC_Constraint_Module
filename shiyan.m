t1=[];
t2=[];
t3=[];
t4=[];
s1=[];
s2=[];
s3=[];
s4=[];
node1=[];
node2=[];
node3=[];
node4=[];
sample1=[];
sample2=[];
sample3=[];
sample4=[];
% s=[];
% node=[];
% sample=[];
for i=1:100
   r1=RRT4([pi/2 ;3*pi/4 ;3*pi/4 ;-pi/4 ;pi/2; 0],[0 ;pi ;pi/2 ;0 ;3*pi/4 ;pi/2]);
   r2=RRT4([pi/2 ;3*pi/4 ;3*pi/4 ;-pi/4 ;pi/2; 0],[pi/2; -3*pi/4;  pi/2; -pi/2; pi/2; 0]);
   r3=RRT4([pi/2 ;3*pi/4 ;3*pi/4 ;-pi/4 ;pi/2; 0],[0 ;pi ;3*pi/4 ;-pi/4 ;3*pi/4 ;pi/2]);
   r4=RRT4([pi/2 ;3*pi/4 ;3*pi/4 ;-pi/4 ;pi/2; 0],[pi/2 ;3*pi/4 ;3*pi/4 ;-pi/4 ;pi/2; 0]);
   s1=[s1 r1.s];
   t1=[t1 r1.t];
   node1=[node1 r1.node];
   sample1=[sample1 r1.sample];
   
   s2=[s2 r2.s];
   t2=[t2 r2.t];
   node2=[node2 r2.node];
   sample2=[sample2 r2.sample];
   
   s3=[s3 r3.s];
   t3=[t3 r3.t];
   node3=[node3 r3.node];
   sample3=[sample3 r1.sample];
   
   s4=[s4 r4.s];
   t4=[t4 r4.t];
   node4=[node4 r4.node];
   sample4=[sample4 r4.sample];
end

shuju1=[t1;s1;node1; sample1];
shuju2=[t2;s2;node2; sample2];
shuju3=[t3;s3;node3; sample3];
shuju4=[t4;s4;node4; sample4];