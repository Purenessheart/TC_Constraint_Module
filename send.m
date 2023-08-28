function send(q)
global vrep;
global clientID;
global handle_leftArmjoint1;
global handle_leftArmjoint2;
global handle_leftArmjoint3;
global handle_leftArmjoint4;
global handle_leftArmjoint5;
global handle_leftArmjoint6;
vrep.simxPauseCommunication(clientID,1); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint1,q(1),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint2,q(2),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint3,q(3),vrep.simx_opmode_oneshot); 
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint4,q(4),vrep.simx_opmode_oneshot);
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint5,q(5),vrep.simx_opmode_oneshot);
vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint6,q(6),vrep.simx_opmode_oneshot);
vrep.simxPauseCommunication(clientID,0);
