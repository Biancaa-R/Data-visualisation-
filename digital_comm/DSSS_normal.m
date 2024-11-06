clc;
close all;
clear all;
b = 1001;
% b = input('Enter The input Bits : ');
value_str = num2str(b);
b = arrayfun(@(x) str2double(x), value_str);
ln = length(b);

for i = 1:ln
    if b(i) == 0
        b(i) = -1;
    end
end   
k = 1;
for i = 1:ln
   for j = 1:7
       bb(k) = b(i);
       k = k + 1;
   end
end

len = length(bb);
subplot(2,1,1);
stairs(bb, 'linewidth', 2);
axis([0 len -2 3]);
title('Original Bit Sequence b(t)');
xlabel("Time");
ylabel("Amplitude");
pn = comm.PNSequence('Polynomial', [3 2 0], 'InitialConditions', [1 0 0], 'SamplesPerFrame', 7*ln);
pr_sig = pn();
pr_sig(pr_sig == 0) = -1;  % Convert 0s to -1s

subplot(2,1,2);
stairs(pr_sig, 'linewidth', 2);
axis([0 len -2 3]);
title('Pseudorandom Bit Sequence pr_sig(t)');
xlabel("Time");
ylabel("Amplitude");
bbs = bb .* pr_sig';
dsss = [];
t = 0:1/10:2*pi;   
c1 = sin(t + pi); 
c2 = sin(t);       

for k = 1:len
    if bbs(k) == -1
        dsss = [dsss c1];
    else
        dsss = [dsss c2];
    end
end

figure,
subplot(2,1,1);
stairs(bbs, 'linewidth', 2);
axis([0 len -2 3]);
title('Multiplier Output Sequence b(t)*pr_sig(t)');
xlabel("Time");
ylabel("Amplitude");
t_dsss = linspace(0, length(dsss)/63, length(dsss)); % Adjust based on sampling rate
subplot(2,1,2);
plot(t_dsss, dsss);
axis('tight');
title('DSSS Signal');
xlabel("Time");
ylabel("Amplitude");
