
%Finite word length:
clc;
clear all;
close all;

f1=3000;
f2=4000;
f3=5000;
fc1=2500;
fc2=4500;
M=101;
fsamp=15000;
D=1024;
t=0:1/fsamp:0.1;
x1 =sin(2*pi*f1*t);
x2=sin(2*pi*f2*t);
x3=sin(2*pi*f3*t);
x=x1+x2+x3;

dft_x=fft(x,D);
for i=1:(D/2)
    fr(i)=i*(fsamp/D);
end

figure;
subplot(2,3,1);
plot(fr,abs(dft_x(1:D/2)));
title("Input sprectrum frequency domain");
xlabel("frequency");
ylabel("amplitude");

Wc1=2*pi*fc1/fsamp;
Wc2=2*pi*fc2/fsamp;


for n= -(M-1)/2 : (M-1)/2
    if n==0
        hd(n+ (M+1)/2)=(pi-Wc2+Wc1)/pi;
    else 
        hd(n+(M+1)/2)=(pi-sin(Wc2)+sin(Wc1))/(pi*n);
    end
end

 index=-(M-1)/2:(M-1)/2;
 hd=(sin(Wc2*index)-sin(Wc1*index))./(pi*index);
 hd((M-1)/2+1)=(Wc2-Wc1)/pi;


for n= -(M-1)/2: (M-1)/2
    Wnh(n + (M+1)/2)= 0.54+ 0.46 * cos((2*pi*n)/(M-1));
end

h=hd.*Wnh;
y=filter(h,1,x);
fft_y=fft(y,D);
subplot(2,3,2);
plot(fr,abs(fft_y(1:D/2)));
title('Output -response- non quantized filter');
xlabel('frequency');
ylabel('amplitude');
h1=freqz(h,1,D/2);

subplot(2,3,3);
win=freqz(h,1,D/2);
plot(fr,20*log(abs(win)));
title("Window function-Hamming");
xlabel('frequency');
ylabel('amplitude');

q=quantizer('fixed','floor','saturate',[8,8]);
h_q=quantize(q,h);
q_e=h_q-h;
subplot(2,3,4);
plot(q_e);
title('Quantized Error');
y_q=filter(h_q,1,x);
fft_y_q=fft(y_q,D);
subplot(2,3,5);
plot(fr,abs(fft_y_q(1:D/2)));
title('Output response- Quantized filter');
xlabel('frequency');
ylabel('amplitude');
h_q1=freqz(y_q,1,D/2);

%gain plot:
a=fftshift(fft(h,D));
b=fftshift(fft(h_q,D));
for i=1:(D)
    fr(i)=i*(fsamp/D);
end
%Shift zero-frequency component to center of spectrum.
%For vectors, fftshift(X) swaps the left and right halves of X.

subplot(2,3,6);
plot(fr,20*log10(abs(a)),'b');
hold on;
plot(fr,20*log10(abs(b)),'r');
lgd = legend({'non quantized','quantized'},'FontSize',10,'TextColor','black');
lgd.NumColumns=1;
title('Gain Plot')
hold off;


