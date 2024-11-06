% Parameters
f = 2;
t = 0:0.01:2;

% Generate a random signal
x = randn(size(t)); % Random signal

% Initialize parameters for Delta Modulation
a = 0.05;  % Reduced step size for delta modulation
y_DM = zeros(size(x));  % Output delta modulated signal
bitstream = zeros(1, length(x));  % Bitstream to store 0s and 1s
prev_x = 0;  % Initialize previous value for comparison
alternate_sign = a;  % To alternate between +a and -a when samples are equal

% Plotting
figure;
subplot(3,1,1);
x_orig = stem(t, x).YData; 
title('Random Input Signal');
xlabel('Time');
ylabel('Amplitude');

% Delta Modulation Loop
for i = 1:length(x)
    if i == 1
        value = 0;
    else 
        value = x_orig(i-1);
    end
    
    if x_orig(i) > value 
        y_DM(i) = +a;  % Increase by +a
        bitstream(i) = 1;  % Represent increasing step as 1
    elseif value > x_orig(i)
        y_DM(i) = -a;  % Decrease by -a
        bitstream(i) = 0;  % Represent decreasing step as 0
    else
        y_DM(i) = +alternate_sign;  % Alternate between +a and -a for equal values
        bitstream(i) = 1;  % Treat equal case as 1 (can be customized)
        alternate_sign = -alternate_sign;  % Toggle the sign
    end
end

% Create square pulses for bitstream using stairs
bitstream_square = repelem(bitstream, 10);  % Repeat each bit 10 times for square pulse effect
t_square = linspace(0, max(t), length(bitstream_square));  % Adjust time axis for the repeated points

% Plot Delta Modulated Signal
subplot(3,1,2);
stairs(t, y_DM); 
title('Delta Modulated Signal with Reduced Step Size (a = 0.05)');
xlabel('Time');
ylabel('Amplitude');

% Plot Square Pulse Bitstream
subplot(3,1,3);
stairs(t_square, bitstream_square, 'r', 'LineWidth', 1.5);  % Use stairs for square pulses
title('Delta Modulation Bitstream Output (Square Pulses)');
xlabel('Time');
ylabel('Bit Value (0 or 1)');
ylim([-0.2 1.2]);  % Keep bitstream in 0-1 range
grid on;

% Display the bitstream in the command window
disp('Bitstream output:');
disp(bitstream);
