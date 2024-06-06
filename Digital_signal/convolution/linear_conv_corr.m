%LINEAR CONV AND CORR:
t=-3:1:3;
x=[ 0 0 1 2 3 4 0];
h=[1 2 1 1 0 0 0];
conv=[0 0 0 0 0 0 0];
corr=conv;
foldh=flip(h);
for k=1:7
    shiftedfh=circshift(foldh,k+2);
    mult=x.*shiftedfh;
    conv(k)=sum(mult);
    shiftedh=circshift(h,k-2);
    multx=x.*shiftedh;
    corr(k)=sum(multx);
end

%---------------------
subplot(2,2,1);
stem(t,x,'b',"filled");
title("Input sequence");
xlabel("Time axis");
ylabel("Amplitude");

subplot(2,2,2);
stem(t,h,'b',"filled");
title("H sequence");
xlabel("Time axis");
ylabel("Amplitude");

subplot(2,2,3);
stem(t,conv,'b',"filled");
title("convolution sequence");
xlabel("Time axis");
ylabel("Amplitude");

subplot(2,2,4);
stem(t,corr,'b',"filled");
title("correlation sequence");
xlabel("Time axis");
ylabel("Amplitude");