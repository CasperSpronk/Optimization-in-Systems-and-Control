% Made by: 
% Sven Gebroers 4439686
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
E1 = D1sven + D1casper;
E2 = D2sven + D2casper;
E3 = D3sven + D3casper;
%% builds 
maxBatteryCells = (5 + E1) * 10^6;
batCellsR = 4 * 10^3;
batCellsW = 6 * 10^3;
buildTimeR = 10;                        % hours
buildTimeW = 15;                        % hours
%% Employees
employees = 100 + E2;
maxHoursEmp = 160;                                  % per month 
salary = 3000 + 50 * E3;                            % euros
totalSalary = employees * maxHoursEmp * salary;     % guarenteerd because of Unions
%% Storage
maxRoomAvailable = (15 + E3) * 10^3;    % [m^2]
roomNeededR = 10;                       % [m^2]
roomNeededW = 12;                       % [m^2]
timeStored = 1;                         % month
%% Price
priceR = 55000;     % euros
priceW = 75000;     % euros
productionCostsR = 30000;      % euros, excluding salary
productionCostsW = 45000;      % euros, excluding salary
%% question 1 & 2

%% question 3
limR = 1000; % cars per month 

%% question 4 & 5
reductionInTimePerWorker = 5 / 60;      % hours
maxNewWorkers = 72;                     % people
maxBatteryCellsNew = (8 + E1) * 10^6;
maxRoomAvailableNew = (22 + E3) + 10^3;    % [m^2]

%% question 6
minProductionR = 1250;      % cars
minProductionW = 1000;      % cars
batCellsV = 2 * 10^3;
roomNeededV = 8;            % [m^2]
buildTimeV = 8;             % hours
productionCostsV = 15000;   % euros
priceV = 45000;             % euros
minProductionV = 1500;      % cars













