% Define the numerator and denominator of the transfer function
n = [1];
d = [0.1 1.1 1 0];

% Define the frequency range
a = -2;
b = 2;
w = logspace(a, b);

% Create the transfer function
sys_tf = tf(n, d);

% Plot the Bode plot
figure;
bode(sys_tf, w);
grid on;
title('Bode Plot of the System');

% Calculate the current gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
[gm, pm, gcf, pcf] = margin(sys_tf);
disp('Current system margins:');
disp(['Gain Margin (GM): ', num2str(gm)]);
disp(['Phase Margin (PM): ', num2str(pm)]);
disp(['Gain Crossover Frequency (GCF): ', num2str(gcf)]);
disp(['Phase Crossover Frequency (PCF): ', num2str(pcf)]);

% Desired phase margin in degrees
pm_des = 30;

% Calculate the phase value corresponding to the desired phase margin at the gain crossover frequency
gcf_phase_desired = -180 + pm_des;

% Extract the magnitude and phase response
[mag, phase, wout] = bode(sys_tf, w);
mag_dB = 20*log10(squeeze(mag)); % Convert magnitude to dB
phase_deg = squeeze(phase); % Extract phase response in degrees

% Interpolate to find the frequency corresponding to the desired phase value
gcf_new = interp1(phase_deg, wout, gcf_phase_desired);

% Display the calculated gain crossover frequency
disp(['Calculated Gain Crossover Frequency (GCF): ', num2str(gcf_new)]);

% Define the numerator and denominator of the transfer function
n = [1];
d = [0.1 1.1 1 0];

% Define the frequency range
a = -2;
b = 2;
w = logspace(a, b);

% Create the transfer function
sys_tf = tf(n, d);

% Plot the Bode plot
figure;
bode(sys_tf, w);
grid on;
title('Bode Plot of the System');

% Calculate the current gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
[gm, pm, gcf, pcf] = margin(sys_tf);
disp('Current system margins:');
disp(['Gain Margin (GM): ', num2str(gm)]);
disp(['Phase Margin (PM): ', num2str(pm)]);
disp(['Gain Crossover Frequency (GCF): ', num2str(gcf)]);
disp(['Phase Crossover Frequency (PCF): ', num2str(pcf)]);

% Desired phase margin in degrees
pm_des = 30;

% Calculate the phase value corresponding to the desired phase margin at the gain crossover frequency
gcf_phase_desired = -180 + pm_des;

% Extract the magnitude and phase response
[mag, phase, wout] = bode(sys_tf, w);
mag_dB = 20*log10(squeeze(mag)); % Convert magnitude to dB
phase_deg = squeeze(phase); % Extract phase response in degrees

% Interpolate to find the frequency corresponding to the desired phase value
gcf_new = interp1(phase_deg, wout, gcf_phase_desired);

% Display the calculated gain crossover frequency
disp(['Calculated Gain Crossover Frequency (GCF): ', num2str(gcf_new)]);


gcf_mag = interp1(wout, mag_dB, gcf_new );
disp(gcf_mag);

k = power(10, -gcf_mag/20);  % Convert the dB increase to a multiplicative factor

% Create the new transfer function with the adjusted gain
sys_tf_adjusted = tf(k * n, d);

% Plot the Bode plot of the adjusted system
figure;
bode(sys_tf_adjusted, w);
title('Bode Plot of the Adjusted System');
grid on;

% Calculate the new gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
[gm, pm, gcf, pcf] = margin(sys_tf_adjusted);
value = [gm, pm, gcf, pcf];
disp('Adjusted system margins:');
disp(value);
disp(pm);
