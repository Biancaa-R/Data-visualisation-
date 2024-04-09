clc;
clear all;
close all;

x = [1, 1, 2, 2];
h = [1, 2, 3, 4];

N = length(x);
y = zeros(1, N);

for m = 1:N
    for n = 1:N
        index = mod(m - n, N) + 1;
        y(m) = y(m) + x(n) * h(index);
    end
end

disp(y); % Display the circular convolution result
