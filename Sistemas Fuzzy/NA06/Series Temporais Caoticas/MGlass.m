% Daniel Leite - April 4, 2015
% Mackey-Glass equation - time series
%==========================================================================
clear all, close all, clc
 %Parameters
a = 0.2;
b = 0.1;
tau      = 17;      % Time delay
x0       = 1.2;     % Initial condition: x(t=0)=x0
deltat   = 0.1;     % Time step (which coincides with the integration step)
sample_n = 12000;   % Number of samples
interval = 1;       % Output is printed at every 'interval' time steps
time = 0;
index = 1;
history_length = floor(tau/deltat);
x_history = zeros(history_length, 1); %x(t)=0for-tau<=t<0 
x_t = x0;

X = zeros(sample_n+1, 1);   % Vector of all generated x samples
T = zeros(sample_n+1, 1);   % Vector of time samples
for i = 1:sample_n+1,
    X(i) = x_t;
    if (mod(i-1, interval) == 0),
         disp(sprintf('%4d %f', (i-1)/interval, x_t));
    end
    if tau == 0,
        x_t_minus_tau = 0.0;
else
        x_t_minus_tau = x_history(index);
end
    x_t_plus_deltat = mackeyglass_rk4(x_t, x_t_minus_tau, deltat, a, b);
    if (tau ~= 0),
        x_history(index) = x_t_plus_deltat;
        index = mod(index, history_length)+1;
end
    time = time + deltat;
    T(i) = time;
    x_t = x_t_plus_deltat;
end
Data = X; X = [];
% Time series: y1 = f(x1,x2,x3,x4)
Delta = 6; D = 3; Eps = 85;
for(i=19:size(Data,1)-Eps)
    X1(i-18,1) = Data(i-18);
    X2(i-18,1) = Data(i-12);
    X3(i-18,1) = Data(i-6);
    X4(i-18,1) = Data(i);
    Y1(i-18,1) = Data(i+85);
end
X = [X1 X2 X3 X4]; Y = [Y1];
%Plot
figure(1)
plot(Y1,'k')
xlabel('t');
ylabel('x(t)');
title(sprintf('Mackey-Glass time series'));
