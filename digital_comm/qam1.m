clc;
clear;
close all;

% Input bit sequence (4 bits for QAM)
n = 4;  % Number of bits

seq = zeros(1, n);
for i = 1:n
    seq(i) = input("Enter bit (0 or 1): ");
end

inp = [seq(1), seq(2)];  % In-phase bits
quad = [seq(3), seq(4)]; % Quadrature bits

% Level conversion for the in-phase component (first two bits)
inp_level = 0;
if inp(1) == 0
    if inp(2) == 0
        inp_level = -3;
    elseif inp(2) == 1
        inp_level = 3;
    end
elseif inp(1) == 1
    if inp(2) == 0
        inp_level = -1;
    elseif inp(2) == 1
        inp_level = 1;
    end
end

% Level conversion for the quadrature component (last two bits)
quad_level = 0;
if quad(1) == 0
    if quad(2) == 0
        quad_level = -3;
    elseif quad(2) == 1
        quad_level = 3;
    end
elseif quad(1) == 1
    if quad(2) == 0
        quad_level = -1;
    elseif quad(2) == 1
        quad_level = 1;
    end
end

% Parameters
bit_duration = 1; 
sampling_rate = 100;    
fc = 10;  % Carrier frequency

t_qam = 0:1/sampling_rate:n;  % Time for the QAM signal

% Generate QAM signal (In-phase and Quadrature components)
in_phase_signal = inp_level * cos(2 * pi * fc * t_qam);
quad_phase_signal = quad_level * sin(2 * pi * fc * t_qam);
combined_signal = in_phase_signal + quad_phase_signal;

% Plot the QAM signals
figure;
subplot(3,2,[1,2])
plot(t_qam, combined_signal, 'LineWidth', 1, 'Color', 'b');
xlabel("Time");
ylabel("Amplitude");
title("QAM Modulated Signal");
axis([0 4 -4 4]);
grid on;

subplot(3,2,3);
plot(t_qam, in_phase_signal);
xlabel("Time");
ylabel("Amplitude");
title("In-phase Component");
axis([0 4 -4 4]);
grid on;

subplot(3,2,4);
plot(t_qam, quad_phase_signal);
xlabel("Time");
ylabel("Amplitude");
title("Quadrature Component");
axis([0 4 -4 4]);
grid on;

subplot(3,2,[5,6]);
plot(t_qam, combined_signal);
xlabel("Time");
ylabel("Amplitude");
title("Combined QAM Signal");
axis([0 4 -4 4]);
grid on;

% Detection
detected_bits = zeros(1, n);
in_phase_received = combined_signal .* cos(2 * pi * fc * t_qam);
quad_phase_received = combined_signal .* sin(2 * pi * fc * t_qam);

% Integration over the entire period
in_phase_integrated = trapz(t_qam, in_phase_received);
quad_phase_integrated = trapz(t_qam, quad_phase_received);

% Print integrals for debugging
disp('In-phase Integrated Value:');
disp(in_phase_integrated);
disp('Quadrature Integrated Value:');
disp(quad_phase_integrated);

% Detect In-phase bits (bits 1 and 2)
if in_phase_integrated >= 2
    detected_bits(1:2) = [1, 0];  % Correct detection for higher in-phase levels
elseif in_phase_integrated > 0
    detected_bits(1:2) = [1, 1];  % This corresponds to mid-range in-phase levels
elseif in_phase_integrated > -2  % Handle values close to -2 more robustly
    detected_bits(1:2) = [0, 1];  % Slightly adjust the threshold
else
    detected_bits(1:2) = [0, 0];  % Detect lower in-phase levels
end

% Detect Quadrature bits (bits 3 and 4)
if quad_phase_integrated >= 2
    detected_bits(3:4) = [1, 0];  % Higher quadrature level detection
elseif quad_phase_integrated > 0
    detected_bits(3:4) = [1, 1];  % Mid-range quadrature levels
elseif quad_phase_integrated > -2
    detected_bits(3:4) = [0, 1];  % Adjust this threshold slightly as well
else
    detected_bits(3:4) = [0, 0];  % Lower quadrature levels
end


% Display detected bits
disp('Detected bit sequence: ');
disp(detected_bits);
