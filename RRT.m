% function path=RRT(q_ord,q_goal)
function path=RRT(q_goal,q_ord)
tree1=[];
tree1=[tree1 [q_ord;0]];
global tree2;
tree2=[];
tree2=[tree2 [position(q_ord);0]];
n1=1;


% s=[0;0;0;pi;0;-pi/2];
 figure;
 qg=position(q_goal);
  plot3(qg(1),qg(2),qg(3),'*');
    axis([-1 1 -1 1 -1 1])
  hold on

while distance(tree2(:,n1),position(q_goal))>0.01%%||distance_p(tree1(:,n1),q_goal)>0.05
     if rand(1)>0.2
       q_new.c=rand(6,1)*2*pi; 
       q_new.p=position(q_new.c);
     else
       q_new.c=q_goal;
       q_new.p=position(q_goal);
      
     end
        dc=distance_p(tree1(1:6,1),q_new.c);
        dx=distance(tree2(1:6,1),q_new.p);
        b=1;
    if n1>1
      for j=2:n1
      if dc>distance_p(tree1(1:6,j),q_new.c)
%          tt=q_new.p(1:3)-tree2(1:3,j);
%           if sqrt(tt'*tt)<10^-3
%               dc=distance_p(tree1(1:6,j),q_new.c);
%               dx=distance(tree2(1:6,j),q_new.p);
%               b=j;
%           else
%               vv=tree2(1:3,j)-tree2(1:3,tree2(7,j));
%               aa=(tt/sqrt(tt'*tt))-(vv/sqrt(vv'*vv));
%               if sqrt(aa'*aa)<0.55
              dc=distance_p(tree1(1:6,j),q_new.c);
              dx=distance(tree2(1:6,j),q_new.p);
              b=j;
%               end
%           end
      end  
      end
    end
     a1=dx;
       f=0;
       while a1>0.001
           q_near=tree2(1:6,b);
            nodle_x=nodle_new(q_near,q_new.p);
%              nodle=nislotion1(nodle_x)
            nodle=nislotion2(nodle_x,tree1(:,b));
              c=0;
              if nodle(1)==100
                  break
              end
          for h=1:n1
           if distance_p(tree1(1:6,h),nodle)<0.001
               break
           end
           c=c+1;
          end
           if distance(tree2(1:6,n1),position(q_goal))<0.001
               break
           end
%            if f==500
%                break
%            end
           if distance_p(nodle,tree1(1:6,b))>0.2
               break
           end
           a2=distance(nodle_x,q_new.p);
           if a2>=a1
           break
           end
           
           if c==n1
             a1=a2;
             f=f+1;
             tree1=[tree1 [nodle;b]];
             tree2=[tree2 [nodle_x;b]];
             
%            plot3(tree2(1,n1),tree2(2,n1),tree2(3,n1),'x');
%            x=[tree2(1,b),nodle_x(1)];
%            y=[tree2(2,b),nodle_x(2)];
%            z=[tree2(3,b),nodle_x(3)];
%            plot3(x,y,z,'r');  

           plot3(tree2(1,n1),tree2(2,n1),tree2(3,n1),'x');
           x=[tree2(1,b),nodle_x(1)];
           y=[tree2(2,b),nodle_x(2)];
           z=[tree2(3,b),nodle_x(3)];
           plot3(x,y,z,'r'); 
            n1=n1+1;
            a1=distance(nodle_x,q_new.p);
            b=n1;
           else
               break;
           end
       end
%      if xq(n1-f,5)~=-1&&f>5
%       ph=pinghua(v(n1-f+1),v(tree2(7,n1-f+1)));
%        if ph==0
%            p0=tree2(1:6,xq(n1-f+1,5));
%            p1=tree2(1:6,xq(n1-f+1,1));
%            p2=tree2(1:6,n1-f+5);
%           
%        for ii=1:10
%            hh=(1-(ii-1)/9)^2*p0+2/9*(ii-1)*(1-(ii-1)/9)*p1+((ii-1)/9)^2*p2;
%            tree2(1:6,xq(n1-f+6,11-ii))=hh;
%            nhh=nislotion(hh,tree1(1:6,xq(n1-f+7,11-ii)));
%            tree1(1:6,xq(n1-f+6,11-ii))=nhh;
%        end
% %        for nn=1:40
% %            cc=tree2(:,xq(n1-f+20,nn));
% %            plot3(cc(1),cc(2),cc(3),'x');
% %            x=[cc(1),tree2(1,cc(7))];
% %            y=[cc(2),tree2(2,cc(7))];
% %            z=[cc(3),tree2(3,cc(7))];
% %            plot3(x,y,z,'r');
% %        end
%        end
%     end
%        for nn=1:8
%        tree2(1:6,xq(n1-f+5,nn))=h(8-nn+1);
%        end
end


path1=[];
path2=[];
nn=n1;
while nn~=0
    path1=[path1 tree1(1:6,nn)];
    path2=[path2 tree2(1:6,nn)];
    nn=tree1(7,nn);
end
figure;
plot(path1(1,:));
hold on
plot(path1(2,:));
plot(path1(3,:));
plot(path1(4,:));
plot(path1(5,:));
plot(path1(6,:));

figure;
plot(path2(1,:));
hold on
plot(path2(2,:));
plot(path2(3,:));
plot(path2(4,:));
plot(path2(5,:));
plot(path2(6,:));
path=[path1;path2];
end