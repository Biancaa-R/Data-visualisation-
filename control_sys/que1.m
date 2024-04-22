%que 1
d_r=0.5;
k=1;
den=[1 10 k];
w_r=den(2)/(2*d_r);
k=w_r*w_r;
num=[k];

tf1=tf(num,den);
value=stepinfo(tf1);
disp(value);