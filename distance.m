function x=distance(p1,p2)
c=p2(1:3)-p1(1:3);
c1=sqrt(c(1)^2+c(2)^2+c(3)^2);
p=zeros(1,3);
for i=1:3
    while p1(i)<0||p1(i)>2*pi
        if p1(i)<0
            p1(i)=p1(i)+2*pi;
        else
            p1(i)=p1(i)-2*pi;
        end
    end
    while p2(i)<0||p2(i)>2*pi
        if p2(i)<0
            p2(i)=p2(i)+2*pi;
        else
            p2(i)=p2(i)-2*pi;
        end
    end
    if p2(i)>p1(i)
        a=p2(i)-p1(i);
        b=2*pi-p2(i)+p1(i);
    else
        a=p1(i)-p2(i);
        b=2*pi-p1(i)+p2(i);
    end
    if a<b
        p(i)=a;
    else
        p(i)=b;
    end
end
c2=sqrt(p*p');
x=sqrt(c1^2+c2^2);
