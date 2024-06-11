clc;
clear all;
close all;
t=-3:1:3;
x=[0 0 1 2 3 4 0 ];
subplot(2,2,1);
stem(t,x,"k");
title("DT Signal 1");
xlabel("time[n]");
ylabel("Amplitude");
h=[1 2 1 1 0 0 0];
subplot(2,2,2);
stem(t,h,"k");
title("DT Signal 2");
xlabel("time[n]");
ylabel("Amplitude");
con=[0 0 0 0 0 0 0];
corr=con;
foldh=flip(h);
for k=1:7
    shiftedfh=circshift(foldh,k+2);
    mult=x.*shiftedfh;
    con(k)=sum(mult);
    shiftedh=circshift(h,k-2);
    multc=x.*shiftedh;
    corr(k)=sum(multc);
end
subplot(2,2,3);
stem(con,"k");
title("Linear Convolution");
xlabel("index");
ylabel("Amplitude");
subplot(2,2,4);
stem(corr,"k");
title("Cross Correlation");
xlabel("lag");
ylabel("Amplitude");

