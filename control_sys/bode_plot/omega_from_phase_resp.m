% Define the numerator and denominator of the transfer function
n = [1 2];
d = [0.1 1.1 1 0];

% Create the transfer function
sys_tf = tf(n, d);

% Define the frequency range
a = -2;
b = 2;
w = logspace(a, b);

% Plot the Bode plot
figure;
bode(sys_tf, w);
title('Bode Plot of the Transfer Function');
grid on;

% Extract the phase response
[mag, phase, wout] = bode(sys_tf, w);

% Convert phase to degrees
phase_deg = squeeze(phase);

% Display the phase response for debugging purposes
disp('Phase Response (degrees):');
disp(phase_deg);

% Plot the phase response
figure;
semilogx(wout, phase_deg);
xlabel('Frequency (rad/s)');
ylabel('Phase (degrees)');
title('Phase Response');
grid on;

% Desired phase value (e.g., -150 degrees)
desired_phase = -150;

% Use linear interpolation to find the frequency corresponding to the desired phase
omega = interp1(phase_deg, wout, desired_phase);

% Display the interpolated frequency value
disp(['The frequency corresponding to ', num2str(desired_phase), ' degrees phase is: ', num2str(omega), ' rad/s']);
