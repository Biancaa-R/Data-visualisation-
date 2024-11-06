clc;
clear all;
close all;

% Parameters
SNRdB = -20:1:12;       % SNR range in dB
SNR = 10.^(SNRdB/10);   % SNR in linear scale
N = 10^5;               % Number of symbols
M = 2;                  % Modulation order (e.g., M=8 for 8-PSK)

% Generate random data symbols from 0 to M-1
x = randi([0 M-1], 1, N);

% Map symbols to M-PSK constellation points
X_PSK = exp(1j * (2 * pi * x / M));

% Initialize BER array
Num_of_corrupted = zeros(1, length(SNR));

% Loop over each SNR value
for k = 1:length(SNR)
    % Add complex Gaussian noise scaled by SNR
    noise = (1/sqrt(2)) * (randn(1, N) + 1j * randn(1, N));  % Complex noise
    y = sqrt(SNR(k)) * X_PSK + noise;                        % Received signal
    
    % Demodulate received signal by finding the closest constellation point
    detected_symbols = mod(round(angle(y) * M / (2 * pi)), M);
    
    % Calculate the number of symbol errors
    Num_of_corrupted(k) = sum(detected_symbols ~= x);
end

% Calculate BER
ber = Num_of_corrupted / N;

% Plot results
figure;
practical = semilogy(SNRdB, ber, 'b*-', 'LineWidth', 1);
hold on;

% Theoretical BER for M-PSK (approximation)
theoretical = (2/M) * qfunc(sqrt(2 * SNR * sin(pi/M)^2));
theo = semilogy(SNRdB, theoretical, 'r+-', 'LineWidth', 1);

% Labels and grid
xlabel('SNR in dB');
ylabel('Bit error rate (BER)');
legend('Practical BER', 'Theoretical BER');
hold off;
grid on;
datacursormode on;
