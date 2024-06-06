fs=20;
t=-(1/fs*40):1/fs:(1/fs*40);
f=0.5;
a=sin(2*pi*f*t);
subplot (331);
stem(t,a,'b',"filled");
title("sine wave");
xlabel("Time axis");
ylabel("Amplitude");
%-----------------------
b=cos(2*pi*f*t);
subplot (332);
stem(t,b,'b',"filled");
title("cosine wave");
xlabel("Time axis");
ylabel("Amplitude");
%-------------------------
c=t==0;
subplot (333);
stem(t,c,'b',"filled");
title("Unit impulse");
xlabel("Time axis");
ylabel("Amplitude");

%--------------------------
d=t>=0;
subplot (334);
stem(t,a,'b',"filled");
title("Unit step");
xlabel("Time axis");
ylabel("Amplitude");

%---------------------------
e=sinc(2*pi*f*t);
subplot (335);
stem(t,e,'b',"filled");
title("sinc wave");
xlabel("Time axis");
ylabel("Amplitude");

%---------------------------
g=abs(t)<1;
g=g.*(1-abs(t));
subplot (336);
stem(t,g,'b',"filled");
title("Triangular wave");
xlabel("Time axis");
ylabel("Amplitude");
%----------------------------
h=abs(t)<1;
subplot (337);
stem(t,h,'b',"filled");
title("square wave");
xlabel("Time axis");
ylabel("Amplitude");
%-------------------------
i=d.*t;
subplot (338);
stem(t,i,'b',"filled");
title("Ramp signal");
xlabel("Time axis");
ylabel("Amplitude");

%--------------------------
j=exp(t);
subplot (339);
stem(t,j,'b',"filled");
title("Exponential");
xlabel("Time axis");
ylabel("Amplitude");