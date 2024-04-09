
xn=input("Enter the sequence");
n=length(xn);
p=nextpow2(n);

xn_zeros = [xn, zeros(1, power(2,p)-n)];
Xk=dit_fft(xn_zeros,n); 
disp(Xk.');
stem(abs(Xk));
%displaying the absolute values of the final fft.
freqz(Xk);
title('FFT');
xlabel('n');
ylabel('Amplitude');
function X = dit_fft(x,N)
    if N==1
        X=x;
    else
        x_even= dit_fft(x(1:2:end),N/2);
        x_odd=dit_fft(x(2:2:end),N/2);
        W=exp(-2i*pi/N).^(0:N/2-1);
        X=[x_even+W.*x_odd,x_even-W.*x_odd];
    end
end

%W.*x_odd and W.*x_odd perform element-wise multiplication of the arrays W and x_odd.
%x_even+W.*x_odd computes the addition of corresponding elements of x_even and W.*x_odd.
%x_even-W.*x_odd computes the subtraction of corresponding elements of x_even and W.*x_odd.


    