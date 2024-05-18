%bode plot as Grv sir is killing us just before cats
%n=[10 100];
%d=[1 7 10 0];
n=[1];
d=[0.1 1.1 1 0];
a=-2;
b=2;
w=logspace(a,b);
sys_tf=tf(n,d);
figure;
bode(sys_tf,w);
grid on;
[gm, pm, gcf ,pcf]=margin(n,d);
value=[gm, pm, gcf ,pcf];
disp(value);
gm_db = 20 * log10(gm);  % Convert gm to dB
disp(gm_db);
%CL = feedback(sys_tf,1);
%disp(CL);
%bro what is wrong with you ? why ? eee guy
%typical
gm_des=30;
gm_mag=-(gm_des-gm_db);
%20 log k= offset
k=power(10,gm_mag/20);
sys_tf=tf(k*n,d);
figure;
bode(sys_tf,w);
grid on;
[gm, pm, gcf ,pcf]=margin(k*n,d);
value=[gm, pm, gcf ,pcf];
disp(value);
gm_db = 20 * log10(gm);  % Convert gm to dB
disp(gm_db);
