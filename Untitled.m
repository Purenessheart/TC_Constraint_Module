p0=1;
p1=0;
p2=2;
s=[];
n=[];
       for ii=1:40
           ii=ii-1;
           h=(1-ii/39)^2*p1+2/39*ii*(1-ii/39)*p0+(ii/39)^2*p2;
           s=[s h];
%            if ii<19
%                f=1-ii/19;
%            else
%                f=1.9*ii/19-1.9;
%            end
%            n=[n f];
       end
       plot(s)
       hold on
%        plot(n)