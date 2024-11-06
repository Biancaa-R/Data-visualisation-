clc;
clear all;
close all;

% Step 1: Input and PN sequence generation
num = input("Enter the input number for PN sequence generation: ");
value = dec2bin(num);
n = length(value);
list1 = [];

% Define parameters
sampling_rate = 100; % Samples per bit
A = 1; % Amplitude of the carrier signal
f1 = 1; % Carrier frequency for BPSK in Hz

% Time vector for entire sequence, assuming each bit has its duration
t_bfsk = 0:1/sampling_rate:(2^n - 1);

% Initialize the output sequence with the last bit of the initial value
op = value(end);

% Convert binary string to a numeric array of 0s and 1s
current_sequence = double(value) - '0';

% Append initial sequence to list1
list1 = [list1; current_sequence];

% Determine the length of the desired PN sequence
len = 2^n - 1;

while size(list1, 1) < len
    num1 = randi([0, 1]);
    current_sequence = [num1, current_sequence(1:end-1)];

    % Check for uniqueness and presence of at least one '1'
    if any(current_sequence) && ~ismember(current_sequence, list1, 'rows')
        op = [op; current_sequence(end)]; % Append the last bit to output
        list1 = [list1; current_sequence]; % Append the unique sequence to list1
    end
end

disp('Generated PN Sequence:');
disp(list1);

% Step 2: Convert PN sequence to polar form
polar_PN_sequence =op;

% Step 3: Get additional polar input sequence
additional_num = input("Enter another binary input number for multiplication: ");
additional_value = dec2bin(additional_num, length(op));  % Ensure length matches PN sequence
additional_polar_sequence = 2 * (double(additional_value) - '0') - 1;  % Convert to polar

% Step 4: Multiply the polar sequences
combined_sequence = polar_PN_sequence .* additional_polar_sequence;

% Step 5: BPSK Modulation
bpsk_signal = zeros(1, length(t_bfsk));

for i = 1:length(combined_sequence)
    % Find the time indices for this bit
    t_idx = (i-1)*sampling_rate + 1:i*sampling_rate;
    
    % Generate BPSK modulated signal with 0 and 180 degree phase shift
    bpsk_signal(t_idx) = combined_sequence(i) * A * cos(2 * pi * f1 * t_bfsk(t_idx));
end

% Step 6: Plotting the BPSK signal
figure;
plot(t_bfsk, bpsk_signal);
title('BPSK Modulated Signal after Multiplying with Additional Polar Sequence');
xlabel('Time');
ylabel('Amplitude');
ylim([-2, 2]); % Set y-axis limits from -2 to +2
xlim([1 ,35]);
grid on;
