clc;
clear all;
close all;

% Input sequence
xn = input("Enter the sequence: ");
n = length(xn);

% Compute the next power of 2
p = nextpow2(n);

% Zero-padding to the next power of 2 length
xn_zeros = [xn, zeros(1, power(2, p) - n)];

% Perform the DIT-FFT
Xk = dit_fft(xn_zeros);

% Display the FFT result
disp(Xk.');

% Plot the magnitude of the FFT result
figure;
stem(abs(Xk), 'filled');
title('Magnitude of FFT');
xlabel('n');
ylabel('Amplitude');

% Plot the frequency response using freqz
figure;
freqz(Xk);
title('Frequency Response of FFT');
xlabel('Frequency (normalized)');
ylabel('Magnitude');

% DIT-FFT function definition
function X = dit_fft(x)
    N = length(x);
    if N == 1
        X = x;
    else
        x_even = dit_fft(x(1:2:end));
        x_odd = dit_fft(x(2:2:end));
        W = exp(-2i * pi / N) .^ (0:(N/2 - 1));
        X = [x_even + W .* x_odd, x_even - W .* x_odd];
    end
end
