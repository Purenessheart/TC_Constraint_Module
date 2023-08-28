function d=dist(p1,p2)
    while p1<0||p1>2*pi
        if p1<0
            p1=p1+2*pi;
        else
            p1=p1-2*pi;
        end
    end
        while p2<0||p2>2*pi
        if p2<0
            p2=p2+2*pi;
        else
            p2=p2-2*pi;
        end
        end
d1=abs(p2-p1);
d2=abs(2*pi-p2+p1);
d3=abs(2*pi-p1+p2);
d4=min(d1,d2);
d=min(d4,d3);
