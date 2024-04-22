%que 3'

clc;
clear all;
close all;
%determine k value
%mp = exp( (-d_r*pi)/sqrt(1- d_r*d_r));
%eqn1 
value=log(0.75);
d_r1=sqrt(value/(pi*pi+value));
value=log(0.25);
d_r2=sqrt(value/(pi*pi+value));

delta_k=(d_r1*d_r1)/(d_r2*d_r2);
k=5;
num=k;
den=[7 1 k];
tf1=tf(num,den);
w_r=sqrt(den(3));
d_r=den(2)/(2*w_r);

num=k*delta_k;
den=[7 1 k];
tf1=tf(num,den);
w_r=sqrt(den(3));
d_r=den(2)/(2*w_r);
disp(num);