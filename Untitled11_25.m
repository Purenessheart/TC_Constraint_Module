global vrep;
vrep.simxFinish(-1);
global clientID;
global handle_leftArmjoint1;
global handle_leftArmjoint2;
global handle_leftArmjoint3;
global handle_leftArmjoint4;
global handle_leftArmjoint5;
global handle_leftArmjoint6;
global handle_Collision;

vrep=remApi('remoteApi'); 
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID>-1)
   disp('Connected to remote API server');
[res,handle_leftArmjoint1] = vrep.simxGetObjectHandle(clientID,'UR10_joint1',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint2] = vrep.simxGetObjectHandle(clientID,'UR10_joint2',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint3] = vrep.simxGetObjectHandle(clientID,'UR10_joint3',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint4] = vrep.simxGetObjectHandle(clientID,'UR10_joint4',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint5] = vrep.simxGetObjectHandle(clientID,'UR10_joint5',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint6] = vrep.simxGetObjectHandle(clientID,'UR10_joint6',vrep.simx_opmode_oneshot_wait); 
[res,handle_Collision] = vrep.simxGetCollisionHandle(clientID,'Collision', vrep. simx_opmode_oneshot_wait); 

else
     disp('¡¨Ω” ß∞‹');
end

q_intial=[0;0;0;0;0;0];
q_goal=[1;1;1;1;1;1];
v=q_goal-q_intial;
q=q_intial;
path=[];
for i=1:10000
q=q+v/10000;
if collion(q)==0
  path=[path q];
  pause(100);
end
end