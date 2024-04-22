%que 3
clc;
close all;
clear all;

d_r1=0.15;
d_r2=0.5;

a=d_r1/d_r2;
ratio=a*a;

T=15;
k=144;

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

%for k2
k2=ratio*k;
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


