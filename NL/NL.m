% Made by: 
% Sven Geboers 4439686
% Casper Spronk 4369475
%% Setup
clc
clear all
D1sven = 6;
D2sven = 8;
D3sven = 6;
D1casper = 4;
D2casper = 7;
D3casper = 5;
E1 = (D1sven + D1casper) / 2;
E2 = (D2sven + D2casper) / 2;
E3 = (D3sven + D3casper) / 2;
%% constants
speedLimit = 120;               % [km/h]
lengthOfRoadSegment = 1;        % [km]
lambda = 3;                     % [number of roadsegments]
timeStep = 10;                  % [s]
K = 10;
tau = 10;                       % [s]
alpha = 0.1;
a = 2;
v_f = 110;                      % [km/h]
rho_c = 28;                     % [veh/km/lane]
nu = 80;                        % [km^2/h]
C_r = 2000;                     % [veh/h]
rho_m = 120;                    % [veh/km/lane]
%% Question 1
% u = [Vsl(k); r(k); q0(k); Dr(k)]

x = [20;
     20;
     20;
     20;
     90;
     90;
     90;
     90;
     0];
 u = [90;
      1;
      7000;
      1500];
  
x1 = f(x,u)
y1 = g(x,u)


function xPlus1 = f(x,u)
speedLimit = 120;               % [km/h]
lengthOfRoadSegment = 1;        % [km]
lambda = 3;                     % [number of roadsegments]
timeStep = 10;                  % [s]
K = 10;
tau = 10;                       % [s]
alpha = 0.1;
a = 2;
v_f = 110;                      % [km/h]
rho_c = 28;                     % [veh/km/lane]
nu = 80;                        % [km^2/h]
C_r = 2000;                     % [veh/h]
rho_m = 120;                    % [veh/km/lane]
    xPlus1 = zeros(size(x,1),1);
    % rho 1-4
    xPlus1(1) = x(1) + ...
                timeStep / lengthOfRoadSegment * x(1) * x(5) + ...
                timeStep / (lengthOfRoadSegment * lambda) * u(3);
    for i = 2:3
        xPlus1(i) = x(i) + (timeStep / lengthOfRoadSegment) * (x(i) * x(i + 4)  + x(i - 1) * x(i + 3)); 
    end 
    xPlus1(4) = x(4) + ...
                timeStep / lengthOfRoadSegment * x(3) * x(7) - ...
                timeStep / lengthOfRoadSegment * x(4) * x(8) + ...
                timeStep / (lengthOfRoadSegment * lambda) * qr(x,u);
    %v 1-4
    xPlus1(5) = x(5) + ...
                timeStep / tau * (V - x(5)) + ...
                T / tau * x(5) * (v0 - x(5)) - ...
                nu * timeStep / (tau * lengthOfRoadSegment) * (x(2) - x(1)) / (x(1) + K);
    for i = 6:8
        xPlus1(i) = x(i) + ...
                    timeStep / tau * (V - x(i)) + ...
                    T / tau * x(i) * (v(i - 1) - x(i)) - ...
                    nu * timeStep / (tau * lengthOfRoadSegment) * (x(i-3) - x(i-4)) / (x(i-4) + K);
    end 
    xPlus1(9) = x(9) + timeStep * (u(4) - qr(x,u));
end

function out = qr(x,u)
speedLimit = 120;               % [km/h]
lengthOfRoadSegment = 1;        % [km]
lambda = 3;                     % [number of roadsegments]
timeStep = 10;                  % [s]
K = 10;
tau = 10;                       % [s]
alpha = 0.1;
a = 2;
v_f = 110;                      % [km/h]
rho_c = 28;                     % [veh/km/lane]
nu = 80;                        % [km^2/h]
C_r = 2000;                     % [veh/h]
rho_m = 120;                    % [veh/km/lane]
    out = min([u(2) * C_r, ...
              u(4) + x(9) / timeStep, ...
              C_r * (rho_m - x(4)) / (rho_m - rho_c)]);
end

function y = g(x,u)
speedLimit = 120;               % [km/h]
lengthOfRoadSegment = 1;        % [km]
lambda = 3;                     % [number of roadsegments]
timeStep = 10;                  % [s]
K = 10;
tau = 10;                       % [s]
alpha = 0.1;
a = 2;
v_f = 110;                      % [km/h]
rho_c = 28;                     % [veh/km/lane]
nu = 80;                        % [km^2/h]
C_r = 2000;                     % [veh/h]
rho_m = 120;                    % [veh/km/lane]
    y = timeStep * x(9) + timeStep * lengthOfRoadSegment * lambda * (x(1) + x(2) + x(3) + x(4));
end




