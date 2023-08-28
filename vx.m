function v=vx(q,qr)
v=vc(q,qr);
v=0.01*v/sqrt(v'*v);
v=Jacobi3(q)*v;


