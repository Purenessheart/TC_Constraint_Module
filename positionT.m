function p=positionT(T)

p1=T(1:3,4);


ry=atan2(-T(3,1),sqrt(T(3,2)^2+T(3,3)^2));
if ry==pi/2
    rz=0;
    rx=atan2(T(1,2),T(2,2));
else
    if ry==-pi/2
        rz=0;
        rx=-atan2(T(1,2),T(2,2));
    else
        rz=atan2(T(2,1),T(1,1));
        rx=atan2(T(3,2),T(3,3));
    end
end

p2=[rz;ry;rx];
p=[p1;p2];