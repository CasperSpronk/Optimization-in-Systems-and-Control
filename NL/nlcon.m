function [c,ceq] = nlcon(x)
    for i = 1:59
        for j = 1:9
            ceq = f(x(1:9,i),x(10:13,i)) - x(j,i+1);
        end
    end
    c = [];
end