%circular conv:
clc;
clear all;
close all;
x=[1 2 3 4];
h=[1 1 2 4];
N=length(x);
y=zeros(1,N);
for m =1:N
    for n=1:N
        index=mod(m-n,N)+1;
        y(m)=y(m)+h(index)*x(n);
    end
end

%---------------------
subplot(2,2,1);
stem(x,'b',"filled");
title("Input sequence");
xlabel("Time axis");
ylabel("Amplitude");

subplot(2,2,2);
stem(h,'b',"filled");
title("H sequence");
xlabel("Time axis");
ylabel("Amplitude");

subplot(2,2,3);
stem(y,'b',"filled");
title("convolution sequence");
xlabel("Time axis");
ylabel("Amplitude");
