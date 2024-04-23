clc;
clear all;
close all;
%fc=500Hz
[x,fs]=audioread("C:\Users\Biancaa. R\Downloads\clean_speech_car_0db\clean_speech_car_0db.wav");
sound(x,fs);
fmax=fs/2;
length(x);
% 1s 8000 samples
%25ms 
s=200;
order=1024;
fft_x=(fft(x,512));
for i=1:order/2
    f(i)=i*fs/order;
end
% Filter coefficients
fc=500;
wc=2*pi*fc/fs;
disp(wc)
m=101;
for n=-(m-1)/2:(m-1)/2
 if n~=0
       hd(n+((m+1)/2))=(sin(pi*n)-sin(wc*n))/(pi*n);
 else
     hd(n+((m+1)/2))=1-(wc/pi);
end
end
% Window coefficients
%Rectangular
for n=-(m-1)/2:(m-1)/2
   wr(n+((m+1)/2))=1;
end
% Hamming
for n=-(m-1)/2:(m-1)/2
   wh(n+((m+1)/2))=0.54+0.46*cos(2*pi*n/(m-1));
end
% Hanning
for n=-(m-1)/2:(m-1)/2
   wha(n+((m+1)/2))=(1/2)*(1+cos(2*pi*n/(m-1)));
end
for n=-(m-1)/2:(m-1)/2
   whb(n+((m+1)/2))=0.42+0.5*cos(2*pi*n/(m-1))+0.08*cos(4*pi*n/(m-1));
end

% Window Filter Coefficients
%Rectangular
h=hd.*wr;
h1=freqz(h,1,fs/2);
y=filter(h,1,x);
fft_y=fft(y,order);
%sound(y,fs)
%sound(y2,fs)
subplot(2,2,1);
plot(f(1:200),abs(fft_x(1:200)));
xlabel("samples");
ylabel("amplitude");
title("Highpass-Rectangular")
hold on;
plot(f(1:200),abs(fft_y(1:200)));
% plot(abs(fft_x(1:200)),x(1:200),'k')

%hamming
h=hd.*wh;
y2=filter(h,1,x);
fft_y2=fft(y2,order);
subplot(2,2,2);
plot(f(1:200),abs(fft_x(1:200)));
xlabel("samples");
ylabel("amplitude");
title("Highpass-Hamming")
hold on;
plot(f(1:200),abs(fft_y2(1:200)));

%hanning
h=hd.*wha;
y3=filter(h,1,x);
fft_y3=fft(y3,order);
subplot(2,2,3);
plot(f(1:200),abs(fft_x(1:200)));
xlabel("samples");
ylabel("amplitude");
title("Highpass-Hanning")
hold on;
plot(f(1:200),abs(fft_y3(1:200)));

%blackman
h=hd.*whb;
y4=filter(h,1,x);
fft_y4=fft(y4,order);
subplot(2,2,4);
plot(f(1:200),abs(fft_x(1:200)));
xlabel("samples");
ylabel("amplitude");
title("Highpass-Blackman")
hold on;
plot(f(1:200),abs(fft_y4(1:200)));