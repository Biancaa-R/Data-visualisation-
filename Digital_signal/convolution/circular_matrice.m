clc;
clear all;
close all;

x = [1, 1, 2, 2];
h = [1, 2, 3, 4];

N = length(x);
y = zeros(1, N);

for n = 1:N
    for m = 1:N
        y(n) = y(n) + x(m) * h(mod(n-m, N)+1);
    end
end

disp('Circular Convolution Result:');
disp(y);
stem(y);

%for n = 0:N-1
%    for m = 0:N-1
%        y(n+1) = y(n+1) + x(m+1) * h(mod(n-m, N)+1);
%    end
%end