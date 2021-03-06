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
employees = 100 + E2;                   % people
maxHoursEmp = 160;                      % hours
totalHours = maxHoursEmp * employees;   % per month 
salary = 3000 + 50 * E3;                % euros
totalSalary = employees * salary;       % guarenteerd because of Unions
%% Storage
maxRoomAvailable = (15 + E3) * 10^3;    % [m^2]
roomNeededR = 10;                       % [m^2]
roomNeededW = 12;                       % [m^2]
timeStored = 1;                         % month
%% Price
priceR = 55000;                         % euros
priceW = 75000;                         % euros
productionCostsR = 30000;               % euros, excluding salary
productionCostsW = 45000;               % euros, excluding salary
profitR = priceR - productionCostsR;    % euros
profitW = priceW - productionCostsW;    % euros
%% question 1 & 2
f2 = [-profitR -profitW];
A2 = [batCellsR batCellsW; 
    buildTimeR buildTimeW; 
    roomNeededR roomNeededW;
    -1 0;
    0 -1];
b2 = [maxBatteryCells; 
    totalHours; 
    maxRoomAvailable;
    0;
    0];
question2 = linprog(f2,A2,b2);
disp("optimal solution for question 1 is")
disp("optimal R = " + floor(question2(1)));
disp("optimal W = " + floor(question2(2)));
%% question 3
limR = 1000; % cars per month 
f3 = [-profitR -profitW];
A3 = [batCellsR batCellsW; 
    buildTimeR buildTimeW; 
    roomNeededR roomNeededW;
    1 0;
    -1 0;
    0 -1];
b3 = [maxBatteryCells; 
    totalHours; 
    maxRoomAvailable;
    limR;
    0
    0];
question3 = linprog(f3,A3,b3);
disp("optimal solution for question 3 is")
disp("optimal R = " + floor(question3(1)));
disp("optimal W = " + floor(question3(2)));
%% question 4 & 5
% the results
reductionInTimePerWorker = 5 / 60;          % hours
maxNewWorkers = 72;                         % people
maxBatteryCellsNew = (8 + E1) * 10^6;
maxRoomAvailableNew = (22 + E3) * 10^3;     % [m^2]
f5 =   [-profitR -profitW];
A5 =   [batCellsR batCellsW; 
        buildTimeR buildTimeW; 
        roomNeededR roomNeededW;
        1 0;
        -1 0;
        0 -1];
b5 =   [maxBatteryCellsNew; 
        totalHours; 
        maxRoomAvailableNew;
        limR;
        0
        0];
question5 = linprog(f5,A5,b5);
currentProfit = profitR * floor(question5(1)) + profitW * floor(question5(2)) - totalSalary;
% this for loop check if the marginal employee has been hired, should this
% be run agian the loop will return the value that is correct for question
% 5
for i = 0:1:maxNewWorkers
    newBuildTimeR = buildTimeR - 5/60;
    newBuildTimeW = buildTimeW - 5/60;
    newTotalHours = totalHours + 160;
    newTotalSalary = totalSalary + salary;
    f5 =   [-profitR -profitW];
    A5 =   [batCellsR batCellsW; 
            newBuildTimeR newBuildTimeW; 
            roomNeededR roomNeededW;
            1 0;
            -1 0;
            0 -1];
    b5 =   [maxBatteryCellsNew; 
            newTotalHours; 
            maxRoomAvailableNew;
            limR;
            0
            0];
    question5new = linprog(f5,A5,b5);
    newProfit = profitR * floor(question5new(1)) + profitW * floor(question5new(2)) - newTotalSalary;
    if newProfit < currentProfit || i == maxNewWorkers
        if i ~= 0
            newWorkers = i;
        end
        disp("optimal new number of workers is " + newWorkers);
        disp("optimal solution for question 5 is")
        disp("optimal R = " + floor(question5(1)));
        disp("optimal W = " + floor(question5(2)));
        break
    end
    currentProfit = newProfit;
    question5 = question5new;
    buildTimeR = newBuildTimeR;
    buildTimeW = newBuildTimeW;
    totalHours = newTotalHours;
    totalSalary = newTotalSalary;
end

%% question 6
minProductionR = 1250;                  % cars
minProductionW = 1000;                  % cars
batCellsV = 2 * 10^3;
roomNeededV = 8;                        % [m^2]
buildTimeV = 8;                         % hours
productionCostsV = 15000;               % euros
priceV = 45000;                         % euro
profitV = priceV - productionCostsV;    % euros
minProductionV = 1500;                  % cars

f6a =  [-profitR -profitW -profitV];
A6a =  [batCellsR batCellsW batCellsV; 
        buildTimeR buildTimeW buildTimeV; 
        roomNeededR roomNeededW roomNeededV;
        -1 0 0;
        0 -1 0
        0 0 -1];
b6a =  [maxBatteryCellsNew; 
        totalHours; 
        maxRoomAvailableNew;
        -minProductionR
        -minProductionW
        -minProductionV];
question6a = linprog(f6a,A6a,b6a);

if not(isempty(question6a))
    profit6a = profitR * floor(question6a(1)) + profitW * floor(question6a(2)) + profitV * floor(question6a)- totalSalary;
end
f6b =  [-profitR -profitW];
A6b =  [batCellsR batCellsW; 
        buildTimeR buildTimeW; 
        roomNeededR roomNeededW;
        -1 0;
        0 -1]; 
b6b =  [maxBatteryCellsNew; 
        totalHours; 
        maxRoomAvailableNew;
        -minProductionR
        -minProductionW];
question6b = linprog(f6b,A6b,b6b);

if not(isempty(question6b))
    profit6b = profitR * floor(question6b(1)) + profitW * floor(question6b(2)) - totalSalary;
end

if isempty(question6a)
    if isempty(question6b)
        disp("there is no optimal solution")
    else
        disp("optimal solution for question 6 is")
        disp("optimal R = " + floor(question6b(1)));
        disp("optimal W = " + floor(question6b(2)));
        disp("the optimal solution was to not produce the model V");
    end
else
    if profit6a > profit6b
        disp("optimal solution for question 6 is")
        disp("optimal R = " + floor(question6a(1)));
        disp("optimal W = " + floor(question6a(2)));
        disp("optimal V = " + floor(question6a(1)));
    else
        disp("optimal solution for question 6 is")
        disp("optimal R = " + floor(question6b(1)));
        disp("optimal W = " + floor(question6b(2)));
    end
end