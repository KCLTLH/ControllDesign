% AA/EE/ME 581
% HW 5 SP Demo
% Simulink simulation of car speed control system with
%  analog controller
% M.C. Berg
% Version: 19Apr2016

disp(' ')
disp('******************')
disp('** HW 5 SP Demo **')
disp('******************')

flag=inptdf('\nEnter 1 to clear all variables and close all figure windows [1]',1);
if flag
  clear all
  close all
end

% Define plant parameters
M=1670;          % Mass of vehicle
B=0.5559;        % Nonlinear aerodynamic drag coefficient
Ka=1599;         % Actuator gain constant
taua=0.5;        % Actuator time constant
v0=25;           % Operating point velocity in m/sec
gravity=9.806;   % Gravity constant in m/sec^2

% Set analog controller gains
Kp=0.6;     % Proportional control gain
Ki=0.01;    % Integral control gain
Kd=0.08;    % Derivative control gain

vref=inptdf('\nEnter constant value for vref (typically 25 or 27) (m/sec)');
vreftxt=sprintf('v_{ref}(t)=%2.0f m/sec',vref);

grade=inptdf('\nEnter percent of uphill grade (typically 0 or 5)')/100;
fd=-M*gravity*sin(atan(grade)); % gravity force that pushes car forward

gradetxt=sprintf('%2.0f percent uphill grade',100*grade);
titletxt=['Response to '  vreftxt  ' and '  gradetxt];

tfinal=inptdf('\nEnter final time for simulations (typically 8 or 200) (sec)');

T=inptdf('\nEnter sampling time (sec)');



% Simulation with Discrete controller
sim_dis_out=sim('Discrete','Solver','ode45','RelTol','1.e-5', ...
           'StopTime','tfinal', ...
           'SaveTime','on','TimeSaveName','timeoutNew', ...
           'SaveOutput','on','OutputSaveName','youtNew');
time_dis=sim_dis_out.get('timeoutNew');
y_dis=sim_dis_out.get('youtNew');

figure
hold on
plot([0 time_dis(length(time_dis))],[vref vref],'k--')
plot(time_dis,y_dis(:,1),'r-')
xlabel('t (sec)')
ylabel('v (m/sec)')
title(titletxt)
legend('v_{dis}')

figure
hold on
plot(time_dis,y_dis(:,2),'r-')
xlabel('t (sec)')
ylabel('uwiggle(t) (dimensionless)')
title(titletxt)

figure
hold on
plot(time_dis,y_dis(:,3),'b--',time_dis,y_dis(:,4),'r-')
limits=axis;
axis([limits(1)  limits(2)  0  limits(4)]);
xlabel('t (sec)')
ylabel('u_{limited}(t) and u(t) (dimensionless)')
title(titletxt)
legend('u_{dis}', 'u_{limited}')