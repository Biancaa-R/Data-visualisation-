clc; clear all; close all; %clearing to erase previous values if any
%input audio
[x,fsamp]=audioread('clean_speech.wav');
%input audio sequence
D=1024;
fft_x=fft(x,D);
for i=1:D
    fr(i)=i*(fsamp/D);
end
%designing filter
N = 8;
Astop1 = 30;
Apass  = 0.5;
Astop2 = 30;
%bandwidth - 1
gain_amp = 3;
Fpass1 = 1;
Fpass2 = 700;
ellipt = designfilt("bandpassiir", ...
    FilterOrder=N, ...
    PassbandFrequency1=Fpass1, ...
    PassbandFrequency2=Fpass2, ...
    StopbandAttenuation1=Astop1, ...
    PassbandRipple=Apass, ...
    StopbandAttenuation2=Astop2, ...
    SampleRate=fsamp);
y1 = filter(ellipt,x);
fft_y1=fft(y1*gain_amp,D);
%bandwidth - 2
gain_amp = 5;
Fpass1 = 701;
Fpass2 = 1400;
ellipt = designfilt("bandpassiir", ...
    FilterOrder=N, ...
    PassbandFrequency1=Fpass1, ...
    PassbandFrequency2=Fpass2, ...
    StopbandAttenuation1=Astop1, ...
    PassbandRipple=Apass, ...
    StopbandAttenuation2=Astop2, ...
    SampleRate=fsamp);
y2 = filter(ellipt,x);
fft_y2=fft(y2*gain_amp,D);
%bandwidth - 3
gain_amp = 10;
Fpass1 = 1401;
Fpass2 = 2100;
ellipt = designfilt("bandpassiir", ...
    FilterOrder=N, ...
    PassbandFrequency1=Fpass1, ...
    PassbandFrequency2=Fpass2, ...
    StopbandAttenuation1=Astop1, ...
    PassbandRipple=Apass, ...
    StopbandAttenuation2=Astop2, ...
    SampleRate=fsamp);
y3 = filter(ellipt,x);
fft_y3=fft(y3*gain_amp,D);
figure(1)
subplot(1,1,1);
plot(fr(1:D/4),abs(fft_x(1:D/4)),'k');
hold on;
plot(fr(1:D/4),abs(fft_y1(1:D/4)),'b');
hold on;
plot(fr(1:D/4),abs(fft_y2(1:D/4)),'r');
hold on;
plot(fr(1:D/4),abs(fft_y3(1:D/4)),'g');
legend('Noisy Audio Signal','Band Pass Filtered 1','Band Pass Filtered 2','Band Pass Filtered 3');
title('Filtered Audio signal');
xlabel('Frequency'); ylabel('Amplitude');
hold off;
%given by matlab
%no. of samples per frame/ per octave  1024 samples at a time.
frameLength = 1024;
reader = dsp.AudioFileReader('clean_speech.wav','SamplesPerFrame',frameLength);
player = audioDeviceWriter('SampleRate',reader.SampleRate);
% is an object that sends audio data to an audio output device 
equalizer = graphicEQ('Bandwidth','2/3 octave', 'Structure','Cascade','SampleRate',reader.SampleRate);
equalizer.Gains = [1,1,1,1,1,10,10,10,10,10,50,50,50,50,50];
visualize(equalizer)
while ~isDone(reader)
    x = reader();
    y = equalizer(x);
    player(y);
end

%Lower Order Requirement: IIR filters can achieve a desired frequency response with a significantly lower filter order compared to FIR filters. This means fewer coefficients are needed, reducing computational complexity and memory usage.
%Efficiency in Real-Time Applications: Due to the lower order, IIR filters are computationally more efficient, making them suitable for real-time applications where processing power is limited.
% one octave split into 15 bands for the visualization
