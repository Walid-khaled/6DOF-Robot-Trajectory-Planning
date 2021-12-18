function [tb,T,tf,q,v,a] = TrajectoryTimePlanning(J)
%%%%%%%%%%%%%%%%%%%%% How many calls for the function? %%%%%%%%%%%%%%%%%%%
%Persistent variables are local to the function in which they are declared, 
%yet their values are retained in memory between calls to the function. 
persistent  counter 
if isempty(counter)
    counter=0; %Initializing counter
end
if counter < 6
    counter = counter+1;
elseif counter >= 6
    counter = 1; %Reset counter if number of calls reaches 6
end
fprintf(strcat('J',string(counter),':','\t'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q0 = J(1);
qf = J(2);
dq_m = J(3);
ddq_m = J(4);

dq = qf-q0;
t0 = 0;

%triangular-trapezoidal check 
c = sqrt(dq*ddq_m); 
if c <= dq_m
  fprintf('Triangular Profile>> ')
  tb = dq/dq_m; %t1 = sqrt(dq/ddq_m)
  T = tb;
  tf = 2*tb;
else
  fprintf('Trapezoidal Profile>> ')
  tb = dq_m/ddq_m;
  T = dq/dq_m;
  tf = T+tb ;
end 

fprintf('rise time: %0.3f, dwell time: %0.3f, drop time: %0.3f, total time: %0.3f\n', tb, T-tb, tf-T, tf)

t = linspace(t0,tf, double(3E3));

q = [];
v = [];
a = [];

for i = t
  if i <= tb
    qi = q0 + (0.5*ddq_m*(i-t0)^2);
    q02 = qi;
    vi = ddq_m*i;
    v02 = vi; 
    ai = ddq_m;
    
  elseif i > tb && i <= T 
    vi = dq_m;
    qi =  q02 + v02*(i-tb);
    ai = 0;
    
  elseif i > T 
    vi = ddq_m*(tf-i);
    qi = qf - (0.5*ddq_m*(i-tf)^2);
    ai = -ddq_m;
  end
  q=[q,qi];
  v=[v,vi]; 
  a=[a,ai];
end
end
