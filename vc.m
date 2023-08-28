function c=vc(p1,p2)
c=zeros(6,1);
for i=1:6
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
%     if p2(i)>p1(i)
%         a=p2(i)-p1(i);
%         b=2*pi-p2(i)+p1(i);
%     else
%         a=p1(i)-p2(i);
%         b=2*pi-p1(i)+p2(i);
%     end
        a=p2(i)-p1(i);
        b=2*pi-p2(i)+p1(i);
        d=2*pi-p1(i)+p2(i);
        h=min([abs(a) abs(b) abs(d)]);
    if h==abs(b)
        c(i)=b;
    else
        if h==abs(a)
        c(i)=a;
        else
          c(i)=d ;
        end
    end
%     return c;
    
end