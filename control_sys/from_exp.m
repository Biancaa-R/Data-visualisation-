clc;
clear all;
close all;
num=[1];
den=[1 2 1];
sys=tf(num,den);
step(sys, 0:0.01:10);
title('Step response of system');
damping=den(2)/(2*sqrt(den(3)));
disp(damping);