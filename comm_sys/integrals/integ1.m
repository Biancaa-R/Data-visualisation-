
figure;  % Create a new figure window

% Original function (numerical)
fun = @(t)log(t);
t = 1:100;
plot(t, fun(t), 'k');  % Plot using function values

hold on;

% Symbolic integration
syms x
f(x) = log(x);
F(x) = int(f(x));
F_func = matlabFunction(F(x));


lower = 0.01;
upper = 1e6;
integral_value = integral(fun, lower, upper);
disp(integral_value);  % Display approximate integral value

% Plot indefinite integral (symbolic approximation)
x = linspace(lower, upper, 100);
plot(x, F_func(x), 'k--', 'LineWidth', 2);  % Dashed line with thickness 2

hold off;