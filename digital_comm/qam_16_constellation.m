clc;
clear all;
close all;
data=[0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0]; % information (20 bits)

% Reshape the data into groups of 4 bits for 16-QAM
data_reshaped = reshape(data, 4, [])';

% Define bit-to-symbol mapping for 16-QAM
bit2symbol = [
    -3+3j, -3+1j, -3-3j, -3-1j; % First quadrant
    -1+3j, -1+1j, -1-3j, -1-1j; % Second quadrant
     1+3j,  1+1j,  1-3j,  1-1j; % Third quadrant
     3+3j,  3+1j,  3-3j,  3-1j  % Fourth quadrant
];

% Map bits to symbols (16-QAM)
qam_symbols = zeros(1, length(data_reshaped));
for i = 1:length(data_reshaped)
    bits = data_reshaped(i, :);
    % Convert bits to decimal and use it as an index for the constellation
    row = bi2de(bits(1:2), 'left-msb') + 1; % First 2 bits for row selection
    col = bi2de(bits(3:4), 'left-msb') + 1; % Last 2 bits for column selection
    qam_symbols(i) = bit2symbol(row, col);
end

% Generate time vector
br = 10^6; % Transmission bit rate 1 Mbps
f = br; % Minimum carrier frequency
T = 1/br; % Bit duration
t = T/99:T/99:T; % Time vector for one bit information
y_in = [];

% QAM signal generation
for i = 1:length(qam_symbols)
    y2 = real(qam_symbols(i)) * cos(2*pi*f*t) - imag(qam_symbols(i)) * sin(2*pi*f*t);
    y_in = [y_in y2]; % Append to signal
end

tt = T/99:T/99:(T*length(qam_symbols)); % Time vector for the entire signal

% Plot the results
figure(1)
stem(data, 'linewidth', 3), grid on;
title('Information before Transmitting');
axis([0 length(data)+1 0 1.5]);

figure(2)
subplot(2,1,1);
plot(1:1:length(data), data, 'o', 'linewidth', 3), grid on;
title('Waveform for Information Bits in 16-QAM');
xlabel('Time (sec)');
ylabel('Amplitude (V)');

subplot(2,1,2);
plot(tt, y_in, 'linewidth', 3), grid on;
title('Waveform for 16-QAM Signal');
xlabel('Time (sec)');
ylabel('Amplitude (V)');

figure(3);
plot(real(qam_symbols), imag(qam_symbols), 'o', 'Color', 'b'); % Plot constellation without noise
axis([-4 4 -4 4]);
grid on;
xlabel('Real');
ylabel('Imaginary');
title('16-QAM Constellation');
