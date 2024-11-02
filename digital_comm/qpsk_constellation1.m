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
s_p_data=reshape(data_NZR,2,length(data)/2);  % S/P convertion of data
br=10.^6; %Let us transmission bit rate  1000000
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information
y=[];
y_in=[];
y_qd=[];
d=zeros(1,length(data)/2);
for i=1:length(data)/2
    p=data(2*i);
    imp=data(2*i - 1);
    y1=s_p_data(1,i)*cos(2*pi*f*t); % inphase component
    y2=s_p_data(2,i)*sin(2*pi*f*t) ;% Quadrature component
    y_in=[y_in y1]; % inphase signal vector
    y_qd=[y_qd y2]; %quadrature signal vector
    y=[y y1+y2]; % modulated signal vector
    if (imp == 0) && (p == 0)
       d(i)=exp(j*pi/4);%45 degrees
    end
    if (imp == 1)&&(p == 0)
        d(i)=exp(j*3*pi/4);%135 degrees
    end
    if (imp == 1)&&(p == 1)
        d(i)=exp(j*5*pi/4);%225 degrees
    end
    if (imp == 0)&&(p == 1)
        d(i)=exp(j*7*pi/4);%315 degrees
    end
end
for i=1:length(d)
    d(i)=d(i)+rand(1)/10;
end
Tx_sig=y; % transmitting signal after modulation
qpsk=d;
tt=T/99:T/99:(T*length(data))/2;
figure(2)
subplot(3,1,1);
plot(tt,y_in,'linewidth',3), grid on;
title(' wave form for inphase component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
subplot(3,1,2);
plot(tt,y_qd,'linewidth',3), grid on;
title(' wave form for Quadrature component in QPSK modulation ');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
subplot(3,1,3);
plot(tt,Tx_sig,'r','linewidth',3), grid on;
title('QPSK modulated signal (sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel(' amplitude(volt0');
figure(3);
plot(d,'o','Color','b');%plot constellation without noise
axis([-2 2 -2 2]);
grid on;
xlabel('real'); ylabel('imag');
title('QPSK constellation');