path1=path(1:6,1:122);
path2=path(7:12,1:122);
figure;
plot(path1(1,:));
hold on
plot(path1(2,:));
plot(path1(3,:));
plot(path1(4,:));
plot(path1(5,:));
plot(path1(6,:));
legend('jiont1','jiont2','jiont3','jiont4','jiont5','jiont6');
figure;

% plot(path2(1,:));
% hold on
% plot(path2(2,:));
% plot(path2(3,:));

plot(path2(4,:));

 hold on
plot(path2(5,:));
plot(path2(6,:));
legend('alpha','gama','bata');
% axis([0 120 -0.001 0.001])
figure;

plot3(path2(1,:),path2(2,:),path2(3,:));
axis([-1 1 -1 1 -1 1])
fid=fopen('path.txt','w');%建立文件
%循环写入数据
for i=1:123
  fprintf(fid,'%.8f %.8f %.8f %.8f %.8f %.8f\r\n',path(1:6,i));%保存小数点后8位，Ipluse_data为结果数据 ?
end

fclose(fid);
