clc;
close all;

% Define impulse response and input sequence
h = [1, 1, 1];
x = [3, -1, 0, 1, 3, 2, 0, 1, 2,1,6,7,4,3,6,8];

m = length(h);
n = 2^m;
l = n - m + 1;

% Extend h and x with zeros
h1 = [h, zeros(1, l - 1)];
x1 = [x, zeros(1, m)];
x11 = [zeros(1, m - 1), x1(1:l)];
x12 = [x1((l - m + 2):(2 * l))];

% Construct circular convolution matrix H
H = zeros(length(h1));
for i = 1:length(h1)
    for j = 1:length(h1)
        H(i, j) = h1(mod((i - j), length(h1)) + 1);
    end
end

% Perform circular convolution
y11 = (H * x11')';
y12 = (H * x12')';

% Extract valid output samples
y = [y11(m:n), y12(m:n)];

% Plot output
subplot(2, 1, 1);
stem(y, 'k');
xlabel('Samples');
ylabel('Amplitude');
title('Overlap-Save Output');

% Plot input
subplot(2, 1, 2);
stem(x, 'r');
xlabel('Samples');
ylabel('Amplitude');
title('Input Signal');
