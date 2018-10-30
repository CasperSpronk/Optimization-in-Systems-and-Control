function y = g(x)                   % output in seconds * cars
    lengthOfRoadSegment = 1;        % [km]
    lambda = 3;                     % [number of roadsegments]
    timeStep = 10;                  % [s]
    y = timeStep * x(9) + timeStep * lengthOfRoadSegment * lambda * (x(1) + x(2) + x(3) + x(4));
end