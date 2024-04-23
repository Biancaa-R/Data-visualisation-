clc;
clear all;
close all;

% Define the center frequency of the band pass filter
fc = 500;

% Define the bandwidth of the band pass filter
bw = 200;

% Define the sampling frequency
fs = 8000;

% Read the audio file
[x, fs] = audioread('C:\Users\Biancaa. R\Downloads\clean_speech_car_0db\clean_speech_car_0db.wav');


% Define the filter coefficients
fmax = fs / 2;
length(x);
s = 200;
order = 1024;

% Calculate the frequencies for the FFT
for i = 1:order/2
    f(i) = i * fs / order;
end

% Calculate the filter coefficients
fc1 = fc - bw / 2;
wc1 = 2 * pi * fc1 / fs;
fc2 = fc + bw / 2;
wc2 = 2 * pi * fc2 / fs;
m = 101;

for n = -(m-1)/2:(m-1)/2
    if n ~= 0
        hd(n + (m+1)/2) = (sin(wc2 * n) - sin(wc1 * n)) / pi * n;
    else
        hd(n + (m+1)/2) = (wc2 - wc1) / pi;
        % Making it causal
    end
end

% Define the window coefficients
% Rectangular
for n = -(m-1)/2:(m-1)/2
    wr(n + (m+1)/2) = 1;
end
% Hamming
for n = -(m-1)/2:(m-1)/2
    wh(n + (m+1)/2) = 0.54 + 0.46 * cos(2 * pi * n / (m-1));
end
% Hanning
for n = -(m-1)/2:(m-1)/2
    wha(n + (m+1)/2) = (1/2) * (1 + cos(2 * pi * n / (m-1)));
end
% Blackman
for n = -(m-1)/2:(m-1)/2
    whb(n + (m+1)/2) = 0.42 + 0.5 * cos(2 * pi * n / (m-1)) + 0.08 * cos(4 * pi * n / (m-1));
end

% Calculate the filter coefficients
% Rectangular
h = hd .* wr;
y = filter(h, 1, x);
fft_y1=fft(y,order);

% Hamming
h = hd .* wh;
y2 = filter(h, 1, x);
fft_y2=fft(y2,order);

% Hanning
h = hd .* wha;
y3 = filter(h, 1, x);
fft_y3=fft(y3,order);

% Blackman
h = hd .* whb;
y4 = filter(h, 1, x);
fft_y4=fft(y4,order);
fft_x =fft(x,order/2);

% Plot the frequency response of the filter
subplot(2, 2, 1);
plot(f(1:200), abs(fft_x(1:200)));
xlabel('samples');
ylabel('amplitude');
title('Highpass-Rectangular');
hold on;
plot(f(1:200), abs(fft_y1(1:200)));

subplot(2, 2, 2);
plot(f(1:200), abs(fft_x(1:200)));
xlabel('samples');
ylabel('amplitude');
title('Highpass-Hamming');
hold on;
plot(f(1:200), abs(fft_y2(1:200)));

subplot(2, 2, 3);
plot(f(1:200), abs(fft_x(1:200)));
xlabel('samples');
ylabel('amplitude');
title('Highpass-Hanning');
hold on;
plot(f(1:200), abs(fft_y3(1:200)));

subplot(2, 2, 4);
plot(f(1:200), abs(fft_x(1:200)));
xlabel('samples');
ylabel('amplitude');
title('Highpass-Blackman');
hold on;
plot(f(1:200), abs(fft_y4(1:200)));

