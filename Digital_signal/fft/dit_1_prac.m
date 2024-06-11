clc;
clear all;
close all;
xn=input("Enter the sequence");
n=length(xn);
p=nextpow2(n);
xn_zeros=[xn,zeros(1,power(2,p)-n)];
Xk=dit_fft(xn_zeros);
Xk=Xk.';
disp(Xk);
stem(abs(Xk));
freqz(Xk);
function X=dit_fft(x)
    N=length(x);
    if N==1
        X=x;
    else 
        x_even=dit_fft(x(1:2:end));
        x_odd=dit_fft(x(2:2:end));
        W=exp(-2*1i*pi/N).^(0:N/2-1);
        X=[x_even+W.*x_odd,x_even-W.*x_odd];

    end
end
