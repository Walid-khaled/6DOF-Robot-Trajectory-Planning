clear all
clc
%%%%%%%%%%%%%%% Task1: Calculate and plot q, v, a trajectories %%%%%%%%%%%%
fprintf('Task1\n')
fprintf('...Calculation of q, v, a Trajectories...\n')
%J = [q0,qf,dq_m, ddq_m]

J1 = [0,90,8,4];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J1);
[tb1,T1,tf1,q1,v1,a1] = deal(tb,T,tf,q,v,a);

J2 = [0,60,4,2];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J2);
[tb2,T2,tf2,q2,v2,a2] = deal(tb,T,tf,q,v,a);

J3 = [0,45,6,3];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J3);
[tb3,T3,tf3,q3,v3,a3] = deal(tb,T,tf,q,v,a);

J4 = [20,60,10,5];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J4);
[tb4,T4,tf4,q4,v4,a4] = deal(tb,T,tf,q,v,a);

J5 = [-10,10,4,2];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J5);
[tb5,T5,tf5,q5,v5,a5] = deal(tb,T,tf,q,v,a);

J6 = [30,70,9,4.5];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J6);
[tb6,T6,tf6,q6,v6,a6] = deal(tb,T,tf,q,v,a);

t0 = 0;
tf_max =max([tf1,tf2,tf3,tf4,tf5,tf6]);

figure(1)
n = 0;
for j=1:6
    n = n+1;
    subplot(6,3,n)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('q',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('q',string(j),'(t)','(',char(176),')'),'FontSize',12)
    grid on 
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([0,max(eval(strcat('q',string(j))))+10])
    yline(max(eval(strcat('q',string(j)))), 'r--', 'LineWidth', 1.5);
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('q',string(j)),strcat('q',string(j),'max')},'Location','southeast')

    n = n+1;
    subplot(6,3,n)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('v',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('v',string(j),'(t)','(',char(176),'/s)'),'FontSize',12)
    grid on
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([0,max(eval(strcat('v',string(j))))+1])
    yline(eval(strcat('J',string(j),'(',string(3),')')), 'r--', 'LineWidth', 1.5);
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('V',string(j)),strcat('V',string(j),'max')},'Location','southeast')

    n = n+1;
    subplot(6,3,n)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('a',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('a',string(j),'(t)','(',char(176),'/s^2)'),'FontSize',12)
    grid on
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([min(eval(strcat('a',string(j))))-1,max(eval(strcat('a',string(j))))+1])
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('a',string(j))},'Location','southeast')
end
suptitle('q, v, a Trajectories for Robot Joints')

%%%%%%%%%%%%%%%%%%%%%%%%%% Task2: synchronization %%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nTask2\n')
fprintf('...Synchronization...\n')
tb = max([tb1,tb2,tb3,tb4,tb5,tb6]);
dwell = max([T1-tb1,T2-tb2,T3-tb3,T4-tb4,T5-tb5,T6-tb6]);
T = tb+dwell;
tf = T+tb;
fprintf('Synchronized Trajectory Time>> rise time: %0.3f, dwell time: %0.3f, drop time: %0.3f,total time: %0.3f\n',...
    tb, dwell, tf-T, tf)

dq_m = [];
ddq_m = [];
for s = 1:6
    %recalculate velocity parameters    
    dq_m(s) = eval(strcat('(J',string(s),'(2)-J',string(s),'(1))/',string(T))); %dq_m=(J(2)-J(1))/T
    
    %recalculate acceleration parameters
    ddq_m(s) = eval(strcat('dq_m(',string(s),')/',string(tb))); %ddq_m=dq_m/tb;

    fprintf('Joint%d velocity modified from %0.f to %0.4f and acceleration modified from %0.f to %0.4f\n',...
    s, eval(strcat('J',string(s),'(3)')), dq_m(s), eval(strcat('J',string(s),'(4)')), ddq_m(s))

    %update parameters 
    %J(3:4)=[dq_m(s), ddq_m(s)];
    eval(strcat('J',string(s),'(3:4)=[dq_m(',string(s),'),ddq_m(',string(s),')];'))  
end

fprintf('\nAfter Calculating New Trajectory:\n')
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J1);
[tb1,T1,tf1,q1,v1,a1] = deal(tb,T,tf,q,v,a);

[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J2);
[tb2,T2,tf2,q2,v2,a2] = deal(tb,T,tf,q,v,a);

[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J3);
[tb3,T3,tf3,q3,v3,a3] = deal(tb,T,tf,q,v,a);

[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J4);
[tb4,T4,tf4,q4,v4,a4] = deal(tb,T,tf,q,v,a);

[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J5);
[tb5,T5,tf5,q5,v5,a5] = deal(tb,T,tf,q,v,a);

[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J6);
[tb6,T6,tf6,q6,v6,a6] = deal(tb,T,tf,q,v,a);

tf_max =max([tf1,tf2,tf3,tf4,tf5,tf6]);

