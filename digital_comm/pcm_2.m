clc;clear all;close all;
n=3;
Vmax=4;
fm=70;
fs=2000;
t=0:1/fs:1/fm;
x=Vmax*sin(2*pi*fm*t);
subplot(221)
plot(t, x);
title('Input Signal')
xlabel('Time(s)')
ylabel('Amplitude(V)')
subplot(222)
stem(t, x);
title('Sampled Signal')
xlabel('Time(s)')
ylabel('Amplitude(V)')
L=2*n;
Vmin=-Vmax;
stepsize=(Vmax-Vmin)/L;
q=Vmin:stepsize:Vmax-1;
c=[Vmin:stepsize:Vmax];
[index,q1]=quantiz(x,q,c);
subplot(223)
stairs(t,q1(1:length(t)));hold on;
plot(t,x); grid on;
title('Quantized Signal')
xlabel('Time(s)')
ylabel('Amplitude(V)')
% Encoding using PCM
T=de2bi(index,'left-msb');
s=reshape(T',[1,numel(T)]); % Reshaping the PCM encoded bits into a 1D array
% Adjusting the time axis for the PCM signal
pcm_time = linspace(0, max(t), length(s)); % Generate a new time axis for PCM signal
subplot(224)
grid on;
stairs(pcm_time, s);
axis([0 max(t) -2 2]); % Match the time axis to the input signal
title('PCM Signal: Encoded Signal')
xlabel('Time(s)')
ylabel('Amplitude(V)')
