close all, clear all, clc

%% Set up constant for spring mass stste-space

b = 0.062832;
mass = 0.01; %block mass (kg)
Ts = 0.1; % Sampling Time (sec)

A = [0, 1; 0, -b/mass];

B = [0; 1/mass];

C = [1 0];

D = 0;

plantcont = ss(A,B,C,D); % Create Plant in continus time
plantcont = tf(1, [mass, b, 0]);
plantdis = c2d(plantcont, Ts);
%% G(z)

rlocus(plantdis)
xlim([-1, 1])
ylim([-1, 1])
hold on, grid on
plot_constant_lines_z(0.2, 7.5, Ts);
hold off

K = 0.625;
tf_K = tf(K, 1, Ts);

KG_Z = tf_K*plantdis;
CLTF_KG_Z = feedback(KG_Z, 1);

%% C(z)

zero = 0.99;
pole = 0.999;
C_z = tf([1, -0.99], [1, -0.999], Ts);

%% C(Z)G(Z)

KCG_Z = K*C_z*plantdis;
rlocus(KCG_Z)
xlim([-1, 1])
ylim([-1, 1])
hold on, grid on
plot_constant_lines_z(0.2, 7.5, Ts);
hold off

%% CLTF_CGZ

CLTF_CGZ = feedback(KCG_Z, 1);
pzmap(CLTF_CGZ)
hold on, grid on
plot_constant_lines_z(0.2, 7.5, Ts);
hold off


%% STEP INPUT

[y1, t1] = step(CLTF_CGZ, 4);
plot(t1, y1, 'o', 'Color', 'blue')
grid on, hold on
[y2, t2] = step(CLTF_KG_Z, 4);
plot(t2, y2, 'o', 'Color', 'red')

legend('LAG', 'K Only')
hold off

%% RAMP INPUT

time = 40;

ramp= step(tf(Ts,[1 -1],Ts),time);
L_s = tf(1, [1, 0]);
mult = c2d(L_s, Ts);

[y1, t1] = step(mult*CLTF_CGZ, time);
plot(t1, ramp - y1, '*', 'Markersize', 3, 'Color', 'blue')
grid on, hold on
[y2, t2] = step(mult*CLTF_KG_Z, time);
plot(t2, ramp - y2, 'o', 'Markersize', 3,'Color', 'red')
legend('LAG - RAMP', 'K Only - RAMP')

Kv = 9.93165;
alpha = 10;
limits=axis;
h3=plot([limits(1)  limits(2)],[1  1]/Kv,'b:');
h4=plot([limits(1)  limits(2)],[1  1]/(alpha*Kv),'r:');

