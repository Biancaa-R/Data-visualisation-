clear all; 
close all;
clc;


N = 20000;
mu = 0.001;
W0 = [0.1; 0.3; 0.5];
L = length(W0);







for m = 1:100

    noise = randn(1, N + L - 1);

snr_db = 30;
np = 10^(-snr_db / 10);
sp = 1;
input = sqrt(sp) * randn(1, N + L - 1);
noise = sqrt(np) * noise;

    x = zeros(L, 1);
    w = zeros(L, 1);
    for n = 1:N 
        x(2:L ,1) = x(1:L-1,1);
        x(1) = input(n);
        d = W0.' * x;
        y = w.' * x + noise(n);
        e(n) = d - y;
        MSE(n) = e(n)^2;
        w = w + mu * x * e(n);
    end
    MSE1(:,m)=MSE;
end

for i =1:N
    MSE2(i)=mean(MSE1(i,:));
end
    
figure;
mse_db = 10 * log10(MSE2);
plot(mse_db);
title('MSE in dB');
xlabel('Iteration');
ylabel('MSE (dB)');


