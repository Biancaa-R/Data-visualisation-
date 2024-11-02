%constellation diagram:
clc;
clear all;
close all;
data=[0 0 1 1 0 1 1 0 1 1 1 0 0 1 0 1 1 1 1 0]; % information

figure(1)
stem(data, 'linewidth',3), grid on;
title('  Information before Transmiting ');
axis([ 0 11 0 1.5]);
data_NZR=2*data-1; % Data Represented at NZR form for QPSK modulation

br=10.^6; %Let us transmission bit rate  1000000
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information
y=[];
y_in=[];
d=zeros(1,length(data)/2);
for i=1:length(data)

    if (data(i)==0)
       d(i)=exp(j*0*pi/4);%45 degrees
       %y(i)=cos(2*pi*f*t);
       y2=cos(2*pi*f*t) ;% Quadrature component
       y_in=[y_in y2]; % inphase signal vector
    end
    if(data(i)==1)
        d(i)=exp(j*4*pi/4);
        %y(i)=cos(2*pi*f*t+pi);
        y2=cos(2*pi*f*t+ pi) ;% Quadrature component
        y_in=[y_in y2]; % inphase signal vector
    end

end
for i=1:length(d)
    d(i)=d(i)+rand(1)/10;
end
Tx_sig=y; % transmitting signal after modulation
qpsk=d;
tt=T/99:T/99:(T*length(data));

figure(2)
subplot(2,1,1);
plot(1:1:20,data,'o','linewidth',3), grid on;
title(' wave form for inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
subplot(2,1,2);
plot(tt,y_in,'linewidth',3), grid on;
title(' wave form for Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');

figure(3);
plot(d,'o','Color','b');%plot constellation without noise
axis([-2 2 -2 2]);
grid on;
xlabel('real'); ylabel('imag');
title('QPSK constellation');