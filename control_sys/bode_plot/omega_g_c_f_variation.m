% Define the numerator and denominator of the transfer function\
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
mag_dB = 20*log10(squeeze(mag));
gcf1_mag = interp1(wout, mag_dB, gcf);
disp(gcf1_mag);
k_prime = power(10,gcf1_mag / 20);
disp(k_prime);
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

[mag, phase, wout] = bode(sys_tf_adjusted, w);
mag=squeeze(mag);
omega_des = interp1( mag, wout,1);
disp(omega_des)

%{
The gain crossover frequency (GCF) is determined primarily by the system's open-loop transfer function. When you adjust the gain of the system, you are essentially modifying the magnitude response of the system. However, changing the gain does not directly affect the location of the gain crossover frequency; it only alters the gain magnitude at that frequency.

In your code, the gain adjustment was made to achieve a desired gain magnitude at a specific frequency (1.5 rad/s), but it did not directly shift the location of the gain crossover frequency. That's why even though you adjusted the gain to make the magnitude 0 dB at 1.5 rad/s, the actual GCF remained unchanged.

So, despite the gain adjustment, the gain crossover frequency remained the same as in the original system because the structure of the transfer function (the poles and zeros) did not change.

If you need to change the location of the gain crossover frequency, you would typically need to modify the system's dynamics by adding poles or zeros or adjusting their locations. Simply adjusting the gain won't shift the crossover frequency.

%}





