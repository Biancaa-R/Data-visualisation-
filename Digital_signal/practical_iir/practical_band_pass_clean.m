%for getting clean audio but sb wont let me plot it in rec 
%so to try out what I wanna do...
%actully since the graph looks good now actually he might let..
%The gain plot is in frequencies and not as db here

clc;
clear all;
close all;
[x,fsamp]=audioread("C:\Users\Biancaa. R\Documents\MATLAB\Digital_signal\practical_iir\clean_speech_car_0db.wav");
f_max=fsamp/2;
disp(fsamp);
cutoff=500;
Wc=2*pi*cutoff/fsamp;

order=1024;
fp= [500 1000]; 
fs= [300 2800]; 
%fp= [500 900]; 
%fs= [300 1000]; 
%sounds so ooooh
ws= (2*fs)/fsamp; %digital
wp= (2*fp)/fsamp;
ap= 3;
as= 40;

%input spectrum
fft_x=fft(x,order);
for i=1:order
    fr(i)=i*(fsamp/order);
end
% pass
[N,Wn]= buttord(wp,ws,ap,as);
[b,a]= butter(N,Wn,'bandpass'); %butterpass co efficients
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
%sound(y1);
fft_y1=fft(y1,order);
figure(1);
subplot(321)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
lgd = legend({'input spectrum','output spectrum'},'FontSize',10,'TextColor','black');
lgd.NumColumns=1;
title('Band pass filter- Butter worth');
xlabel('Frequency');
ylabel('Magnitude');
subplot(322) %gain
h1=abs(h)/max(abs(h));
%plot(fr(1:order/2),20*log(h1(1:order/2)),'k');
plot(fr(1:order/2),h1(1:order/2),'k');
title('Gain Plot');
xlabel('Frequency'); ylabel('Amplitude');

NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, 'band pass butter worth');
sound(y1);
lgd = legend({'input spectrum','output spectrum'},'FontSize',10,'TextColor','black');
lgd.NumColumns=1;

[N,Wp]=cheb1ord(wp,ws,ap,as);
[b,a]= cheby1(N,ap,Wp,'bandpass');
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
fft_y1=fft(y1,order);
subplot(323)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
lgd = legend({'input spectrum','output spectrum'},'FontSize',10,'TextColor','black');
lgd.NumColumns=1;
title('Band pass chebyshev type 1');
xlabel('Frequency');
ylabel('Magnitude');
subplot(324) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),(h1(1:order/2)),'k');
title('Gain Plot');
xlabel('Frequency'); ylabel('Amplitude');

pause(5);
Speak(obj, 'band pass chebyshev 1');
sound(y1);

[N,Ws]=cheb2ord(wp,ws,ap,as);
[b,a]= cheby2(N,as,Ws,'bandpass');
[h,f]= freqz(b,a,order/2,fsamp);
y1= filter(b,a,x);
fft_y1=fft(y1,order);
subplot(3,2,5)
plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
hold on;
plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
lgd = legend({'input spectrum','output spectrum'},'FontSize',10,'TextColor','black');
lgd.NumColumns=1;
title('Band pass chebyshev type 2');
xlabel('Frequency');
ylabel('Magnitude');
subplot(3,2,6) %gain
h1=abs(h)/max(abs(h));
plot(fr(1:order/2),(h1(1:order/2)),'k');
title('Gain Plot frequency response');
xlabel('Frequency'); ylabel('Amplitude');

pause(5);
Speak(obj, 'band pass chebyshev 2');
sound(y1);