q_max = max([max(q1),max(q2),max(q3),max(q4),max(q5),max(q6)]);
v_max = max([max(v1),max(v2),max(v3),max(v4),max(v5),max(v6)]);
a_max = max([max(a1),max(a2),max(a3),max(a4),max(a5),max(a6)]);

figure(2)
m = 0;
for j=1:6
    m = m+1;
    subplot(6,3,m)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('q',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('q',string(j),'(t)','(',char(176),')'),'FontSize',12)
    grid on 
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([0,q_max+10])
    yline(max(eval(strcat('q',string(j)))), 'r--', 'LineWidth', 1.5);
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('q',string(j)),strcat('q',string(j),'max')},'Location','southeast')

    m = m+1;
    subplot(6,3,m)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('v',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('v',string(j),'(t)','(',char(176),'/s)'),'FontSize',12)
    grid on
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([0,v_max+1])
    yline(eval(strcat('J',string(j),'(',string(3),')')), 'r--', 'LineWidth', 1.5);
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('V',string(j)),strcat('V',string(j),'max')},'Location','southeast')

    m = m+1;
    subplot(6,3,m)
    plot(linspace(t0,eval(strcat('tf',string(j))), double(3E3)), eval(strcat('a',string(j))), 'LineWidth',1.5)
    xlabel(strcat('t',string(j),'(s)'), 'FontSize',12)
    ylabel(strcat('a',string(j),'(t)','(',char(176),'/s^2)'),'FontSize',12)
    grid on
    ax = gca; %returns the current axes (or standalone visualization) in the current figure.
    ax.GridColor = [0 0 0];
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.5; %grid transparency
    ax.Layer = 'bottom';
    xlim([0,tf_max])
    ylim([-a_max-1,a_max+1])
    xline(eval(strcat('tb',string(j))), '--', 'LineWidth', 1.5);
    xline(eval(strcat('T',string(j))), '--', 'LineWidth', 1.5);
    legend({strcat('a',string(j))},'Location','southeast')
end
suptitle('Synchronization')

%%%%%%%%% Task3: numerical control for synchronized trajectories %%%%%%%%%%
fprintf('\nTask3\n')
fprintf('...Numerical Control for Synchronized Trajectories...\n')
f = 5; %controller frequency 5 Hz
dt = 1/f;
synctime = [tb,T,tf];

[q_num,v_num,a_num] = NumericalTrajectory(J1,synctime,dt);
[q1_num,v1_num,a1_num] = deal(q_num,v_num,a_num);

[q_num,v_num,a_num] = NumericalTrajectory(J2,synctime,dt);
[q2_num,v2_num,a2_num] = deal(q_num,v_num,a_num);

[q_num,v_num,a_num] = NumericalTrajectory(J3,synctime,dt);
[q3_num,v3_num,a3_num] = deal(q_num,v_num,a_num);

[q_num,v_num,a_num] = NumericalTrajectory(J4,synctime,dt);
[q4_num,v4_num,a4_num] = deal(q_num,v_num,a_num);

[q_num,v_num,a_num] = NumericalTrajectory(J5,synctime,dt);
[q5_num,v5_num,a5_num] = deal(q_num,v_num,a_num);

[q_num,v_num,a_num] = NumericalTrajectory(J6,synctime,dt);
[q6_num,v6_num,a6_num] = deal(q_num,v_num,a_num);

%calculate angles error
fprintf('\nCalculating Angles Error:\n')
for k = 1:6
    %error = J(2)-q_num(end);
    error = eval(strcat('J',string(k),'(2)-q',string(k),'_num(end);'));
    fprintf('error in q%d = %0.4f as q%d = %0.4f and q%d_num = %0.4f\n',...
        k, error, k, eval(strcat('J',string(k),'(2)')), k, eval(strcat('q',string(k),'_num(end)')))
end

%%%%%%%% Task4: Propagated error in end-effector position using FK %%%%%%%%
fprintf('\nTask4\n')
fprintf('...Propagated Error in End-effector Position using FK...\n')

Q = [J1(2)-J1(1), J2(2)-J2(1), J3(2)-J3(1), J4(2)-J4(1), J5(2)-J5(1), J6(2)-J6(1)];
[X,Y,Z] = FK(Q);
[X1,Y1,Z1] = deal(X,Y,Z);

Q_num = [q1_num(end)-q1_num(1), q2_num(end)-q2_num(1), q3_num(end)-q3_num(1),...
    q4_num(end)-q4_num(1), q5_num(end)-q5_num(1), q6_num(end)-q6_num(1)];
[X,Y,Z] = FK(Q_num);
[X2,Y2,Z2] = deal(X,Y,Z);

fprintf('X = %0.4f, X_num = %0.4f\nY = %0.4f, Y_num = %0.4f\nZ = %0.4f, Z_num = %0.4f\n',X1,X2,Y1,Y2,Z1,Z2)
fprintf('X_err = %0.4f, Y_err = %0.4f, Z_err = %0.4f\n',X1-X2, Y1-Y2, Z1-Z2)
fprintf('error magnitude = %0.4f\n',sqrt((X1)^2+(Y1)^2+(Z1)^2) - sqrt((X2)^2+(Y2)^2+(Z2)^2))

