% Chebyshev filter design
clc;
clear all;
close all;

fsamp= 8000;
f1= 500;
f2= 1500;
f3= 2500;
order=1024;

% constants
% input signals
t= 0:(1/fsamp):0.1;
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
x3 = sin(2*pi*f3*t);
x = x1+x2+x3;

for i=1:order
    if i <= order/2
        fr(i)=i*(fsamp/order);
    else
        fr(i) = (order-i+1)*(fsamp/order);
    end
end

% Bandstop filter design
fp= [1300 1700]; 
fs= [1100 1900]; 
fp1= 1000;
fs1= 2000; 
wp= (2*fp)/fsamp;
ws= (2*fs)/fsamp;
wp1= (2*fp1)/fsamp;
ws1= (2*fs1)/fsamp;
ap= 0.5;
as= 40;


% Filter and plot
y = filter_design(wp1, ws1, ap, as,fr,order,x,fsamp,'c',1,'l');
y = filter_design(wp1, ws1, ap, as,fr,order,x,fsamp,'c',2,'l');

y = filter_design(wp1, ws1, ap, as,fr,order,x,fsamp,'c',1,'h');
y = filter_design(wp1, ws1, ap, as,fr,order,x,fsamp,'c',2,'h');

y = filter_design(wp, ws, ap, as,fr,order,x,fsamp,'c',1,'s');
y = filter_design(wp, ws, ap, as,fr,order,x,fsamp,'c',2,'s');

y = filter_design(wp, ws, ap, as,fr,order,x,fsamp,'c',1,'p');
y = filter_design(wp, ws, ap, as,fr,order,x,fsamp,'c',2,'p');

function y = filter_design(wp,ws,ap,as,fr,order,x,fsamp,k,t,action)
    if (k=='c'&& t==2 && action=='s')
        [N,Ws]=cheb2ord(wp,ws,ap,as);
        [b,a]= cheby2(N,as,Ws,'stop');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if (k=='c'&& t==1 && action=='s')
        [N,Wp]=cheb1ord(wp,ws,ap,as);
        [b,a]= cheby1(N,ap,Wp,'stop');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if (k=='c'&& t==2 && action=='p')
        [N,Ws]=cheb2ord(wp,ws,ap,as);
        [b,a]= cheby2(N,as,Ws,'bandpass');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if (k=='c'&& t==1 && action=='p')
        [N,Wp]=cheb1ord(wp,ws,ap,as);
        [b,a]= cheby1(N,ap,Wp,'bandpass');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if(k=='c'&& t==1 && action=='l')
        [N,Wp]=cheb1ord(wp,ws,ap,as);
        [b,a]= cheby1(N,ap,Wp,'low');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if(k=='c'&& t==2 && action=='l')
        [N,Ws]=cheb2ord(wp,ws,ap,as);
        [b,a]= cheby2(N,as,Ws,'low');
        [h,f]= freqz(b,a,order/2,fsamp);
    end
   
    if(k=='c'&& t==1 && action=='h')
        [N,Wp]=cheb1ord(wp,ws,ap,as);
        [b,a]= cheby1(N,ap,Wp,'high');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    if(k=='c' && t==2 && action=='h')
        [N,Ws]=cheb2ord(wp,ws,ap,as);
        [b,a]= cheby2(N,as,Ws,'high');
        [h,f]= freqz(b,a,order/2,fsamp);
    end

    y = filter(b,a,x);
    fft_y1 = fft(y,order);
    % input spectrum
    fft_x=fft(x,order);
    graph(fft_y1,fft_x,h,fr,order,k,t,action);

end

function graph(fft_y1,fft_x,h,fr,order,k,t,action)
    figure;
    subplot(311)
    plot(fr(1:order/2),abs(fft_x(1:order/2)),'b');
    title('Input Sequence x');
    xlabel('Frequency');
    ylabel('Magnitude');
    subplot(312) %gain
    h1=abs(h)/max(abs(h));
    plot(fr(1:order/2),(h1(1:order/2)),'k');
    title('Gain Plot');
    xlabel('Frequency'); 
    ylabel('Amplitude');
    subplot(313) %output
    plot(fr(1:order/2),abs(fft_y1(1:order/2)),'r');
    if (k=='c' && t=='1' && action=='l')
        title('Output sequence - Low pass chebyshev filter type1');
    end

    if (k=='c' && t=='2' && action=='l')
        title('Output sequence - Low pass chebyshev filter type2');
    end

    if (k=='c' && t=='2' && action=='h')
        title('Output sequence - High pass chebyshev filter type2');
    end
    if (k=='c' && t=='1' && action=='l')
        title('Output sequence - High pass chebyshev filter type 1');
    end

    if (k=='c' && t=='1' && action=='p')
        title('Output sequence - band pass chebyshev filter type1');
    end

    if (k=='c' && t=='2' && action=='p')
        title('Output sequence - band pass chebyshev filter type2');
    end

    if (k=='c' && t=='1' && action=='s')
        title('Output sequence - Band stop chebyshev filter type 1');
    end

    if (k=='c' && t=='2' && action=='s')
        title('Output sequence -Band stop chebyshev filter type2');
    end
    
    
    xlabel('Frequency'); ylabel('Amplitude');
end