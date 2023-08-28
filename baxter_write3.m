  function baxter_write3()
disp('Program started');
% vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
p=load ('path.txt');
% p=load ('path11.txt');
% p=[52.19;-97.18;119.27;-150.62;115.75;182.48]';
% p=[-28.82;-72.35;133.55;-125.68;128.51;217.63]';
% p=p/180*pi;
% p=[-pi/2  ;-pi/2; pi/2 ;-3*pi/4 ;pi/2 ;0]';
 %p=[pi/2 3*pi/4 3*pi/4 -pi/4 pi/2 0;0 pi pi/2 0 3*pi/4 pi/2];
%   p=[pi/2  -pi/2 pi/2 -3*pi/4 pi/2 0];
%    p=[0  -pi/2 pi/2 -pi/2 3*pi/4 0];
% p=[0 0 -pi/4 -pi/4 3*pi/4 0];
%     p=[0  -pi/2 -pi/2 pi/2 3*pi/4 0];
%     p=[-pi  -3*pi/4 -pi/4 0 3*pi/4 0];
%     p=[0  -pi/4 pi/2 -3*pi/4  3*pi/4 0];
%     p=[0  -pi/4 pi/4 -2*pi/4  3*pi/4 0];
% p=[0  -pi/2 -pi/4 pi/4 3*pi/4 0];
%   p=[0 0 -pi/4 -pi/4 3*pi/4 0];
 
%  p=[0  -pi/4 pi/4 -pi/2 3*pi/4 0];
 %[0  -pi/4 pi/4 -pi/2 3*pi/4 0]',[0  -pi/4 -pi/4 0 3*pi/4 0]'
% p=p(2,:);
% p=[pi -3*pi/4 -pi/4 -pi/2 -pi/4 pi/2];
% p=[pi/2 -pi/2  pi/4 pi -pi/2 0];
% p=[pi/2 -pi/2  pi/2 3*pi/4 -pi/2 0];
% p(:,2)=p(:,2)-pi/2;
%read the joint angle data from 'angle.txt'
 %A matrix of 7 x 150.Each column vector recorded the changes of each joint Angle 
p(:,2)=p(:,2)+pi/2;
p(:,4)=p(:,4)+pi/2;
p(:,6)=p(:,6)+2*pi;
[m,n]=size(p);
for h=1:m
    for j=1:6
        while p(h,j)>pi||p(h,j)<-pi
            if p(h,j)>pi
                p(h,j)=p(h,j)-2*pi;
            else
                if p(h,j)<-pi
                    p(h,j)=p(h,j)+2*pi;
                end
            end
        end

    end
end
B=[];
%  p=[pi/2 -pi/2 pi/2 3*pi/4 -pi/2 0];
%  p=[pi/2 -3*pi/4 pi/2 pi -pi/2 0];
jointValue=p;
if (clientID>-1)
disp('Connected to remote API server');
[res,handle_leftArmjoint1] = vrep.simxGetObjectHandle(clientID,'UR5_joint1',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint2] = vrep.simxGetObjectHandle(clientID,'UR5_joint2',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint3] = vrep.simxGetObjectHandle(clientID,'UR5_joint3',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint4] = vrep.simxGetObjectHandle(clientID,'UR5_joint4',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint5] = vrep.simxGetObjectHandle(clientID,'UR5_joint5',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint6] = vrep.simxGetObjectHandle(clientID,'UR5_joint6',vrep.simx_opmode_oneshot_wait); 
[res,handle_shape4] = vrep.simxGetCollisionHandle(clientID,'Collision', vrep. simx_opmode_oneshot_wait); 
%  [res,handle_Cylinder2] = vrep.simxGetObjectHandle(clientID,'Shape4',vrep.simx_opmode_oneshot_wait); 

%  while(vrep.simxGetConnectionId(clientID) ~= -1)
 c=0;  
for i=1:m
vrep.simxPauseCommunication(clientID,1); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint1,jointValue(i,1),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint2,jointValue(i,2),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint3,jointValue(i,3),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint4,jointValue(i,4),vrep.simx_opmode_oneshot);
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint5,jointValue(i,5),vrep.simx_opmode_oneshot);
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint6,jointValue(i,6),vrep.simx_opmode_oneshot);
vrep.simxPauseCommunication(clientID,0);
vrep.simxPauseCommunication(clientID,1); 
[~,p1]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint1,vrep.simx_opmode_oneshot);
[~,p2]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint2,vrep.simx_opmode_oneshot);
[~,p3]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint3,vrep.simx_opmode_oneshot);
[~,p4]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint4,vrep.simx_opmode_oneshot);
[~,p5]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint5,vrep.simx_opmode_oneshot);
[~,p6]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint6,vrep.simx_opmode_oneshot);
vrep.simxPauseCommunication(clientID,0);
[a,b]=vrep.simxReadCollision(clientID,handle_shape4,vrep. simx_opmode_blocking);
while (abs(p1-p(i,1))>0.001||abs(p2-p(i,2))>0.001||abs(p3-p(i,3))>0.01||abs(p4-p(i,4))>0.01||abs(p5-p(i,5))>0.01||abs(p6-p(i,6))>0.01)
   pause(0.008);
   c=c+1;
  vrep.simxPauseCommunication(clientID,1); 
[~,p1]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint1,vrep.simx_opmode_oneshot);
[~,p2]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint2,vrep.simx_opmode_oneshot);
[~,p3]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint3,vrep.simx_opmode_oneshot);
[~,p4]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint4,vrep.simx_opmode_oneshot);
[~,p5]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint5,vrep.simx_opmode_oneshot);
[~,p6]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint6,vrep.simx_opmode_oneshot);
vrep.simxPauseCommunication(clientID,0);
end



pause(0.001);

end
   vrep.simxAddStatusbarMessage(clientID,'Hello V-REP!',vrep.simx_opmode_oneshot);

%  end

% Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
vrep.simxGetPingTime(clientID);
% Now close the connection to V-REP:
vrep.simxFinish(clientID);
else
disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!
disp('Program ended');
end