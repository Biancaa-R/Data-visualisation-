%CIRCULAR SHIFT:
function circ_shift1(x)
    X=x;
    for i=1:length(X)-1
        X(i+1,:)=circshift(x,i);
    end
    X=X';
    disp(X);
end