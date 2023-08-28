function s=v(n)
global tree2;
    if n>1
        s=tree2(1:6,n)-tree2(1:6,tree2(7,n));
        s=s/0.001;
    else
        s=zeros(6,1);
    end
end