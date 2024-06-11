function X=circular_shift(x)

X=x;

for i=1:length(x)-1
   X(i+1,:)= circshift(x, i);
end

X=X';

end

%{
circular_shift([1 2 3 4 5])

ans =

     1     5     4     3     2
     2     1     5     4     3
     3     2     1     5     4
     4     3     2     1     5
     5     4     3     2     1

u=circshift([1 2 3 4 5],0);
u

u =

     1     2     3     4     5

u=circshift([1 2 3 4 5],1);
u

u =

     5     1     2     3     4

u=circshift([1 2 3 4 5],2);
u

u =

     4     5     1     2     3
%}