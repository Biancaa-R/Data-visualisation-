clear;
close all;
h=[3,2,1,1];
x=[1,2,3,3,2,1,-1,-2,-3,5,6,-1,2,0,2,1];
m=length(h);
n=7;
l=n-m+1;
h1=[h,zeros(1,l-1)];
x1=[x,zeros(1,m)];
x11=[x1((l-m+1):(2*2))];
x111=[x11,zeros(1,l-1)];
x12=[x1((l+m-3):(2*l))];
x121=[x12,zeros(1,l-1)];
x13=[x1((l+m+1):(2*6))];
x131=[x13,zeros(1,l-1)];
x14=[x1((l+m+5):(2*8))];
x141=[x14,zeros(1,l-1)];
for i=1:length(h1)
 for j=1:length(h1)
 H(i,j)=h1(mod((i-j),length(h1))+1);
 end
end
y1=(H*x111')';
y2=(H*x121')';
y3=(H*x131')';
y4=(H*x141')';
y= [y1(1:end-3) y1(end-2:end) + y2(1:m-1) y2(m:end-3) y2(end-2:end)+y3(1:m-1) +y3(m:end-3) y3(end-2:end) + y4(1:m-1 ) y4(m:end-3) y4(end-2:end)]
