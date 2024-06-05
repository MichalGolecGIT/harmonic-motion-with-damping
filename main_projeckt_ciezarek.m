function result=main_projeckt_ciezarek(m,b,k,f,Tmax)
% dane testowe
% m=5;
% b=1;
% k=1;
% f=10;
% Tmax=500;

 
 F=@(t)sin(2*pi*f*t);
 
 
 dx=@(t,x)[x(2);...
     (F(t)-k*x(1)-b*x(2))/m];
 
 x0=[0;0];
 T=[0,Tmax];
 
 [t,x]=ode45(dx,T,x0);
 plot(t,x(:,1));
 result = [t,x];