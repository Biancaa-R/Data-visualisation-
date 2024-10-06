%QUADRATURE PHASE SHIFT KEY

n = input('Enter the number of bits: ');

seq= zeros(1,n)
seq1 = zeros(1, (n/2))
seq2 = zeros(1,(n/2))

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
bit_duration_signal = 1; 
sampling_rate = 100;    
T = 1;                
f = 1/T;              
A = 1;                 


t_digital = 0:1/sampling_rate:n*bit_duration_signal;


digital_signal = zeros(size(t_digital));
for i = 1:n
    start_idx = (i-1)*sampling_rate*bit_duration_signal + 1;
    end_idx = i*sampling_rate*bit_duration_signal;
    digital_signal(start_idx:end_idx) = seq(i);
end

subplot(4,2,[1,2]); % First plot (digital signal)
plot(t_digital, digital_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Digital Signal');
axis([0 n -0.5 1.5]);
grid on;



for a = 1:(n/2)
    seq1(a)=seq(a+(a-1))
end

for a = 1:(n/2)
    seq2(a)=seq(a*2)
end

bit_duration= 2; 
sampling_rate = 100;    
T = 1;                
f = 1/T;              
A = 1;                 

t_digital = 0:1/sampling_rate:n*bit_duration;
digital_signal = zeros(size(t_digital));
for i = 1:(n/2)
    start_idx = (i-1)*sampling_rate*bit_duration + 1;
    end_idx = i*sampling_rate*bit_duration;
    digital_signal(start_idx:end_idx) = seq1(i);
end

subplot(4,2,3);
plot(t_digital, digital_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Inphase Component');
axis([0 n -0.5 1.5]);
grid on;
                


t_digital = 0:1/sampling_rate:n*bit_duration;

digital_signal = zeros(size(t_digital));
for i = 1:(n/2)
    start_idx = (i-1)*sampling_rate*bit_duration + 1;
    end_idx = i*sampling_rate*bit_duration;
    digital_signal(start_idx:end_idx) = seq2(i);
end

subplot(4,2,4);
plot(t_digital, digital_signal, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Quadrature Component');
axis([0 n -0.5 1.5]);
grid on;

t_qpsk = 0:1/sampling_rate:(n/2);

% BPSK signal
qpsk_signal = zeros(1, length(t_qpsk));
for i = 1:(n/2)
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate; 
    if seq1(i) == 1
        qpsk_signal(t_idx) = A * cos(2*pi*f*t_qpsk(t_idx)); 
    else
        qpsk_signal(t_idx) = -(A * cos(2*pi*f*t_qpsk(t_idx))); 
    end
end

subplot(4,2,5); 
plot(t_qpsk, qpsk_signal,'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Inphase');
grid on;

qpsk_quadsignal = zeros(1, length(t_qpsk));
for i = 1:(n/2)
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate; 
    if seq2(i) == 1
        qpsk_quadsignal(t_idx) = A * sin(2*pi*f*t_qpsk(t_idx)); 
    else
        qpsk_quadsignal(t_idx) = -(A * sin(2*pi*f*t_qpsk(t_idx))); 
    end
end

subplot(4,2,6); 
plot(t_qpsk, qpsk_quadsignal,'LineWidth', 2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Quadrature');
grid on;

combined=qpsk_signal+qpsk_quadsignal

subplot(4,2,[7,8])
plot(t_qpsk,combined,'Linewidth',2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Combined signal');
grid on;