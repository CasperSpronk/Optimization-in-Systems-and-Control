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
VSL = 120;

x1_11 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11 = repmat(x1_11,1,11);

x12_60 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60 = repmat(x12_60,1,49);

x0 = [x1_11,x12_60];

lb1 = [20; 20; 20; 20; 90 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];

lb2_11 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];
lb2_11 = repmat(lb2_11,1,10);

lb12_60 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 2000+100*E2; 1500];
lb12_60 = repmat(lb12_60,1,49);

lb = [lb1,lb2_11,lb12_60];

ub1 = [20; 20; 20; 20; 90 * ones(4,1); 0; speedLimit; 1; 7000+100*E1; 1500];

ub2_11 = [rho_m * ones(4,1); speedLimit * ones(4,1); 0; speedLimit; 1; 7000+100*E1; 1500];
ub2_11 = repmat(ub2_11,1,10);

ub12_60 = [rho_m * ones(4,1); speedLimit * ones(4,1); 0; speedLimit; 1; 2000+100*E2; 1500];
ub12_60 = repmat(ub12_60,1,49);

ub = [ub1,ub2_11,ub12_60];
%fun = @g;
nlconfunc = @nlcon;
x = fmincon(@fun,x0,[],[],[],[],lb,ub,nlconfunc);
TTS = 0;
fun(x)/60/60








