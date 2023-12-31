close all
clear all
clc

k = 44.567; % Spring Constant (N/m)
mass = 0.01; %block mass (kg)
Ts = 0.1; % Sampling Time (sec)

%% Set up constant for spring mass stste-space
G_s = tf([1/mass], [1, 0, k/mass]);
plantdis = c2d(G_s, Ts);

%% Plot RL-plot of the plant

figure()
rlocus(plantdis)
grid on, hold on
plot_constant_lines_z(0.2, 5, Ts);
xlim([-1, 1])
ylim([-1, 1])
title('G(Z) Rlocus plot')
hold off

X_inter = 0.7959;
Y_inter = 0.4286;

%% Plant origin Poles & Zeros

Z = zero(plantdis);
P = [0.924+1i*0.3831, 0.924-1i*0.3831];

rad_transfer = 180/pi;

z1 = [- Z + X_inter , 1i*(Y_inter)];
theta1 = angle(z1(1) + z1(2))*rad_transfer;

p1 = [X_inter - real(P(1)) , 1i*(Y_inter - imag(P(1)))];
theta2 = -(angle(p1(1) + p1(2))*rad_transfer);

p2 = [X_inter - real(P(2)) , 1i*(Y_inter - imag(P(2)))];
theta3 = -(angle(p2(1) + p2(2))*rad_transfer);

sum_is = sum([theta1, theta2, theta3]);

disp('Find the lead total angle:')
total_angle = (-180 -sum_is);
disp(num2str(total_angle))

%% Start design

L_p = [0, 0]; % set zero = 0
l_p = L_p(1);

p3 = [L_p(1) + X_inter , 1i*(Y_inter)];
theta4 = -(angle(p3(1) + p3(2))*rad_transfer);

% Require theda_z
design_theda_z = total_angle - theta4;

L_z = -((1/tan(design_theda_z*pi/180))*Y_inter - X_inter);
l_z = L_z;
z2 = [X_inter - L_z, 1i*Y_inter + 1i*0];

%% Compute Magnitude

dz1 = distance(z1(1), z1(2));
dz2 = distance(z2(1),  z2(2));

dp1 = distance(p1(1), p1(2));
dp2 = distance(p2(1), p2(2));
dp3 = distance(p3(1), p3(2));

Gain = prod([dp1, dp2, dp3])/prod([dz1, dz2])/0.001708;

%% Set up C(z)

C_z = tf(Gain*[1, -L_z], [1,0], Ts);

% Connect it

all4one_tf = C_z * plantdis;


figure()
rlocus(all4one_tf)
grid on, hold on
plot_constant_lines_z(0.2, 5, Ts);
xlim([-1, 1])
ylim([-1, 1])
title('all4one_tf Rlocus plot')
hold off

pp = inptdf('\nEnter 1 to close all plot[1]',1);

if pp
    close all
end
%% CLTF

pp_cltf = inptdf('\nEnter 1 to check CLTF pz-map[1]',1);

if pp_cltf
    CLTF = feedback(all4one_tf, 1);
    figure()
    pzmap(CLTF)
    grid on, hold on
    plot_constant_lines_z(0.2, 5, Ts);
    xlim([-1, 1])
    ylim([-1, 1])
    title('all4one-tf Rlocus plot')
    hold off
end


%% for t = 256:250:length(time)

sim_step = inptdf('\nEnter 1 for Simulink simulation[1]',1);

if sim_step

    tfinal=inptdf('\nEnter final time for Simulink simulation (sec) [10]',10);
    maxstep=tfinal/10000;  % max step size for the Simulink simulation

    simout1=sim('HW_7_1','Solver','ode45','RelTol','1.e-5', ...
        'MaxStep','maxstep','StopTime','tfinal',...
        'SaveTime','on','TimeSaveName','tout', ...
        'SaveOutput','on','OutputSaveName','yout');

    time=simout1.get('tout');
    y=simout1.get('yout');

    figure('Name', 'Simulation for all 4 one')

    subplot(2, 1, 1)
    plot(time, y)
    grid on, hold on
    plot(time, 1.02*ones(size(time)), 'r--')
    plot(time, 0.98*ones(size(time)), 'r--')
    plot(time, max(y)*ones(size(time)), 'g--')
    hold off
    legend('System Step responce', 'Bounded Line', 'Bounded Line', 'Max Value Line')
    title('Step response of system continus time')

    subplot(2, 1, 2)
    title('Step response of system discrete time with Ts = 0.1sec')

    y_saving = ones([tfinal/Ts, 1]);
    time_saving = ones([tfinal/Ts, 1]);
    count = 1;

    for t = 107:100:length(time)
        y_saving(count)= y(t);
        time_saving(count) = time(t);
        count = count + 1;
    end

    plot(time_saving, y_saving, 'o')
    grid on, hold on
    plot(time, 1.02*ones(size(time)), 'r--')
    plot(time, 0.98*ones(size(time)), 'r--')
    plot(time, max(y_saving)*ones(size(time)), 'g--')
    plot(time, 1.52662*ones(size(time)), '--')
    legend('System Step responce', 'Bounded Line', 'Bounded Line', 'Max Value Line', 'Predict OS%')
    hold off

    title('Step response of system discontinus time')
end

%% 1 sec

sim_step = inptdf('\nEnter 1 for Simulink simulation[1]',1);

if sim_step

    tfinal=inptdf('\nEnter final time for Simulink simulation (sec) [4]',4);
    maxstep=tfinal/10000;  % max step size for the Simulink simulation

    simout1=sim('HW_7_1','Solver','ode45','RelTol','1.e-5', ...
        'MaxStep','maxstep','StopTime','tfinal',...
        'SaveTime','on','TimeSaveName','tout', ...
        'SaveOutput','on','OutputSaveName','yout');

    time=simout1.get('tout');
    y=simout1.get('yout');

    figure('Name', 'Simulation for all 4 one')

    subplot(2, 1, 1)
    plot(time, y)
    grid on, hold on
    plot(time, 1.02*ones(size(time)), 'r--')
    plot(time, 0.98*ones(size(time)), 'r--')
    plot(time, max(y)*ones(size(time)), 'g--')
    hold off
    legend('System Step responce', 'Bounded Line', 'Bounded Line', 'Max Value Line')
    xlim([0, 1])
    title('Step response of system continus time')

    subplot(2, 1, 2)
    title('Step response of system discrete time with Ts = 0.1sec')

    y_saving = ones([4/Ts, 1]);
    count = 1;

    for t = 256:250:length(time)
        
        y_saving(count)= y(t);
        plot(time(t), y(t), 'o', 'Color', 'blue')
        hold on, grid on
        dis_time = [time(t)];
        dis_y = [y(t)];
        count = count + 1;

    end

    plot(time, 1.02*ones(size(time)), 'r--')
    plot(time, 0.98*ones(size(time)), 'r--')
    plot(time, max(y_saving)*ones(size(time)), 'g--')
    xlim([0, 1])
    hold off

    title('Step response of system discontinus time')
end