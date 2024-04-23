w=10:180;
w=w.*(pi/180);
for i=1:length(w)
    Hw(i)=(0.6816-(0.1518*cos(2*w(i)))+(0.489*cos(w(i))));
end
plot(Hw)
plot(w.*(180/pi),20*log10(Hw))
