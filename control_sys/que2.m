%que 2'
syms t
f=1+0.2*exp(-60*t)-1.2*exp(-10*t);
value=laplace(f)*1/s;
disp((value));
num=[600];
den=[1 70 600];
tf1=tf(num,den);
value=stepinfo(tf1);
disp(value);