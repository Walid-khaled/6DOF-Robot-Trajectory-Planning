q0 = 0; 
qf = 90;
dq_m = 8;
ddq_m = 4;

dq = qf-q0;
t0 = 0;

%triangular-trapezoidal check 
c = sqrt(dq*ddq_m); 
if c <= dq_m
  fprintf('Triangular Profile>>\t')
  tb = dq/dq_m; %t1 = sqrt(dq/ddq_m)
  T = tb;
  tf = 2*tb;
else
  fprintf('Trapezoidal Profile>>\t')
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

%figure(figsize=(16,16))
subplot(3,1,1)
plot(t,q,'LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('q(t) (%c)', char(176)), 'FontSize',12)
grid on 
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0 tf])
ylim([0,max(q)+10])
yline(max(q), 'r--', 'LineWidth', 1.5);
xline(tb, '--', 'LineWidth', 1.5);
xline(T, '--', 'LineWidth', 1.5);
legend({'q','qmax'},'Location','southeast')

subplot(3,1,2)
plot(t,v,'LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('v(t) (%c/s)', char(176)), 'FontSize',12)
grid on
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0,tf])
ylim([0,max(v)+1])
yline(dq_m, 'r--', 'LineWidth', 1.5);
xline(tb, '--', 'LineWidth', 1.5);
xline(T, '--', 'LineWidth', 1.5);
legend({'V','Vmax'},'Location','southeast')

subplot(3,1,3)
plot(t,a,'LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('a(t) (%c/s^2)', char(176)), 'FontSize',12)
grid on
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0,tf])
ylim([min(a)-1,max(a)+1])
xline(tb, '--', 'LineWidth', 1.5);
xline(T, '--', 'LineWidth', 1.5);
legend({'a'},'Location','southeast')