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
fft_x=(fft(x,order));
for i=1:order/2
    f(i)=i*fs/order;
end
% Filter coefficients
fc1=500;
wc1=2*pi*fc1/fs;
disp(wc1);
fc2=1000;
wc2=2*pi*fc2/fs;
m=101;
for n=-(m-1)/2:(m-1)/2
 if n~=0
       hd(n+((m+1)/2))=(sin(pi*n)-sin(wc2*n)+sin(wc1*n))/pi*n;
 else
     hd(n+((m+1)/2))=(pi+wc1-wc2)/pi;
     %making it causal
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
hold on;
plot(f(1:200),abs(fft_y(1:200)));
xlabel("samples");
ylabel("amplitude");
title("Bandpass-Rectangular")
hold off
% plot(abs(fft_x(1:200)),x(1:200),'k')

%hamming
h=hd.*wh;
y2=filter(h,1,x);
fft_y2=fft(y2,order);
subplot(2,2,2);
plot(f(1:200),abs(fft_x(1:200)));
hold on;
plot(f(1:200),abs(fft_y2(1:200)),'r');
xlabel("samples");
ylabel("amplitude");
title("Bandpass-Hamming")
hold off

%hanning
h=hd.*wha;
y3=filter(h,1,x);
fft_y3=fft(y3,order);
subplot(2,2,3);
plot(f(1:200),abs(fft_x(1:200)),'b');
hold on;
plot(f(1:200),abs(fft_y3(1:200)),'r');
xlabel("samples");
ylabel("amplitude");
title("Bandpass-Hanning")
hold off;

%blackman
h=hd.*whb;
y4=filter(h,1,x);
fft_y4=fft(y4,order);
subplot(2,2,4);
plot(f(1:200),abs(fft_x(1:200)),'b');
hold on;
plot(f(1:200),abs(fft_y4(1:200)),'r');
xlabel("samples");
ylabel("amplitude");
title("Bandpass-Blackman")
hold off