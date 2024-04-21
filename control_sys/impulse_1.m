clc;
clear all;
close all;

d_r=[0,0.1,0.5 ,0.9,1.0,1.5,2];
w_r=12;
tr_l=[];
tp_l=[];


for j=1:7
    num=[w_r*w_r];
    den=[1 2*d_r(j)*w_r w_r*w_r];
    sys=tf(num,den);
    if(d_r(j)<1)
        tr=((0+1i)*pi/(w_r* sqrt(d_r(j)*d_r(j)-1)));
    else
        tr=(pi/(w_r* sqrt(d_r(j)*d_r(j)-1)));
    end 
    if(d_r(j)<1)
        phi= atan(sqrt((d_r(j)*d_r(j)-1)/d_r(j)));
        tp=atanh(-1i*tanh(-1i*phi))/(w_r* sqrt(d_r(j)*d_r(j)-1));
    else
        phi= atan(sqrt((d_r(j)*d_r(j)-1)/d_r(j)));
        tp=(phi-pi/2)/(w_r* sqrt(d_r(j)*d_r(j)-1));
    end 
    tr_l=[tr_l tr];
    tp_l=[tp_l tp];
    figure(1);
    title("impulse response variable epsilon");

    impulse(sys, 0:0.02:10);
    hold on;
end

figure(2);
disp(tr_l);
stem(d_r(1:7),abs(tr_l(1:7)));
title("risetime plot various damping");
ylabel("rise time");
xlabel("Epsilon");

figure(3);
disp(tp_l);
stem(d_r(1:7),abs(tp_l(1:7)));
title("peaktime plot various damping");
ylabel("peak time");
xlabel("Epsilon");


