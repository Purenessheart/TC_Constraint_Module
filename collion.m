function c=collion(q)
global vrep;
global clientID;
global handle_Collision;
q=q/pi*180;
send(q);
[a,b]=vrep.simxReadCollision(clientID,handle_Collision,vrep. simx_opmode_blocking);
c=b;

