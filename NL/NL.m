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

 
%% Question 2
x0 = [20 * ones(4,1); 90 * ones(4,1); 0; 120; 1];
x0 = repmat(x0,1,60);
lb = [0, 0, 0, 0, 60 * ones(1,4), 0, 60, 1];
lb = repmat(lb,1,60);
ub = [rho_m * ones(1,4), speedLimit * ones(1,4), 0, speedLimit, 1];
ub = repmat(ub,1,60);
%fun = @g;
nlconfunc = @nlcon;
x = fmincon(fun,x0,[],[],[],[],lb,ub,nlconfunc);
TTS = 0;
for i = 1:size(x0)/2
    TTS = TTS + g(x);
end
TTS = TTS / 60 / 60;
disp(TTS);
%% functions 








