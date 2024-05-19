clc;
clear all;
close all;

% Define the numerator and denominator of the transfer function
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
mag_dB = 20*log10(squeeze(mag));

% Interpolate the magnitude at the desired gain crossover frequency
gcf_mag = interp1(wout, mag_dB, gcf_des);

% Calculate the required gain adjustment
required_gain_dB = -gcf_mag;  % To make magnitude 0 dB at 1.5 rad/s
k = 10^(required_gain_dB / 20);  % Convert the dB to a multiplicative factor

% Create the new transfer function with the adjusted gain
sys_tf_adjusted = tf(k * n, d);

% Plot the Bode plot of the adjusted system
figure;
bode(sys_tf_adjusted, w);
title('Bode Plot of the Adjusted System');
grid on;

% Calculate the new margins for the adjusted system
[gm_adj, pm_adj, gcf_adj, pcf_adj] = margin(sys_tf_adjusted);
disp('Adjusted system margins:');
disp(['Gain Margin (GM): ', num2str(gm_adj)]);
disp(['Phase Margin (PM): ', num2str(pm_adj), ' degrees']);
disp(['Gain Crossover Frequency (GCF): ', num2str(gcf_adj), ' rad/s']);
disp(['Phase Crossover Frequency (PCF): ', num2str(pcf_adj), ' rad/s']);

%Verify the new gain crossover frequency
[mag_adjusted, phase_adjusted, wout_adjusted] = bode(sys_tf_adjusted, w);
mag_adjusted_dB = 20*log10(squeeze(mag_adjusted));
gcf_adjusted = interp1(mag_adjusted_dB, wout_adjusted, 0);
disp(['Verified Gain Crossover Frequency: ', num2str(gcf_adjusted), ' rad/s']);
