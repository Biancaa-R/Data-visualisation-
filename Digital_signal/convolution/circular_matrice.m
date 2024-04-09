clc;
clear all;
close all;
x=[1 ,1, 2 , 2];
h=[1, 2 , 3, 4];

N=length(x);
y=zeros(1,N);
for m=0:N-1
    for n=m:0
        y(m+1)=y(m+1)+x(m+1);
    end
end

disp(y);
C=y.*h;
disp(C);