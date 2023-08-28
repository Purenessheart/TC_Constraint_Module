function p=ord(q1,q2)
 p=zeros(6,1);
 p(1:3)=q2(1:3)-q1(1:3);
 if sqrt(p(1)^2+p(2)^2+p(3)^2)>10^(-4)
     p(1:3)=p(1:3)/sqrt(p(1)^2+p(2)^2+p(3)^2);
 else
     p(1:3)=[0;0;0];
 end
for i=4:6
    while q1(i)<0||q1(i)>2*pi
        if q1(i)<0
            q1(i)=q1(i)+2*pi;
        else
            q1(i)=q1(i)-2*pi;
        end
    end
    while q2(i)<0||q2(i)>2*pi
        if q2(i)<0
            q2(i)=q2(i)+2*pi;
        else
            q2(i)=q2(i)-2*pi;
        end
    end
    a=q2(i)-q1(i);
    if q2(i)>q1(i)
   b=-2*pi-q1(i)+q2(i);
    else
   b=2*pi+q2(i)-q1(i);
    end
    if abs(a)<abs(b)
        p(i)=a;
    else
        p(i)=b;
    end
end

if sqrt(p(4)^2+p(5)^2+p(6)^2)>10^(-4)
    p(4:6)=p(4:6)/sqrt(p(4)^2+p(5)^2+p(6)^2);

else
    p(4:6)=[0;0;0];
end
end