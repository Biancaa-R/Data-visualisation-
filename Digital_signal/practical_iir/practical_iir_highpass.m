clc;
clear all;
close all;
[x,fsamp]=audioread("C:\Users\Biancaa. R\Documents\MATLAB\Digital_signal\practical_iir\clean_speech_car_0db.wav");
f_max=fsamp/2;
disp(fsamp);
cutoff=500;
Wc=2*pi*cutoff/fsamp;

order=1024;
fp= 500; %analog
fs= 700; 
ws= (2*fs)/fsamp; %digital
wp= (2*fp)/fsamp;
ap= 3;
as= 40;

%input spectrum
fft_x=fft(x,order);
for i=1:order
    fr(i)=i*(fsamp/order);
end
%low pass
[N,Wn]= buttord(wp,ws,ap,as);
[b,a]= butter(N,Wn,'high'); %butterpass co efficients
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);

fft_y1=fft(y1,order);
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, 'high pass butter worth');
sound(y1);
figure(1);
subplot(321)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
title('High pass filter- Butter worth');
xlabel('Frequency');
ylabel('Magnitude');
subplot(322) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),20*log(h1(1:order/2)),'k');
title('Gain Plot');
xlabel('Frequency'); ylabel('Amplitude');

[N,Wp]=cheb1ord(wp,ws,ap,as);
[b,a]= cheby1(N,ap,Wp,'high');
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
fft_y1=fft(y1,order);
pause(5);
Speak(obj, 'high pass chebyshev 1');
sound(y1);
subplot(323)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
title('High pass chebyshev type 1');
xlabel('Frequency');
ylabel('Magnitude');
subplot(324) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),(h1(1:order/2)),'k');
title('Gain Plot');
xlabel('Frequency'); ylabel('Amplitude');

fp= 500; %analog
fs= 600; 
ws= (2*fs)/fsamp; %digital
wp= (2*fp)/fsamp;
[N,Ws]=cheb2ord(wp,ws,ap,as);
[b,a]= cheby2(N,as,Ws,'high');
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
fft_y1=fft(y1,order);
pause(5);
Speak(obj, 'high pass chebyshev 2');
sound(y1);
subplot(3,2,5)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
title('High pass chebyshev type 2');
xlabel('Frequency');
ylabel('Magnitude');
subplot(3,2,6) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),(h1(1:order/2)),'k');
title('Gain Plot frequency response');
xlabel('Frequency'); ylabel('Amplitude');



