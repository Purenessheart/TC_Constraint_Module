t1=cputime();
path=load ('path.txt');
[m,n]=size(path);

v=[];
% v=[v zeros(6,1)]

t=0;

i=1;

pathn=[];
% pathn=[pathn;path(1,:)];

path1=[];
path1=[path1 path(1,:)'];
 a=[];
v0=zeros(6,1);
%%判断速度节点
k=[];
k=[k 1];
dd=[];

% for ii=2:m-1
%     d2=vc(path(i,:),path(i+1,:));
%     if min(d1.*d2)<0
%         k=[k ii];
%     end
%     dd=[dd d1];
%     d1=d2;
% end
% dd=[dd d1];
% k=[k m];
% jj=1;

pp=path(1,:);
jj=1;
while jj< m
 vv1=vc(path(jj,:),pp);
 dd1=sqrt(vv1'*vv1);
 vv2=vc(path(jj,:),path(jj+1,:));
 dd2=sqrt(vv2'*vv2);
    if dd1<dd2
        pathn=[pathn;pp];
        pp=pp+0.01/dd2*(vv2)';
    else
         
          pp=path(jj+1,:);
%           pathn=[pathn;pp];
         jj=jj+1;
    end
end

[mn,nn]=size(pathn);

d1=vc(pathn(1,:),pathn(2,:));
for ii=2:mn-1
    d2=vc(pathn(ii,:),pathn(ii+1,:));
    if min(d1.*d2)<0
        k=[k ii];
    end
    dd=[dd d1];
    d1=d2;
end
dd=[dd d1];
k=[k mn];

figure;
plot(pathn(:,1));
hold on
plot(pathn(:,2));
plot(pathn(:,3));
plot(pathn(:,4));
plot(pathn(:,5));
plot(pathn(:,6));

figure;
plot(dd(1,:));
hold on
plot(dd(2,:));
plot(dd(3,:));
plot(dd(4,:));
plot(dd(5,:));
plot(dd(6,:));

% v=zeros(6,1);
v=0;
c=2;
t=0;
times=[];
times=[times 0];
vv=[];
while i<mn
    if v/(k(c)-i)<0.01
       v=v+0.01;
        if v>0.2
            v=0.2;
        end
    else
        v=v-0.1;
         if v<0.05
            v=0.05;
         end
    end
    
    if i==k(c)
        c=c+1;
    end
    
    v1=v*dd(:,i)/sqrt(dd(:,i)'*dd(:,i));
    vv=[vv v1];
    dt=max(abs(dd(:,i).*v1.^(-1)));
    t=t+dt;
    times=[times t];
    i=i+1;
end
vv=[vv zeros(6,1)];
figure;
plot(times,pathn(:,1));
hold on
plot(times,pathn(:,2));
plot(times,pathn(:,3));
plot(times,pathn(:,4));
plot(times,pathn(:,5));
plot(times,pathn(:,6));

tt=0;
j=1;
path_new=[];
times_new=[];

while tt<t
      if tt>times(j+1)
          j=j+1;
      else
      p=pathn(j,:)'+vv(:,j)*(tt-times(j));
      path_new=[path_new p];
      times_new=[times_new tt];
      tt=tt+0.008;
  end
end
figure;
plot(times_new,path_new(1,:));
hold on
plot(times_new,path_new(2,:));
plot(times_new,path_new(3,:));
plot(times_new,path_new(4,:));
plot(times_new,path_new(5,:));
plot(times_new,path_new(6,:));

[m,n]=size(path_new);
fid=fopen('path1.txt','w');%建立文件
%循环写入数据
for i=1:n
  fprintf(fid,'%.8f %.8f %.8f %.8f %.8f %.8f\r\n',path_new(1:6,i));%保存小数点后8位，Ipluse_data为结果数据 ?
end

fclose(fid);

fid=fopen('mn.txt','w');%建立文件
%循环写入数据
  fprintf(fid,'%.8f %.8f\r\n',[mn,nn]);%保存小数点后8位，Ipluse_data为结果数据 ?

fclose(fid);

% while i<m
% %     max=1;
%     d=vc(path(i,:),path(i+1,:));
%     p1=path(i ,:)'+d;
%     maxv=0.2;
%     amax=0.8;
%     dmax=max(abs(d));
%     v1=d/(dmax/maxv);
%     dv=v1-v0;
%     at=max(abs(dv))/amax;
% %     dt=dmax/maxv;%%到达时间
% dt=max(abs(1/2*d.*((v1+v0)).^(-1)));
% %     p1=path(i,:)';
%     while  at>dt
%         maxv=abs(maxv-0.001);
% %         if maxv<0
% %             i=i-1
%         v1=maxv*d/dmax;%%p
%         dv=v1-v0;
%         at=max(abs(dv))/amax;
%         dt=max(abs(1/2*d.*((v1+v0)).^(-1)));
%          
%     end
%     %%变速
%     a1=(v1-v0)/dt;
% %             dt=at;
% %             a=dv/dt;
% %             v1=d/dt+1/2*a*dt; 
% %             p2=p1+v0*(1/3*dt)+1/2*a*((1/3*dt)^2);
% %             v2=v0+1/3*a*dt;
% %             p3=p2+v2*(1/3*dt)+1/2*a*((1/3*dt)^2);
% %             v3=v2+1/3*a*dt;
% %             path1=[path1 p1 p2 p3];
% %             v=[v v0 v2 v3];
% %             times=[times t+1/3*dt t+2/3*dt t+dt];
% %             t=t+dt;
% %             v0=v1;
% %     else 
%     a=[a a1];
%     path1=[path1 p1];
%     v=[v v0];
%     t=t+dt;
%     times=[times t];
%     v0=v1;
% 
%    %%0.2 最大速度
%      
%  
% 
% %     a=[a a1];
%     i=i+1;
% end
% 
% v=[v v0];
% 
% tt=0;
% j=1;
% path_new=[];
% times_new=[];
% 
% while tt<t
%       if tt>times(j+1)
%           j=j+1;
%       else
%       p=path1(:,j)+(tt-times(j))*v(:,j)+1/2*a(:,j)*(tt-times(j))^2;
%       path_new=[path_new p];
%       times_new=[times_new tt];
%       tt=tt+0.008;
%   end
% end
% t2=cputime();
% t=t2-t1;
% [m,n]=size(path_new);
% fid=fopen('path1.txt','w');%建立文件
% %循环写入数据
% for i=1:n
%   fprintf(fid,'%.8f %.8f %.8f %.8f %.8f %.8f\r\n',path_new(1:6,i));%保存小数点后8位，Ipluse_data为结果数据 ?
% end
% 
% fclose(fid);
% 
% figure;
% plot(times,v(1,:));
% hold on
% plot(times,v(2,:));
% plot(times,v(3,:));
% plot(times,v(4,:));
% plot(times,v(5,:));
% plot(times,v(6,:));
% legend('jiont1','jiont2','jiont3','jiont4','jiont5','jiont6');
% % figure;
% % plot(amax(1,:));
% % hold on
% % plot(amax(2,:));
% % plot(amax(3,:));
% % plot(amax(4,:));
% % plot(amax(5,:));
% % plot(amax(6,:));
% % legend('jiont1','jiont2','jiont3','jiont4','jiont5','jiont6');
% 
% figure;
% plot(path(:,1));
% hold on
% plot(path(:,2));
% plot(path(:,3));
% plot(path(:,4));
% plot(path(:,5));
% plot(path(:,6));
% 
% figure;
% plot(times,path1(1,:));
% hold on
% plot(times,path1(2,:));
% plot(times,path1(3,:));
% plot(times,path1(4,:));
% plot(times,path1(5,:));
% plot(times,path1(6,:));
% 
% 
% 
% figure;
% plot(times_new,path_new(1,:));
% hold on
% plot(times_new,path_new(2,:));
% plot(times_new,path_new(3,:));
% plot(times_new,path_new(4,:));
% plot(times_new,path_new(5,:));
% plot(times_new,path_new(6,:));