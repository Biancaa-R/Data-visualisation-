n = input('Enter the number of bits: ');

seq = zeros(1, n);

% Input the bits sequence
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

% BPSK parameters
bit_duration = 1; 
sampling_rate = 100;    
T = 1;                
f = 1/T;              
A = 1;                 


t_digital = 0:1/sampling_rate:n*bit_duration;


digital_signal = zeros(size(t_digital));
for i = 1:n
    start_idx = (i-1)*sampling_rate*bit_duration + 1;
    end_idx = i*sampling_rate*bit_duration;
    digital_signal(start_idx:end_idx) = seq(i);
end


figure;
subplot(2,1,1); % First plot (digital signal)
plot(t_digital, digital_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Digital Signal');
axis([0 n -0.5 1.5]);
grid on;

t_bpsk = 0:1/sampling_rate:n;

% BPSK signal
bpsk_signal = zeros(1, length(t_bpsk));
for i = 1:n
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate; 
    if seq(i) == 1
        bpsk_signal(t_idx) = A * cos(2*pi*f*t_bpsk(t_idx)); 
    else
        bpsk_signal(t_idx) = -(A * cos(2*pi*f*t_bpsk(t_idx))); 
    end
end

subplot(2,1,2); 
plot(t_bpsk, bpsk_signal,'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('BPSK Signal');
grid on;