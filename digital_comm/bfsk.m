%bfsk:
disp("Enter the number of bits:");
bits=input("number:");
array=[];
for(m=1:bits)
    array(m)=input("Enter the bit value");
end

Om=input("Enter omega value");
omega=Om/(2*pi);
fc=10000;
f1=fc+omega;
f2=fc-omega;
%Tb=0.1;
sampling_rate=100;
tend=bits*Tb;
t=0:1/sampling_rate:tend;
%s1=sin(2*pi*f1*t);
%S2=sin(2*pi*f2*t);
bfsk_signal = zeros(1, length(t));
figure;
for(m=1:bits)
    t_idx = (m-1)*sampling_rate + 1:m*sampling_rate; 
    if array(m)==1
        bfsk_signal(t_idx)=array(m)*sin(2*pi*f1*t_idx);
    else
        bfsk_signal(t_idx)=array(m)*sin(2*pi*f2*Tb);
    end
end

