function j=pinghua(s1,s2)
global tree2;
if s1'*s1==0||s2'*s2==0
    j=1;
else
    s=s1-s2;
    h=sqrt(s'*s);
    if abs(h)<0.001
        j=1;
    else
        j=0;
    end
    j=0;
end
end