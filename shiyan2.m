% load('shuju11.mat')
% load('shuju12.mat')
% load('shuju13.mat')
% load('shuju14.mat')

success11=0;
success12=0;
success13=0;
success14=0;

success21=0;
success22=0;
success23=0;
success24=0;


for j=1:100
 success11= success11+shuju11(2,j);
 success12= success12+shuju12(2,j);
 success13= success13+shuju13(2,j);
 success14= success14+shuju14(2,j);
    
 success21= success21+shuju21(2,j);
 success22= success22+shuju22(2,j);
 success23= success23+shuju23(2,j);
 success24= success24+shuju24(2,j);
end

t11=0;
t12=0;
t13=0;
t14=0;

t21=0;
t22=0;
t23=0;
t24=0;


for h=1:100
 t11= t11+shuju11(1,h);
 t12= t12+shuju12(1,h);
 t13= t13+shuju13(1,h);
 t14= t14+shuju14(1,h);
    
 t21= t21+shuju21(1,h);
 t22= t22+shuju22(1,h);
 t23= t23+shuju23(1,h);
 t24= t24+shuju24(1,h); 
end
t1=[t11 t12 t13 t14]';
t2=[t21 t22 t23 t24]';
t=[t1/100 t2/100];

success1=[success11 success12 success13 success14]';
success2=[success21 success22 success23 success24]';
su=[success1 success2];