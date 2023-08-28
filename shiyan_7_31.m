s=[];
times=[];
for i=1:50
a=ctcRRTc([0 0 -pi/4 -pi/4 3*pi/4 0]',[0  -pi/4 -pi/4 0 3*pi/4 0]');
s=[s a.s];
times=[times a.t];
end
