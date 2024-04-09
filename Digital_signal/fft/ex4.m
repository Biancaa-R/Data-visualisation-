%2 point
xn=input('Input sequence: '); 
n=length(xn);
p=nextpow2(n);
times=log2(n);
xn_zeros = [xn, zeros(1, power(2,p)-n)];
Xk=dit_fft(xn_zeros,n); 
disp(Xk.');
stem(abs(Xk));
freqz(Xk);
title('FFT');
xlabel('n');
ylabel('Amplitude');
change_val(xn_zeros);
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
%x_even and x_odd represent even and odd indexed elements of some signal respectively.
%W.*x_odd and W.*x_odd perform element-wise multiplication of the arrays W and x_odd.
%x_even+W.*x_odd computes the addition of corresponding elements of x_even and W.*x_odd.
%x_even-W.*x_odd computes the subtraction of corresponding elements of x_even and W.*x_odd.
function [X,Y]= separate(array)
    % Initialize arrays for even and odd indices
    even_indices = [];
    odd_indices = [];
    % Loop through the array
    for i = 1:length(array)
        if mod(i, 2) == 0
            even_indices = [even_indices, array(i)];
        else
            odd_indices = [odd_indices, array(i)];
        end
    end
    X=even_indices;
    Y=odd_indices;
end
function change_val(array)
    [even,odd]=separate(array);
    % Add 8 zeros to the list
    n=length(even);
    p=nextpow2(n);
    even_zeros = [even, zeros(1, power(2,p)-n)];
    Xk=dit_fft(even_zeros,p);
    disp(Xk.');
    change_val(even);
    n=length(odd);
    p=nextpow2(n);
    odd_zeros = [odd, zeros(1, power(2,p)-n)];
    Xk=dit_fft(odd_zeros,p);
    disp(Xk.');
    change_val(odd);
end