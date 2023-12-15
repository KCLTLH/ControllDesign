close all, clear all, clc

%% 
v0 = 25;
Ka = 1599;
tau_a = 0.5;
M = 1670;
B0 = 27.80;
g = 9.8;
Kp = 0.6;
Ki = 0.01;
Kd = 0.08;
T = 2;

%%

Controller = tf(Ka, [tau_a, 1]);
Controller.InputName = 'u';
Controller.OutputName = 'ft';

Mass_Inter = tf(1, [M, 0]);
Mass_Inter.InputName = 'f';
Mass_Inter.OutputName = 'v';

B0 = tf(B0);
B0.InputName = 'v';
B0.OutputName = 'fb';

Force = sumblk('f = fd + ft - fb');

%% Continue_sys

Continue_sys = connect(Force, Controller, Mass_Inter, B0, {'fd', 'u'}, {'v'});

Dis_sys = c2d(Continue_sys, T, 'zoh');

%% Discrete Transfer Function

Cpi = tf([Kp+ Ki * T, -Kp], [1 , -1], T);
Cpi.InputName = 'error';
Cpi.OutputName = 'upi';

Cd = tf([Kd/T, -Kd/T], [1, 0], T);
Cd.InputName = 'v';
Cd.OutputName = 'ud';

Error = sumblk('error = vref - v');
Uplum = sumblk('u = upi - ud');

%% Connect the whole system

Discrete_All = connect(Dis_sys, Cpi, Cd, Error, Uplum, {'vref', 'fd'}, ...
    {'v', 'u'})

%% All Continous

Cpi_c = tf([Kp, Ki], [1, 0]);
Cpi_c.InputName = 'e_c';
Cpi_c.OutputName = 'upi_c';

Cd_c = tf(Kd);
Cd_c.InputName = 'a_c';
Cd_c.OutputName = 'ud_c';

Controller_c = tf(Ka, [tau_a, 1]);
Controller_c.InputName = 'u_c';
Controller_c.OutputName = 'ft_c';

Mass_c = tf(1, M);
Mass_c.InputName = 'f_c';
Mass_c.OutputName = 'a_c';

Intergrator_c = tf(1, [1, 0]);
Intergrator_c.InputName = 'a_c';
Intergrator_c.OutputName = 'v_c';

B0_c = tf(B0);
B0_c.InputName = 'v_c';
B0_c.OutputName = 'fb_c';

error_c = sumblk('e_c = v_ref_c - v_c');
Up_c = sumblk('u_c = upi_c - ud_c');
Force_c = sumblk('f_c = fd_c + ft_c - fb_c');

%% All Continous

sys_c = connect(B0_c, Intergrator_c, Cd_c, Mass_c, Force_c, Controller_c, ...
    Up_c, error_c, Cpi_c, {'v_ref_c', 'fd_c'}, {'v_c', 'u_c'});

%% For part(e)
figure('Name', 'Part E')
pzmap(Discrete_All(1, 1))
grid on, hold on

c_p = pole(sys_c(1,1));
c_z = zero(sys_c(1,1));

C2Z_p = exp(c_p * T);
C2Z_z = exp(c_z * T);

plot(real(C2Z_p), imag(C2Z_p), 'X' , 'Color', [1, 0.5, 0.5])
plot(real(C2Z_z), imag(C2Z_z), 'o', 'Color', [1, 0.5, 0.5])

%% For part(f)
figure('Name', 'Part F')
pzmap(Discrete_All(1, 2))
grid on, hold on

c_p = pole(sys_c(1,2));
c_z = zero(sys_c(1,2));

C2Z_p = exp(c_p * T);
C2Z_z = exp(c_z * T);

plot(real(C2Z_p), imag(C2Z_p), 'X' , 'Color', [1, 0.5, 0.5])
plot(real(C2Z_z), imag(C2Z_z), 'o', 'Color', [1, 0.5, 0.5])
%% C) Plot The Responce To Vref is step input

figure('Name', 'Input: Vref Output: v')
step(sys_c(1, 1))
hold on, grid on
step(Discrete_All(1, 1))
legend('Continous', 'Discrete')


%% D) Plot The Responce To Vref is step input

figure('Name', 'Input: Fd Output: v')

theda = atan(5/100);
Magnitude = -M*g*sin(theda);


step(Magnitude*sys_c(1, 2), 50)
hold on, grid on
step(Magnitude*Discrete_All(1, 2), 50)
legend('Continous', 'Discrete')
