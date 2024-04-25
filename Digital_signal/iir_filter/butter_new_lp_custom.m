%Butterworth filter - IIR
%inputs
clc;
clear all;
close all;
fsamp= 8000;
ws=30;
wp=20;
ap= 2;
as= 10;
f1= 5;
f2= 1.5;
f3= 2;
order=14;
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
[N,Wn]= buttord(wp,ws,ap,as,'s');
[b,a]= butter(N,Wn,'low','s'); %butterpass co efficients
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
plot(fr(1:order/2),20*log(h1(1:order/2)),'k');
title('Gain Plot');
xlabel('Frequency'); ylabel('Amplitude');
subplot(313) %output
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'k');
title('Output sequence - Low pass filter');
xlabel('Frequency'); ylabel('Amplitude');

%
                     %  2.7e05
 % ------------------------------------------------
 % s^4 + 59.57 s^3 + 1774 s^2 + 3.095e04 s + 2.7e05

 %calculated value:

% 2.07
%----------------
%s^4 +55.767 s2+ 2.5407 *10^4*s +2.07571*10^5

