clear all; 
close all;
clc;

f = 1000;
fsamp = 10000;
N = 2000;
mu = 0.1;
W0 = [0.1; 0.3; 0.5];
L = length(W0);
k = 0.001 * (0:N);
inp = sin(2 * pi * k / 200);
noise = 1.5 * randn(1, N + L - 1);

snr_db = 30;
np = 10^(-snr_db / 10);
sp = 1;
input = sqrt(sp) * randn(1, N + L - 1);
noise = sqrt(np) * noise;

x = zeros(L, 1);
w = zeros(L, 1);
e = zeros(1, N);
value = zeros(1, 10);

for m = 1:10
    for n = 1:N 
        x(2:L ,1) = x(1:L-1,1);
        x(1) = input(n);
        d = W0.' * x;
        y = w.' * x + noise(n);
        e(n) = d - y;
        MSE = e(n) * e(n);
        w = w + mu * x * e(n);
    end
    cross_corr = xcorr(w, W0, 'coeff');  % Compute normalized cross-correlation
    value(m) = max(cross_corr);
    mu = mu * 0.1;  % Decrease mu logarithmically
end

[~, mu_index] = max(value);
mu_opt = 0.1 / (10^(mu_index-1));
mu = mu_opt;

% Reinitialize variables for second run
w = zeros(L, 1);
e = zeros(1, N);
value = zeros(1, 8);

for m = 1:8
    for n = 1:N 
        x(2:L ,1) = x(1:L-1,1);
        x(1) = input(n);
        d = W0.' * x;
        y = w.' * x + noise(n);
        e(n) = d - y;
        MSE = e(n) * e(n);
        w = w + mu * x * e(n);
    end
    cross_corr = xcorr(w, W0, 'coeff');  % Compute normalized cross-correlation
    value(m) = max(cross_corr);
end

[~, mu_index] = max(value);
mu = mu_opt * mu_index;

% Final actual plot
w = zeros(L, 1);
e = zeros(1, N);
MSE = zeros(1, N);

for n = 1:N 
    x(2:L ,1) = x(1:L-1,1);
    x(1) = input(n);
    d = W0.' * x;
    y = w.' * x + noise(n);
    e(n) = d - y;
    MSE(n) = e(n)^2;
    w = w + mu * x * e(n);
end

mse_db = 10 * log10(MSE);
plot(mse_db);
title('MSE in dB');
xlabel('Iteration');
ylabel('MSE (dB)');

disp(['Optimal mu: ', num2str(mu)]);
