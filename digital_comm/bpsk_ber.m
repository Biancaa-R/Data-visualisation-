clc;
clear all;
close all;
SNRdB= -20:1:12;
SNR= 10.^(SNRdB/10);
N=10^5;
x= randsrc(1,N, [0,1]);
X_BPSK= 1- 2*x;
n= randn(1,N);
for k=1:length(SNR)
    y=(sqrt(SNR(k)) *X_BPSK)+n;
    noisy_bits=y.*X_BPSK;
    indices_corrupted= find((noisy_bits)<0);
    Num_of_corrupted(k)= length(find(indices_corrupted));
end
ber= Num_of_corrupted/N;
figure;
practical=semilogy(SNRdB, ber, 'b*-','LineWidth',1);
hold on;
theoretical=qfunc(sqrt(SNR));
theo=semilogy(SNRdB,theoretical,'r+-','linewidth',1);
xlabel('SNR in dB');
ylabel('Bit error rate BER');
hold off;
grid on;
datacursormode on;
