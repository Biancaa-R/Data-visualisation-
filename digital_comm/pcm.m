n=input('Enter n value for n-bit PCM system : ');
n1=input('Enter number of samples in a period : ');
L=2^n;
x=0:2*pi/n1:4*pi; % n1 nuber of samples have tobe selected
s=8*sin(x);
plot(s);
title('Analog Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
figure;
stem(s);grid on; title('Sampled Sinal'); ylabel('Amplitude--->');
xlabel('Time--->');
% Quantization Process
vmax=8;
vmin=-vmax;
del=(vmax-vmin)/L;
part=vmin:del:vmax; % level are between vmin
%and vmax with difference of del
code=vmin-(del/2):del:vmax+(del/2); % Contaion Quantized valuses
[ind,q]=quantiz(s,part,code); % Quantization process
% ind
%contain index number and q contain quantized values
l1=length(ind);
l2=length(q);
for i=1:l1
if(ind(i)~=0) % To make index as
%binary decimal so started from 0 to N
ind(i)=ind(i)-1;
end
i=i+1;
end
for i=1:l2
if(q(i)==vmin-(del/2)) % To make quantize value
%inbetween the levels
q(i)=vmin+(del/2);
end
end
figure;
stairs(q);grid on;hold on;
plot(s);% Display the Quantize values
title('Quantized Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
% Encoding Process
code=de2bi(ind,'left-msb'); % Cnvert the decimal to binary
k=1;
for i=1:l1
for j=1:n
coded(k)=code(i,j); % convert code matrix to a coded
%row vector
j=j+1;

k=k+1;
end
i=i+1;
end
figure; grid on;
stairs(coded); % Display the encoded signal
axis([0 100 -2 3]); title('Encoded Signal');
ylabel('Amplitude--->');