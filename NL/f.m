function xPlus1 = f(x,u)
    lengthOfRoadSegment = 1;        % [km]
    lambda = 3;                     % [number of roadsegments]
    timeStep = 10;                  % [s]
    K = 10;
    tau = 10;                       % [s]
    nu = 80;                        % [km^2/h]
    xPlus1 = zeros(size(x,1),1);
    
    % rho 1-4
    xPlus1(1) = x(1) + ...
                (timeStep / (lengthOfRoadSegment * lambda) * u(3))/60/60 - ...
                (timeStep / lengthOfRoadSegment * x(1) * x(5))/60/60;
    for i = 2:3
        xPlus1(i) = x(i) + ...
                    (timeStep / lengthOfRoadSegment) * ((x(i - 1) * x(i + 3)) - x(i) * x(i + 4))/60/60;
    end 
    xPlus1(4) = x(4) + ...
                (timeStep / lengthOfRoadSegment * x(3) * x(7))/60/60 - ...
                (timeStep / lengthOfRoadSegment * x(4) * x(8))/60/60 + ...
                (timeStep / (lengthOfRoadSegment * lambda) * g_r(x,u))/60/60;
    %v 1-4
    xPlus1(5) = x(5) + ...
                timeStep / tau * (V(x,u,5) - x(5)) + ...
                timeStep / tau * (x(5) * (x(5) - x(5)))/60/60 - ...
                nu * timeStep / (tau * lengthOfRoadSegment) * (x(2) - x(1)) / (x(1) + K);
    for i = 6:8
        if i == 8
            xPlus1(i) = x(i) + ...
                    timeStep / tau * (V(x,u,i) - x(i)) + ...
                    (timeStep / tau * x(i) * (x(i - 1) - x(i)))/60/60;
        else           
            xPlus1(i) = x(i) + ...
                        timeStep / tau * (V(x,u,i) - x(i)) + ...
                        (timeStep / tau * x(i) * (x(i - 1) - x(i)))/60/60 - ...
                        nu * timeStep / (tau * lengthOfRoadSegment) * (x(i-3) - x(i-4)) / (x(i-4) + K);
        end
    end 
    % w_r
    xPlusHold = timeStep * ((u(4) - g_r(x,u)))/(60*60);
    xPlus1(9) = x(9) + xPlusHold;
end