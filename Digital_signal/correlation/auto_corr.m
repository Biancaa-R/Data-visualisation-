x = input("Enter the sequence: ");

% Compute autocorrelation
y = xcorr(x, x);

% Plotting
figure;
subplot(2,1,1);
stem(x);
ylabel("Amplitude");
xlabel("Time");
title("Original Sequence");

subplot(2,1,2);
stem(fliplr(y));
ylabel("Amplitude");
xlabel("Time");
title("Autocorrelation");
