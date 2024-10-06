% Parameters
f = 2;
t = 0:0.01:2;
x = sin(2*pi*f*t); % Original signal

% Initialize parameters for Delta Modulation
a = 0.1;  % Step size for delta modulation
y_DM = zeros(size(x));  % Output delta modulated signal
prev_x = 0;  % Initialize previous value for comparison
alternate_sign = a;  % To alternate between +a and -a when samples are equal

% Plotting
figure;
subplot(3,1,1);
x_orig=stem(t,x).YData; 
title('Original Signal')

% Delta Modulation Loop
for i = 1:length(x)
    if(i==1)
        value=0;
    else 
        value=x_orig(i-1);
    end
    if x_orig(i) > value 
        y_DM(i) = + a;  % Increase by +a
    elseif value > x_orig(i)
        y_DM(i) = - a;  % Decrease by -a
    else
        y_DM(i) = + alternate_sign;  % Alternate between +a and -a
        alternate_sign = -alternate_sign;   % Toggle the sign
    end
    %prev_x = y_DM(i);  % Update previous value
end



subplot(3,1,2);
stem(t,y_DM); 
title('Delta Modulated Signal with Alternating +-a for Equal Values');

subplot(3,1,3);
plot(y_DM);
title("Plotted version");
