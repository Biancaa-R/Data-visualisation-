clc;
clear all;
close all;
[x,fs]=audioread("C:\Users\Biancaa. R\Downloads\clean_speech_car_0db\clean_speech_car_0db.wav");
f_max=fs/2;
disp(fs);
cutoff=500;
Wc=2*pi*cutoff/fs;
disp(length(x));
y=lowpass(x,cutoff,fs);
figure;
plot(x);
title("Input signal");
xlabel("samples");
ylabel("amplitude");

D=1024;
%figure;
%plot(y(1:200),1:200);

for i=1:(D/2)
    fr(i)=i*(fs/D);
end

%figure;
%lowpass(x,cutoff,fs);

M=101;
%Rectangular
for n=-(M-1)/2 :(M-1)/2
    Wn(n + (M+1)/2)=1;
end

%Hamming
for n= -(M-1)/2: (M-1)/2
    Whm(n + (M+1)/2)= 0.54+ 0.46 * cos((2*pi*n)/(M-1));
end

% Hanning
for n=-(M-1)/2:(M-1)/2
   wha(n+((M+1)/2))=(1/2)*(1+cos(2*pi*n/(M-1)));
end
%black man
for n=-(M-1)/2:(M-1)/2
   whb(n+((M+1)/2))=0.42+0.5*cos(2*pi*n/(M-1))+0.08*cos(4*pi*n/(M-1));
end

fc1=500;
wc1=2*pi*fc1/fs;
disp(wc1);
fc2=700;
wc2=2*pi*fc2/fs;
m=101;
for n=-(m-1)/2:(m-1)/2
 if n~=0
       hd(n+(m+1)/2)=(sin(wc2*n)-sin(wc1*n))/pi*n;
 else
     hd(n+(m+1)/2)=(wc2-wc1)/pi;
     %making it causal
end
end

z=fft(x,1024);
h1=hd.*Wn;

%rectangular
y1=filter(h1,1,x);
fft_y=fft(y1,D/2);

subplot(2,2,1);

plot(fr(1:200),abs(z(1:200)),"b");
title('Lowpass filter using rectangular window');
hold on;
plot(fr(1:200),abs(fft_y(1:200)),"r");

%hamming
h2=hd.*Whm;
y2=filter(h2,1,x);
disp(Whm);
fft_y2=fft(y2,D/2);

subplot(2,2,2);

plot(fr(1:200),abs(z(1:200)),"b");
title('Lowpass filter using hamming window');
hold on;
plot(fr(1:200),abs(fft_y2(1:200)),"r");

%hanning 
h3=hd.*wha;
y3=filter(h3,1,x);
fft_y3=fft(y3,D/2);

subplot(2,2,3);
plot(fr(1:200),abs(z(1:200)),"b");
title('Lowpass filter using hanning window');
hold on;
plot(fr(1:200),abs(fft_y3(1:200)),"r");

%blackman

h4=hd.*whb;
y4=filter(h4,1,x);
fft_y4=fft(y4,D/2);

subplot(2,2,4);

plot(fr(1:200),abs(z(1:200)),"b");
hold on;
title('Lowpass filter using blackman window');
plot(fr(1:200),abs(fft_y4(1:200)),"r");

