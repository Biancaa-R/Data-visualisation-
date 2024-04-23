% Design of FIR filter%

clc;
clear all;
close all;

Fl1=30000;
Fl2=40000;
Fl3=50000;
Fl4=10000;

Flc=20000;
Fs=300000;

Wc=2*pi*(Flc/Fs);
t=0:1/(Fs):0.1;

x=sin(2*pi*Fl1*t)+sin(2*pi*Fl2*t)+sin(2*pi*Fl3*t)+sin(2*pi*Fl4*t);
%displaying the input image:
M=111;
figure;
stem(t,x,'k');
xlabel('time');
ylabel('amplitude');
title('input graph');
D=1024;

dft_x=fft(x,D);
for i=1:(D/2)
    fr(i)=i*(Fs/D);
end

figure;
subplot(5,2,[1,2]);
plot(fr,abs(dft_x(1:D/2)));

for n= -(M-1)/2 : (M-1)/2
    if n==0
        hd(n+ (M+1)/2)=Wc/pi;
    else 
        hd(n+(M+1)/2)=(sin(pi*n)-sin(Wc*n))/(pi*n);
    end
end

for n=-(M-1)/2 :(M-1)/2
    Wn(n + (M+1)/2)=1;
end

for n= -(M-1)/2: (M-1)/2
    Wnh(n + (M+1)/2)= 0.54- 0.46 * cos((2*pi*n)/(M-1));
end

for n=-(M-1)/2: (M+1)/2
    Wnhn(n+ (M+1)/2)=0.5 ;
end
h=hd.*Wn;
y=filter(h,1,x);
fft_y=fft(y,D);
subplot(5,2,3);
plot(fr,abs(fft_y(1:D/2)));
h1=freqz(h,1,D/2);
subplot(5,2,4);
plot(fr,20*log10(abs(h1)));


h=hd.*Wnh;
y=filter(h,1,x);
fft_y=fft(y,D);
subplot(5,2,5);
plot(fr,abs(fft_y(1:D/2)));
h1=freqz(h,1,D/2);
subplot(5,2,6);
plot(fr,20*log10(abs(h1)));
for n= -(M-1)/2: (M-1)/2
    Wn(n+ (M+1)/2)= 1;
end



