close all, clear all, clc

%% Constants

v0 = 25;
Ka = 1599;
tau_a = 0.5;
M = 1670;
B0 = 27.80;
g = 9.8;
Kp = 0.6;
Ki = 0.01;
Kd = 0.08;
theda = atan(5/100); %(rad of the slope)

%% Transfer Function

Cpi = tf([Kp, Ki], [1, 0]);
Cpi.InputName = 'e';
Cpi.OutputName = 'upi';

Cd = tf(Kd);
Cd.InputName = 'a';
Cd.OutputName = 'ud';

Controller = tf(Ka, [tau_a, 1]);
Controller.InputName = 'u';
Controller.OutputName = 'ft';

Mass = tf(1, M);
Mass.InputName = 'f';
Mass.OutputName = 'a';

Intergrator = tf(1, [1, 0]);
Intergrator.InputName = 'a';
Intergrator.OutputName = 'v';

B0 = tf(B0);
B0.InputName = 'v';
B0.OutputName = 'fb';

error = sumblk('e = v_r_e_f - v');
Up = sumblk('u = upi - ud');
Force = sumblk('f = fd + ft - fb');

%% System Connect

sys = connect(B0, Intergrator, Cd, Mass, Force, Controller, Up, error, Cpi, ...
    {'v_r_e_f', 'fd'}, {'v', 'u'})


%% Step V_ref Input

figure('Name', 'Vref2V')
vref2v = sys(1, 1);
step(vref2v, 6)

figure('Name', 'Vref2U')
vref2u = sys(2, 1);
step(vref2u, 6)

%% Step fd Input With Lsim

tspan = 0: 0.001: 5;
input = -M*g*sin(theda)*ones(1, length(tspan));
x0 = [0; 25; 0];

fd2v = sys(1, 2);
figure('Name', 'Fd2V, with I.C x0 = [0; 25; 0]')
% subplot(2, 1, 1)
% opts = stepDataOptions('StepAmplitude',-M*g*sin(theda));
% step(fd2v, 5, opts)
% subplot(2, 1, 2)
% lsim(fd2v, input, tspan, x0)
[x, t] = step(fd2v, 50);
plot(t, x*-M*g*sin(theda))


fd2u = sys(2, 2);
figure('Name', 'Fd2U, with I.C x0 = [0; 25; 0]')
% subplot(2, 1, 1)
% step(fd2u, 5, opts)
% subplot(2, 1, 2)
% lsim(fd2u, input, tspan, x0)
[x1, t1] = step(fd2u, 50);
plot(t1, x1*-M*g*sin(theda))



