% DPSK Modulation and Demodulation

% Input the number of bits
n = input('Enter the number of bits: ');

seq = zeros(1, n);

% Input the bits sequence (0 or 1)
for i = 1:n
    while true
        k = input('Enter the bit (0 or 1): ');
        if k == 0 || k == 1
            seq(i) = k;
            break;
        else
            disp('Enter correct bit (0 or 1)');
        end
    end
end

% Parameters for DPSK
bit_duration = 1;        % Duration of each bit (in seconds)
sampling_rate = 100;     % Number of samples per second
A = 1;                   % Amplitude of the carrier signal
fc = 100;                % Carrier frequency (Hz)

% Differential encoding (preparing for DPSK modulation)
encoded_bits = zeros(1, n);
encoded_bits(1) = seq(1);  % First bit remains the same
for i = 2:n
    % XOR current bit with the previous encoded bit
    encoded_bits(i) = xor(seq(i), encoded_bits(i-1));
end

% Time vector for the DPSK signal
t_dpsk = 0:1/sampling_rate:n - 1/sampling_rate;

% Generate the DPSK modulated signal
dpsk_signal = zeros(1, length(t_dpsk));
for i = 1:n
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate;
    if encoded_bits(i) == 1
        dpsk_signal(t_idx) = A * cos(2*pi*fc*t_dpsk(t_idx));  % No phase change for bit 1
    else
        dpsk_signal(t_idx) = A * cos(2*pi*fc*t_dpsk(t_idx) + pi);  % 180-degree phase change for bit 0
    end
end

% Plot DPSK modulated signal
figure;
subplot(2,1,1); 
plot(t_dpsk, dpsk_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('DPSK Modulated Signal');
grid on;

% DPSK Demodulation (detecting the phase changes)
demodulated_bits = zeros(1, n);
demodulated_bits(1) = encoded_bits(1);  % First bit remains the same
for i = 2:n
    if dpsk_signal((i-1)*sampling_rate + 1) == dpsk_signal((i-2)*sampling_rate + 1)
        demodulated_bits(i) = 1;  % No phase change, bit is 1
    else
        demodulated_bits(i) = 0;  % Phase change, bit is 0
    end
end

% Plot demodulated bits
t_digital = 0:1/sampling_rate:n*bit_duration - 1/sampling_rate;
digital_signal = zeros(size(t_digital));
for i = 1:n
    start_idx = (i-1)*sampling_rate*bit_duration + 1;
    end_idx = i*sampling_rate*bit_duration;
    digital_signal(start_idx:end_idx) = demodulated_bits(i);
end

subplot(2,1,2); 
plot(t_digital, digital_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Demodulated Signal');
axis([0 n -0.5 1.5]);
grid on;
