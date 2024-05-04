fun = @(x)log(x);  % Define function
figure(1);
plot((1:100), fun((1:100)),'k'); 
hold on;

% Define the function symbolically
syms x

f(x) = log(x);

% symbolic integration
F(x) = int(f(x));

% Convert symbolic expression to a function (optional)
F_func = matlabFunction(F(x));
x = linspace(lower, upper, 100);
plot(x, F_func(x),'k','LineStyle','--','LineWidth',2);
hold off;

fun = @(x)log(x);
lower = 0.01;  
upper = 1e6; 

integral_value = integral(fun, lower, upper);
disp(integral_value)