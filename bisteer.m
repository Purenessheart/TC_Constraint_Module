function qs=bisteer(q1,q2,C)
vq=vc(q1,q2);
q=q1+0.01*vq/sqrt(vq'*vq);
X=position(q);
d=distanceX(X,C);
n=0;
while abs(d(1))> 1 ||abs(d(2))>1 ||abs(d(3))>1 ||abs(d(4))>0.1 ||abs(d(5))>0.1 ||abs(d(6))>0.1
    n=n+1;
    if n>20
        q=100*ones(6,1);
        break
    end
    J=Jacobi3(q);
    v=J'*pinv(J*J')*d;
    q=q-0.001*v/sqrt(v'*v);
    X=position(q);
    d=distanceX(X,C);
end
    qs=[X,q];
end


