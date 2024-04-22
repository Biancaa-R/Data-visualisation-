%que2
% Define s as a symbolic variable
syms s

% Define F as a symbolic function of s
F = 1 / (s^2 + 4);

% Calculate the inverse Laplace transform
f = ilaplace(F);

disp(f);