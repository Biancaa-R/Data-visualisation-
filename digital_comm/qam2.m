decimal=18981;
order=16;
bin=de2bi(decimal,order,'left-msb');
bps=100;
noOfCycle=1;
n=4;
Tb=1/bps;
fc=bps*noOfCycle;
fs=32*fc;
t=[];
for i=1:n
    t=[t (i-1)*Tb:(1/fs):i*Tb];
end
x=(0:length(bin))*Tb;
M=2^n;
xl = (0:M-1)';
yl = qammod(xl,M);
a=real(yl);
b=imag(yl);
s=zeros(M,length(t));
for i=1:M
    s(i,:)=a(i)*cos(2*pi*fc*t)+b(i)*sin(2*pi*fc*t);
end
b='';
q=[];
t2=[];
for i=1:order
    b=append(b,num2str(bin(i)));
    if rem(i,4)==0
        q=[q bin2dec(b)];
        b='';
    end
    t2=[t2 (i-1)*Tb:(1/fs):i*Tb];
end
y=[];
for i=1:length(q)
    y=[y s(q(i)+1,:)];
end
subplot(3,1,1);
stairs(x,[bin bin(length(bin))],"LineWidth",2);
title("Input Signal");
subplot(3,1,3);
plot(t2,y);
title("QAM");
subplot(3,1,2);
stem(x(5:4:length(x)),q,"LineWidth",2);
title("Symbol");
axis([0 t2(length(t2)) 0 16]);