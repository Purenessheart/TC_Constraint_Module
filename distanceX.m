function d=distanceX(X,C)
d1=zeros(6,1);
for i=1:3
    if C(i)==100
        d1(i)=0;
    else
        d1(i)=C(i)-X(i);
    end
end
for i=4:6
    if C(i)==100
         d1(i)=0;
    else
       while X(i)<0||X(i)>2*pi
        if X(i)<0
            X(i)=X(i)+2*pi;
        else
            X(i)=X(i)-2*pi;
        end
       end
       while C(i)<0||C(i)>2*pi
        if C(i)<0
            C(i)=C(i)+2*pi;
        else
            C(i)=C(i)-2*pi;
        end
       end
        a=C(i)-X(i);
        b=2*pi-C(i)+X(i);
%         c=2*pi-X(i+C(i);
    if abs(a)<abs(b)
        d1(i)=a;
    else
        d1(i)=b;
    end
    end
    if d1(i)<-pi||d1(i)>pi
       if d1(i)<-pi
            d1(i)=d1(i)+2*pi;
        else
           d1(i)=d1(i)-2*pi;
        end
       end
end
d=d1;