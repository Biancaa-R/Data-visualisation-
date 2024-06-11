clear;
close all;
h=[1 1 1];
x=[3 -1 0 1 3 2 0 1 2 1];

M=length(h);
N=2^M;
L=N-M+1;

h_pad=[h zeros(1,L-1)];
x1=x(1:L);
x1=[x1,zeros(1,M-1)];
x2=x(L+1:end);
x2=[x2, zeros(1,M-1)];

if length(x2)~=length(x1)
    x2=[x2 zeros(1,length(x1)-length(x2))];
end

X1=circular_shift(x1);
X2=circular_shift(x2);

Y1=X1*h_pad';
Y2=X2*h_pad';
% as M-1 Samples are discarded


% Make sure indices are within the bounds
Y = [Y1(1:end-(M-1)); Y1(end-(M-1)+1:end) + Y2(1:(M-1)); Y2((M-1)+1:end)];
disp(Y);
