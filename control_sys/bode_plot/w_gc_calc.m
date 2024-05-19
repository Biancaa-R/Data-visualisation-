% Define the numerator and denominator of the transfer function
clc;
clear all;
close all;
n = [1];
d = [0.1 1.1 1 0];

% Define the frequency range for the Bode plot
a = -2;
b = 2;
w = logspace(a, b);

% Create the transfer function
sys_tf = tf(n, d);

% Plot the Bode plot of the original system
figure;
bode(sys_tf, w);
title('Bode Plot of the Original System');
grid on;

% Calculate the gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
[gm, pm, gcf, pcf] = margin(sys_tf);
disp('Original system margins:');
disp(['Gain Margin (GM): ', num2str(gm)]);
disp(['Phase Margin (PM): ', num2str(pm), ' degrees']);
disp(['Gain Crossover Frequency (GCF): ', num2str(gcf), ' rad/s']);
disp(['Phase Crossover Frequency (PCF): ', num2str(pcf), ' rad/s']);

% Desired gain crossover frequency
gcf_des = 1.5;

% Obtain the magnitude and phase at the desired frequency
[mag, phase, wout] = bode(sys_tf, w);
mag = squeeze(mag);    % Convert magnitude to linear scale and remove singleton dimensions
phase = squeeze(phase); % Remove singleton dimensions

% Find the magnitude at the desired gain crossover frequency
mag_des = interp1(wout, mag, gcf_des);

% Calculate the required gain adjustment
k = 1 / mag_des;  % To make magnitude 1 (0 dB) at the desired gain crossover frequency

% Create the new transfer function with the adjusted gain
sys_tf_adjusted = tf(k * n, d);

% Plot the Bode plot of the adjusted system
figure;
bode(sys_tf_adjusted, w);
title('Bode Plot of the Adjusted System');
grid on;
[mag, phase, wout] = bode(sys_tf_adjusted, w);
mag=squeeze(mag);
omega_des = interp1( mag, wout,1);
disp(omega_des);
