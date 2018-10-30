function funvalue = fun(x)                   % output in seconds * cars
    lengthOfRoadSegment = 1;        % [km]
    lambda = 3;                     % [number of roadsegments]
    timeStep = 10;                  % [s]
    funvalue = 0;
    for i = 1:60
        funvalue = funvalue + g(x(:,i));
    end
end