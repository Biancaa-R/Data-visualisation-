clc;
clear all;
close all;

d_r=[0,0.1,0.5 ,0.9,1.0,1.5,2];
w_r=12;
tr_l=[];
tt_l=[];
p_l=[];
pt_l=[];

for i=1:7
    num=[w_r*w_r];
    den=[1 2*d_r(i)*w_r w_r*w_r];
    sys=tf(num,den);
    figure(1);
    title("Step_response_variable_epsilon");

    step(sys, 0:0.02:10);
    hold on;
    a=stepinfo(sys);
    disp(a);
    tr=a.RiseTime;
    tt=a.TransientTime;
    p=a.Peak;
    pt=a.PeakTime;

    tr_l=[tr_l tr];
    tt_l=[tt_l tt];
    p_l=[p_l p];
    pt_l=[pt_l pt];
    
end
lgd = legend({'E=0','E=0.1','E=0.5','E=0.9','E=1.0','E=1.5','E=2'},'FontSize',10,'TextColor','black');
lgd.NumColumns = 2;
disp(tr_l);

%for i=1:7
    %if tr_l(i) isnan
        %idx=isnan(tr_l(i));
        %tr_l(idx)=0;
    %end
%end
figure(2);
stem(d_r(2:7),tr_l(2:7));
title("risetime plot various damping");
ylabel("rise time");
xlabel("Epsilon");

figure(3);
plot(d_r(2:7),tt_l(2:7),'Linewidth',3);
hold on;
stem(d_r(2:7),tt_l(2:7));
title("Transient time plot various damping");
ylabel("Transient time");
xlabel("Epsilon");

figure(4);
stem(d_r(2:7),p_l(2:7));
title("Peak plot various damping");
ylabel("peak value");
xlabel("Epsilon");

figure(5);
stem(d_r(2:7),pt_l(2:7),'k','filled');
title("peaktime plot various damping");
ylabel("peaktime time");
xlabel("Epsilon");




