function [c,ceq] = nlcon(x)
    ceq = zeros(9,59);
    for i = 1:59
        for j = 1:9
            xPlus1 = f(x(1:9,i),x(10:13,i));
            ceqHold = xPlus1 - x(1:9,i+1);
            ceq(1:9,i) = ceqHold;
        end
    end
    c = [];
end