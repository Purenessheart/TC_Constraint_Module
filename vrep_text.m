function b=vrep_text(p)
global vrep;
global clientID;
global handle_leftArmjoint1;
global handle_leftArmjoint2;
global handle_leftArmjoint3;
global handle_leftArmjoint4;
global handle_leftArmjoint5;
global handle_leftArmjoint6;
global handle_Collision;

p(2)=p(2)+pi/2;
p(4)=p(4)+pi/2;
    for j=1:6
        while p(j)>pi||p(j)<-pi
            if p(j)>pi
                p(j)=p(j)-2*pi;
            else
                if p(j)<-pi
                    p(j)=p(j)+2*pi;
                end
            end
        end

    end

if (clientID>-1)
 vrep.simxPauseCommunication(clientID,1);
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint1,p(1),vrep.simx_opmode_oneshot ); 
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint2,p(2),vrep.simx_opmode_oneshot ); 
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint3,p(3),vrep.simx_opmode_oneshot ); 
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint4,p(4),vrep.simx_opmode_oneshot );
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint5,p(5),vrep.simx_opmode_oneshot );
 vrep.simxSetJointTargetPosition(clientID,handle_leftArmjoint6,p(6),vrep.simx_opmode_oneshot );
 vrep.simxPauseCommunication(clientID,0); 

 
%  end

vrep.simxPauseCommunication(clientID,1); 
[~,p1]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint1,vrep.simx_opmode_oneshot);
[~,p2]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint2,vrep.simx_opmode_oneshot);
[~,p3]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint3,vrep.simx_opmode_oneshot);
[~,p4]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint4,vrep.simx_opmode_oneshot);
[~,p5]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint5,vrep.simx_opmode_oneshot);
[~,p6]=vrep.simxGetJointPosition(clientID,handle_leftArmjoint6,vrep.simx_opmode_oneshot);
vrep.simxPauseCommunication(clientID,0);
c=0;
while (abs(p1-p(1))>0.001||abs(p2-p(2))>0.001||abs(p3-p(3))>0.01||abs(p4-p(4))>0.01||abs(p5-p(5))>0.01||abs(p6-p(6))>0.01)
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


[a,b]=vrep.simxReadCollision(clientID,handle_Collision,vrep.simx_opmode_streaming );

% Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):

else
disp('Failed connecting to remote API server');
vrep.delete(); % call the destructor!
disp('Program ended');
end

