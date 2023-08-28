function a=jiekou()
global vrep;
vrep=remApi('remoteApi'); 
vrep.simxFinish(-1);
global clientID;
global handle_leftArmjoint1;
global handle_leftArmjoint2;
global handle_leftArmjoint3;
global handle_leftArmjoint4;
global handle_leftArmjoint5;
global handle_leftArmjoint6;
global handle_Collision;
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID>-1)
disp('Connected to remote API server');
[res,handle_leftArmjoint1] = vrep.simxGetObjectHandle(clientID,'UR5_joint1',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint2] = vrep.simxGetObjectHandle(clientID,'UR5_joint2',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint3] = vrep.simxGetObjectHandle(clientID,'UR5_joint3',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint4] = vrep.simxGetObjectHandle(clientID,'UR5_joint4',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint5] = vrep.simxGetObjectHandle(clientID,'UR5_joint5',vrep.simx_opmode_oneshot_wait); 
[res,handle_leftArmjoint6] = vrep.simxGetObjectHandle(clientID,'UR5_joint6',vrep.simx_opmode_oneshot_wait); 
[res,handle_Collision] = vrep.simxGetCollisionHandle(clientID,'Collision', vrep. simx_opmode_oneshot_wait); 
a=clientID;
else
disp('Failed connecting to remote API server');
a=clientID;
vrep.delete(); 
disp('Program ended');
end