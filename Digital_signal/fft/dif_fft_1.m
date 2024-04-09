xn= input("Enter the input sequence");
n=length(xn);
p=nextpow2(n);

xn_zeros = [xn, zeros(1, power(2,p)-n)];
y=dif_fft(xn_zeros,n); 
disp(y.');
stem(abs(y));
%displaying the absolute values of the final fft.
freqz(y);
title('FFT');
xlabel('n');
ylabel('Amplitude');


function y=dif_fft(xn,n)
    if n==1
        y=xn;
    else 
        Wn=exp(-2i*pi/n).^(0:n/2-1);
        y1=dif_fft(xn(1:1:n/2)+xn(n/2+1:1:n), n/2);
        y2=dif_fft((xn(1:1:n/2)-xn(n/2+1:1:n)).*Wn,n/2);
        y(1:2:n)=y1;
        y(2:2:n)=y2;
    end
end

