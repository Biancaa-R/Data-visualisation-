frameLength = 512;

fileReader = dsp.AudioFileReader( ...
    'Filename','clean_speech.wav', ...
    'SamplesPerFrame',frameLength);
deviceWriter = audioDeviceWriter( ...
    'SampleRate',fileReader.SampleRate);

setup(deviceWriter,ones(frameLength,2))
mPEQ = multibandParametricEQ( ...
    'NumEQBands',3, ...
    'Frequencies',[300,1200,5000], ...
    'QualityFactors',[1,1,1], ...
    'PeakGains',[8,-10,7], ...
    'HasHighShelfFilter',true, ...
    'HighShelfCutoff',14000, ...
    'HighShelfSlope',0.3, ...
    'HighShelfGain',-5, ...
    'SampleRate',fileReader.SampleRate);

visualize(mPEQ)

count = 0;
while ~isDone(fileReader)
    originalSignal = fileReader();
    equalizedSignal = mPEQ(originalSignal);
    deviceWriter(equalizedSignal);
    if mod(count,100) == 0
        mPEQ.PeakGains(1) = mPEQ.PeakGains(1) - 1.5;
        mPEQ.PeakGains(2) = mPEQ.PeakGains(2) + 1.5;
        mPEQ.PeakGains(3) = mPEQ.PeakGains(3) - 1.5;
    end
    count = count + 1;
end


mPEQ = multibandParametricEQ( ...
    'NumEQBands',1, ...
    'Frequencies',9.5e3, ...
    'PeakGains',10);
visualize(mPEQ)

for i = 1:1000
    mPEQ.Frequencies = mPEQ.Frequencies + 8;
end

mPEQOversampled = multibandParametricEQ( ...
    'NumEQBands',1, ...
    'Frequencies',9.5e3, ...
    'PeakGains',10, ...
    'Oversample',true);
visualize(mPEQOversampled)

for i = 1:1000
    mPEQOversampled.Frequencies = mPEQOversampled.Frequencies + 8;
end