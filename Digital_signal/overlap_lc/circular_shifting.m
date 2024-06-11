function X=circular_shifting(x)
    X=x;
    for i=1:length(x)-1
        X(i+1,:)=circshift(x,i);
    end
    X=X';