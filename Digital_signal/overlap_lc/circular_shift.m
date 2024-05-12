function X=circular_shift(x)

X=x;

for i=1:length(x)-1
   X(i+1,:)= circshift(x, [0,i]);
end

X=X';

end