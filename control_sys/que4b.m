%que 4b
clc;
close all;
clear all;

d_r1=0.8;
d_r2=0.4;
% epsilon value is 1/ root kt
%t is constant

T=1; %no matter
%initialize to 1
k2=1;
%initalize to 1
k=1;
num=k;
den=[T 2];
gs=tf(num,den);
den=[den num];
cl_tf=tf(num,den);
disp(num);
disp(den);

if (den(1)~=1)
    num=num(1)/den(1);
    for i=1:length(den)
        den=den/den(1);
    end
end
disp(num);
disp(den);

val=d_r1/d_r2;
alpha= val*val;
k2=alpha*k;

num=k2;
den=[T 2];
gs=tf(num,den);
den=[den num];
cl_tf=tf(num,den);
disp(num);
disp(den);

if (den(1)~=1)
    num=num(1)/den(1);
    for i=1:length(den)
        den=den/den(1);
    end
end
disp(num);
disp(den);