%%%%%%%%%%%%%%%%%%%%%%% Task5: polynomial solution %%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nTask5\n')
fprintf('...Polynomial Solution...\n')

%Just calculted for one Joint as an example

%step 1: from point 1 to point2
J11 = [0,45,8,4];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J11);
[tb11,T11,tf11,q11,v11,a11] = deal(tb,T,tf,q,v,a);
fprintf('from point 1 to point 2\n')
[qP,vP,aP] = Polynomial(J11(1),J11(2),v11(1),v11(end),tb11,tf11);
[qP11,vP11,aP11] = deal(qP,vP,aP);

%step 2: from point 2 to point 3
J12 = [45,90,6,3];
[tb,T,tf,q,v,a] = TrajectoryTimePlanning(J12);
[tb12,T12,tf12,q12,v12,a12] = deal(tb,T,tf,q,v,a);
fprintf('from point 2 to point 3\n')
[qP,vP,aP] = Polynomial(J12(1),J12(2),v12(1),v12(end),tb12,tf12);
[qP12,vP12,aP12] = deal(qP,vP,aP);

%%%%%%%%%%%%%%%%%%%%%%% Task6: trajectory junction %%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nTask6\n')
fprintf('...Trajectory Junction...\n')

%Just calculted for one Joint as an example

v = cat(2,v11,v12);
t = cat(2,linspace(0,tf11,double(3E3)),linspace(tf11,tf11+tf12,double(3E3)));
figure(3)
subplot(3,1,1)
plot(t,v,'b','LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('v(t) (%c/s)', char(176)), 'FontSize',12)
grid on
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0,tf11+tf12])
ylim([0,max([v11,v12])+1])
yline(J11(3), 'r--', 'LineWidth', 1.5);
yline(J12(3), 'r--', 'LineWidth', 1.5);
xline(tb11, 'g--', 'LineWidth', 1.5);
xline(T11, 'g--', 'LineWidth', 1.5);
xline(tf11, 'k--', 'LineWidth', 1.5);
xline(tf11+tb12, 'g--', 'LineWidth', 1.5);
xline(tf11+T12, 'g--', 'LineWidth', 1.5);
xline(tf11+tf12, 'k--', 'LineWidth', 1.5);
legend({'V','Vmax'},'Location','southeast')

v = cat(2,v11,v12);
t = cat(2,linspace(0,tf11,double(3E3)),linspace(T11,T11+tf12,double(3E3)));
subplot(3,1,2)
plot(t,v,'b','LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('v(t) (%c/s)', char(176)), 'FontSize',12)
grid on
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0,tf11+tf12])
ylim([0,max([v11,v12])+1])
yline(J11(3), 'r--', 'LineWidth', 1.5);
yline(J12(3), 'r--', 'LineWidth', 1.5);
xline(tb11, 'g--', 'LineWidth', 1.5);
xline(T11, 'g--', 'LineWidth', 1.5);
xline(tf11, 'k--', 'LineWidth', 1.5);
%xline(T11+tb12, 'g--', 'LineWidth', 1.5);
xline(T11+T12, 'g--', 'LineWidth', 1.5);
xline(T11+tf12, 'k--', 'LineWidth', 1.5);
legend({'V','Vmax'},'Location','southeast')
suptitle('Trajectory Junction')

v11 = v11(1:2662);
v12 = v12(361:end);
v = cat(2,v11,v12);
t = cat(2,linspace(0,6.7678,double(2.662E3)),linspace(6.7678,T11+tf12,double(2.64E3)));
subplot(3,1,3)
plot(t,v,'b','LineWidth',1.5)
xlabel('t(s)', 'FontSize',12)
ylabel(sprintf('v(t) (%c/s)', char(176)), 'FontSize',12)
grid on
ax = gca; %returns the current axes (or standalone visualization) in the current figure.
ax.GridColor = [0 0 0];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.5; %grid transparency
ax.Layer = 'bottom';
xlim([0,tf11+tf12])
ylim([0,max([v11,v12])+1])
yline(J11(3), 'r--', 'LineWidth', 1.5);
yline(J12(3), 'r--', 'LineWidth', 1.5);
xline(tb11, 'g--', 'LineWidth', 1.5);
xline(T11, 'g--', 'LineWidth', 1.5);
xline(tf11, 'k--', 'LineWidth', 1.5);
%xline(T11+tb12, 'g--', 'LineWidth', 1.5);
xline(T11+T12, 'g--', 'LineWidth', 1.5);
xline(T11+tf12, 'k--', 'LineWidth', 1.5);
legend({'V','Vmax'},'Location','southeast')
suptitle('Trajectory Junction Steps')

fprintf('Program End\n')
