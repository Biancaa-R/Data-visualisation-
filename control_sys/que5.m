%Question 5
clc;
clear all;
close all;
num=[144];
den=[1 12];
gs=tf(num,den);
den=[den num];
c_l_tf=tf(num,den);
%disp(c_l_tf);
value=stepinfo(c_l_tf);
disp(value);
%to find epsilon and omega value:
w_r=sqrt(den(3));
d_r=den(2)/(2*w_r);

phi=atan(sqrt(1-d_r*d_r)/d_r);
w_d=w_r* sqrt(1- d_r*d_r);
tr=( pi-phi)/w_d;
disp("raise time");
disp(tr);

tp=pi/w_d;
disp("peak time");
disp(tp);

mp=100* exp(-d_r*w_r*tp);
disp("Maximum peak overshoot");
disp(mp);

ts=4.5/(d_r*w_r);
disp("settling time");
disp(ts);

td=(1+0.7*d_r)/w_r;
disp("delay time");
disp(td);