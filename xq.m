function n=xq(s,i)
global tree2;
for j=1:i
    n=tree2(7,s);
    s=n;
    if n==0&&j~=i
        n=-1;
        break
    end        
end
end