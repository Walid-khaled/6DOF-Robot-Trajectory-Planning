function [X,Y,Z] = FK(Q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Forward Kinematics Input
q1=Q(1);
q2=Q(2);
q3=Q(3);
q4=Q(4);
q5=Q(5);
q6=Q(6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DH Parameters 
OFSET=[0 0 0 90 0 0];
ofst1=OFSET(1);
ofst2=OFSET(2);
ofst3=OFSET(3);
ofst4=OFSET(4);
ofst5=OFSET(5);
ofst6=OFSET(6);

D=[0.6 0 0 0.1 0 0.2];
d1=D(1);
d2=D(2);
d3=D(3)+q3;
d4=D(4);
d5=D(5);
d6=D(6);

A=[0.1 0.4 0 0 0 0];
a1=A(1);
a2=A(2);
a3=A(3);
a4=A(4);
a5=A(5);
a6=A(6);

ALPHA=[0 180 0 90 -90 0];
alp1=ALPHA(1);
alp2=ALPHA(2);
alp3=ALPHA(3);
alp4=ALPHA(4);
alp5=ALPHA(5);
alp6=ALPHA(6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Transformation matrix from 0 to 6 
%rotm2tform(rotm) converts the rotation matrix rotm, into a homogeneous transformation matrix
%trvec2tform(trvec) converts the translation vector to the corresponding homogeneous transformation
h1 = rotm2tform(rotz(q1))*rotm2tform(rotz(ofst1))*trvec2tform([0 0 d1])*trvec2tform([a1 0 0])*rotm2tform(rotx(alp1));
h2 = rotm2tform(rotz(q2))*rotm2tform(rotz(ofst2))*trvec2tform([0 0 d2])*trvec2tform([a2 0 0])*rotm2tform(rotx(alp2));
h3 = rotm2tform(rotz(q3))*rotm2tform(rotz(ofst3))*trvec2tform([0 0 d3])*trvec2tform([a3 0 0])*rotm2tform(rotx(alp3));
h4 = rotm2tform(rotz(q4))*rotm2tform(rotz(ofst4))*trvec2tform([0 0 d4])*trvec2tform([a4 0 0])*rotm2tform(rotx(alp4));
h5 = rotm2tform(rotz(q5))*rotm2tform(rotz(ofst5))*trvec2tform([0 0 d5])*trvec2tform([a5 0 0])*rotm2tform(rotx(alp5));
h6 = rotm2tform(rotz(q6))*rotm2tform(rotz(ofst6))*trvec2tform([0 0 d6])*trvec2tform([a6 0 0])*rotm2tform(rotx(alp6));
t = h1*h2*h3*h4*h5*h6;
X = t(1,4);
Y = t(2,4);
Z = t(3,4);
Rot_Matrix = t(1:3,1:3);
end


