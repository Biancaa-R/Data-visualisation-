%butterworth filter
clc;
clear all;
close all;
fp=1000;
fs=1200;
Ap=3;
As=40;
fsamp=8000;
order=1024;
t=0:1/fsamp:0.1;
input=[500 1500 2500];
x1=sin(2*pi*input(1)*t);
x2=sin(2*pi*input(2)*t);
x3=sin(2*pi*input(3)*t);
x=x1+x2+x3;

[N,Wn]=buttord(2*fp/fsamp,2*fs/fsamp,Ap,As);
[b,a]=butter(N,Wn,'low');
[h,f]=freqz(b,a,order,fsamp);
y1=filter(b,a,x);
% fr = (1:D)*(fsamp/D); % Calculate frequency vector for positive frequencies
%  [H,W] = freqz(B,A,N) returns the N-point complex frequency response
%  vector H and the N-point frequency vector W in radians/sample of
% the filter:
fft_y=fft(y1,order);

fft_x=fft(x,order);
for i=1:(order)
    fr(i)=i*(fsamp/order);
end

%gain calculation
hmax=abs(max(h));
gain= 20*log(abs(h)/abs(hmax));

figure;
subplot(3,1,1);

plot(fr(1:512),(gain(1:512)));
title("Gain plot");
xlabel('frequency');
ylabel('gain in db');
%stem(fr(1:512)freqz(b,a,order,fsamp)(1:order/2));
subplot(3,1,2);

plot(fr(1:512),abs(fft_x(1:order/2)));
hold on;
disp(N);
title("Low pass butterworth");
plot(fr(1:512),abs(fft_y(1:512)));
xlabel('frequency');
ylabel('amplitude');
subplot(3,1,3);
plot(f(1:512));
xlabel('samples');
ylabel('frequency response');

figure;

plot(fr(1:order/2),abs(fft_x(1:order/2)),'k');
hold on;
plot(fr(1:order/2),abs(fft_y(1:order/2)),'b');
title("Superimposing input and output butterworth")
xlabel('frequency');
ylabel('amplitude');

