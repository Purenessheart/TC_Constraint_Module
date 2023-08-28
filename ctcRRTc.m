function xinxi=ctcRRTc(q_goal,q_ord)
global vrep;
global clientID;
jiekou();
% if a<=-1
%     
% end
t1=cputime();
tree1=[];
tree1=[tree1 [q_ord;0]];

tree2=[];
tree2=[tree2 [position(q_ord);1]];


tree3=[];
tree3=[tree3 [q_goal;0]];

tree4=[];
tree4=[tree4 [position(q_goal);1]];

n1=1;
n2=1;

% qg=position(q_goal);
%  figure
%   plot3(qg(1),qg(2),qg(3),'*');
%     plot3(tree2(1),tree2(2),tree2(3),'*');
%     axis([-1 1 -1 1 -1 1])
%   hold on
success=0; 
cons=[1,1,1,0,0,0]';
while (n1+n2)<5000%%||distance_p(tree1(:,n1),q_goal)>0.05
%     if distance_p(tree1(:,n1),q_goal)<0.05
%         success=1;
%     end 

%     if rand(1)>0.5
       q_new.c=rand(6,1)*2*pi; 
%       
%      else
%        q_new.c=q_goal;
%      end
        dc=distance_p(tree1(1:6,1),q_new.c);
     
        b=1;
    if n1>1
      for j=2:n1
      if dc>distance_p(tree1(1:6,j),q_new.c)
      
              dc=distance_p(tree1(1:6,j),q_new.c);
            
              b=j;
      end  
      end
    end
    if n1>5000
        n1=0;
        break
    end
     a1=dc;
     
 

           q_near.c=tree1(1:6,b);
           q_near.x=tree2(1:6,b);
           s=steer( q_near.c,q_new.c,cons);

            nodle_x=s(:,1);
%              nodle=nislotion1(nodle_x)
            nodle=s(:,2);
              c=0;
      if nodle(1)~=100
        a2=distance_p(nodle,q_new.c);
        if vrep_text(nodle)==0
            if a2<a1

          
            for h=1:n1
            if distance_p(tree1(1:6,h),nodle)>0.001

            c=c+1;
            end
            end
          if c==n1
             a1=a2;
            
             tree1=[tree1 [nodle;b]];
             tree2=[tree2 [nodle_x;tree2(7,b)+1]];
             

            

            n1=n1+1;
            a1=distance(nodle,q_new.c);
            b=n1;
          if rand()>0.5
           q_new.c=nodle;
          else
            q_new.c=rand(6,1)*2*pi; 
          end
          dd=distance_p(tree3(1:6,1), q_new.c);
         b=1;
         if n2>1
         for j=2:n2
           if dd>distance_p(tree3(1:6,j), q_new.c)
      
              dd=distance_p(tree3(1:6,j), q_new.c);
            
              b=j;
           end  
         end
         end
          a3=dd;
        while a3>0.1
           q_near.c=tree3(1:6,b);
           q_near.x=tree4(1:6,b);
           s=steer( q_near.c,q_new.c,cons);
           nodle_x=s(:,1);
           nodle=s(:,2);
              c=0;
              if nodle(1)==100
                  break
              end
              if vrep_text(nodle)==1
                  break
              end
              
             if distance_p(nodle,tree3(1:6,b))>0.2
               break
             end
              a4=distance_p(nodle,q_new.c);
            if a4>=a3
              break
            end
            for h=1:n2
             if distance_p(tree3(1:6,h),nodle)<0.001
               break
             end
              c=c+1;
            end
            if c==n2
             a3=a4;
            
             tree3=[tree3 [nodle;b]];
             tree4=[tree4 [nodle_x;b]];
             n2=n2+1;

            b=n2;
           else
               break
           end

        end
           if a3<=0.1
               success=1;
         break
           end
         end
           end
              end
      end
  
end
 vrep.simxFinish(clientID);
 disp('Failed connecting to remote API server');
 vrep.delete()
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



path1=[];
path2=[];
path3=[];
path4=[];
nn=n1;
nn1=n2;
n=0;
nn2=0;
while nn~=0
    path1=[path1 tree1(1:6,nn)];
    path2=[path2 tree2(1:6,nn)];
    nn=tree1(7,nn);
    n=n+1;
end
while nn1~=0
    path3=[path3 tree3(1:6,nn1)];
    path4=[path4 tree4(1:6,nn1)];
    nn1=tree3(7,nn1);
    nn2=nn2+1;
end
path=path3(1:6,:);
for j=1:n
    path=[path1(1:6,j) path]
end


% path1(2,:)=path1(2,:)+pi/2;
% path1(4,:)=path1(4,:)+pi/2;
% figure;
% plot(path1(1,:));
% hold on
% plot(path1(2,:));
% plot(path1(3,:));
% plot(path1(4,:));
% plot(path1(5,:));
% plot(path1(6,:));
% 
% figure;
% plot(path2(1,:));
% hold on
% plot(path2(2,:));
% plot(path2(3,:));
% plot(path2(4,:));
% plot(path2(5,:));
% plot(path2(6,:));
% path=[path1;path2];
% p=path';


fid=fopen('path.txt','w');%建立文件
for i=1:(n+nn2)
  fprintf(fid,'%.8f %.8f %.8f %.8f %.8f %.8f\r\n',path(1:6,i));%保存小数点后8位，Ipluse_data为结果数据 ?
end

fclose(fid);

t2=cputime();
t=t2-t1;
xinxi.t=t;
xinxi.s=success;
% xinxi.node=n;
% xinxi.sample=n1; 
end