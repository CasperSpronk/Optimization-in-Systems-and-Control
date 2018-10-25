function [c,ceq] = nlcon(x)
    for i = 1:60
        for j = 1:9
            ceq = f(x(i,j),) - x(i+1,j);
        end
    end
end