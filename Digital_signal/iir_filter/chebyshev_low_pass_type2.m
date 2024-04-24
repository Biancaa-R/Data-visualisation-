%chebyshev IIR
%lowpass
%inputs
clc;
clear all;
close all;
fsamp= 8000;
fp= 1000;
fs= 2000; 
ws= (2*fs)/fsamp; %digital
wp= (2*fp)/fsamp;
ap= 0.5;
as= 40;
f1= 500;
f2= 1500;
f3= 2500;
order=1024;
%input signals
t= 0:(1/fsamp):0.1;
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
x3 = sin(2*pi*f3*t);
x = x1+x2+x3;
%input spectrum
fft_x=fft(x,order);
for i=1:order
    fr(i)=i*(fsamp/order);
end
%low pass
[N,Ws]=cheb2ord(wp,ws,ap,as);
[b,a]= cheby2(N,as,Ws,'low');
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
fft_y1=fft(y1,order);
figure(1);
subplot(311)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'k');
title('Input Sequence x');
xlabel('Frequency');
ylabel('Magnitude');
subplot(312) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),(h1(1:order/2)),'k');
title('Gain Plot frequency response');
xlabel('Frequency'); ylabel('Amplitude');
subplot(313) %output
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'k');
title('Output sequence - High pass chebyshev filter');
xlabel('Frequency'); ylabel('Amplitude');