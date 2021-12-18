function [q_num,v_num,a_num] = NumericalTrajectory(J,synctime,dt)
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
fprintf(strcat('J',string(counter),': Numerical>>','\t'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q0 = J(1);
qf = J(2);
dq_m = J(3);
ddq_m = J(4);

dq = qf-q0;
t0 = 0;

tb = synctime(1);
T = synctime(2);
tf = synctime(3);

tb_num = (floor(tb/dt)+1)*dt;
T_num = (floor(T/dt)+1)*dt;
tf_num = T_num+tb_num;
fprintf('rise time: %0.3f, dwell time: %0.3f, drop time: %0.3f, total time: %0.3f\n',...
    tb_num, T_num-tb_num, tf_num-T_num, tf_num)

t = linspace(t0,tf, double(3E3));

q_num = [];
v_num = [];
a_num = [];

for i = t
  if i <= tb_num
    qi = q0 + (0.5*ddq_m*(i-t0)^2);
    q02 = qi;
    vi = ddq_m*i;
    v02 = vi; 
    ai = ddq_m;
    
  elseif i > tb_num && i <= T_num
    vi = dq_m;
    qi =  q02 + v02*(i-tb_num);
    ai = 0;
    
  elseif i > T_num
    vi = ddq_m*(tf_num-i);
    qi = qf - (0.5*ddq_m*(i-tf_num)^2);
    ai = -ddq_m;
  end
  q_num=[q_num,qi];
  v_num=[v_num,vi]; 
  a_num=[a_num,ai];
end
end
