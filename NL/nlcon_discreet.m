function [c,ceq] = nlcon_discreet(x)
    ceq = zeros(9,59);
    for i = 1:59
        xPlus1 = f(x(1:9,i),x(10:13,i));
        ceqHold = xPlus1 - x(1:9,i+1);
        ceq(1:9,i+1) = ceqHold;
    end
    c = [];
end