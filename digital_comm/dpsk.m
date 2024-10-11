clc;
clear;
close all;
n = input('Enter the number of bits: ');

seq = zeros(1, n);

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

bit_duration = 1; 
sampling_rate = 100;    
T = 1;                
f = 1/T;              
A = 1;                 

t_dpsk = 0:1/sampling_rate:n*bit_duration;
bpsk_signal = zeros(1, length(t_dpsk));
t_digital = 0:1/sampling_rate:n*bit_duration;
previous_phase = 0;
for i = 1:n
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate;
    if seq(i) == 0
        
        previous_phase = previous_phase + pi;
    end
    bpsk_signal(t_idx) = A * cos(2*pi*f*t_dpsk(t_idx) + previous_phase);
end

figure;
subplot(2,1,1);
plot(t_dpsk, bpsk_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('DPSK Signal');
grid on;

subplot(2,1,2);
for i = 1:n
    start_idx = (i-1)*sampling_rate*bit_duration+1 ;
    end_idx = i*sampling_rate*bit_duration+1;
    digital_signal(start_idx:end_idx) = seq(i);
end
plot(t_digital,digital_signal,LineWidth=1);
xlabel('time');
ylabel('Amplitude');
title('DPSK Message signal');
grid on;


% DPSK Detection
detected_bits = zeros(1, n);
previous_phase = 0;

for i = 1:n
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate;
    in_phase = bpsk_signal(t_idx) .* cos(2*pi*f*t_dpsk(t_idx) + previous_phase);
    in_phase_integrated = trapz(t_dpsk(t_idx), in_phase);
    
    if in_phase_integrated < 0
        detected_bits(i) = 0;
        previous_phase = previous_phase + pi;
    else
        detected_bits(i) = 1;
    end
end

disp('Detected bit sequence: ');
disp(detected_bits);


decoded_signal = zeros(1, length(t_dpsk));
for i = 1:n
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate;
    decoded_signal(t_idx) = detected_bits(i);
end

figure;
subplot(2,1,1);
noise=randn(1,length(t_dpsk));
noise=noise/100;
bpsk_signal=bpsk_signal+noise;
plot(t_dpsk,bpsk_signal,'LineStyle','-','Color','b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Recieved DPSK Signal');
grid on;

subplot(2,1,2);
plot(t_dpsk, decoded_signal, 'LineWidth', 1, 'Color', 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Decoded DPSK Signal');
grid on;
