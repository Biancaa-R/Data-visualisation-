% Parameters
fm = 5;              % Frequency of message signal (kHz) - adjust as needed
mmax = 10;           % Amplitude of message signal (V) - adjust as needed
step_size = 0.5;     % Step size for delta modulation - adjust as needed

% Derived parameters
fs = 32 * fm;        % Sampling frequency (higher than fm for delta modulation)
ns = 100;            % Number of samples
t1 = 0:(1/ns):1;     % Time vector for sampled data
t = 0:(1/fs):1;      % Time vector for message signal

% Generate message signal (cosine wave)
m = mmax * cos(2 * pi * fm * t);     % Continuous-time message signal
ms = mmax * cos(2 * pi * fm * t1);   % Sampled message signal

% Delta modulation process
N = length(ms);      % Length of sampled message signal
e = [0];             % Error signal initialization
mq = [0];            % Quantized signal initialization
for i = 2:N
    x = ms(i);
    if mq(i-1) > x
        mq = [mq mq(i-1) - step_size];
        e = [e 0];
    else
        mq = [mq mq(i-1) + step_size];
        e = [e 1];
    end
end

% Plot message and delta modulated signals
figure;
subplot(2,1,1);
hold on;
plot(t, m, 'b', 'DisplayName', 'Message Signal');  % Plot message signal
stairs(t1, mq, 'r', 'DisplayName', 'Delta Modulated Signal');  % Plot quantized signal
hold off;
title('Delta Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');
legend('show');
grid on;

% Time for binary pulses based on bits per second
bps = 1;                  % Bits per second
tb = 1 / (ns * bps);      % Time per bit
nb = bps * length(t1);    % Number of bits
tdm = 0:tb:tb*nb-tb;      % Time vector for binary pulse signal

% Plot binary pulse signal
subplot(2,1,2);
stairs(tdm, e, 'k');
title('Binary Pulse Signal (e)');
xlabel('Time (s)');
ylabel('Binary Pulse');
grid on;
