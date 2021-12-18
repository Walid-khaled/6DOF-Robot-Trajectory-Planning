function [qP,vP,aP] = Polynomial(q0,qf,v0,vf,t0,tf)
t = linspace(t0,tf, double(3E3));
%t = linspace(t0,tf,100*(tf-t0));
c = ones(size(t));

M = [1 t0 t0^2 t0^3;
     0  1 2*t0 3*t0^2;
     1 tf tf^2 tf^3;
     0  1 2*tf 3*tf^2];

b = [q0;v0;qf;vf];
a = inv(M)*b;

qP = a(1).*c + a(2).*t +a(3).*t.^2 + a(4).*t.^3; %qP = reference position trajectory
vP = a(2).*c +2*a(3).*t +3*a(4).*t.^2; %vP = reference velocity trajectory
aP = 2*a(3).*c + 6*a(4).*t; %aP = reference acceleration trajectory

fprintf('q(t)= %0.4ft^3 + %0.4ft^2 + %0.4ft + %0.4f\n',a(4),a(3),a(2),a(1))
fprintf('v(t)= %0.4ft^2 + %0.4ft + %0.4f\n',3*a(4),2*a(3),a(2))
fprintf('a(t)= %0.4ft^3 + %0.4ft^2\n',6*a(4),2*a(3))
end