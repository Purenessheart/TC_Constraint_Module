subplot(2,2,1)
  i=0:0.01:5.46;
plot(i,p1(10,:));
 hold on
plot(i,p1(11,:)+pi/2);
plot(i,p1(12,:)-pi/2);
xlabel('time/s');
ylabel('rad');
axis([0 10 -pi pi])
legend('alpha','gama','bata');
title('Group 1');

subplot(2,2,2)
  i=0:0.02:1.88*2;
plot(i,p2(10,:));
 hold on
plot(i,p2(11,:)+pi/2);
plot(i,p2(12,:)-pi/2);
xlabel('time/s');
ylabel('rad');
axis([0 10 -pi pi])
legend('alpha','gama','bata');
title('Group 2');

subplot(2,2,3)
  i=0:0.02:2.11*2;
plot(i,p3(10,:));
 hold on
plot(i,p3(11,:)+pi/2);
plot(i,p3(12,:)-pi/2);
xlabel('time/s');
ylabel('rad');
axis([0 10 -pi pi])

legend('alpha','gama','bata');
title('Group 3');

subplot(2,2,4)
  i=0:0.02:2.89*2;
plot(i,p4(10,:));
 hold on
plot(i,p4(11,:)+pi/2);
plot(i,p4(12,:)-pi/2);
xlabel('time/s');
ylabel('rad');
axis([0 10 -pi pi])
legend('alpha','gama','bata');
title('Group 4');