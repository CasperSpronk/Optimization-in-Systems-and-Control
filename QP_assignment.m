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
%% Read CSV
measurements = csvread('measurements.csv',1,1);
Qin = measurements(:,1);
Qout = measurements(:,2);
T = measurements(:,3);
Tamb = measurements(:,4);
%% Question 1
tDelta = 3600;
%B = [-a2 a2];
%A = -a1;
%ck = Tamb * a1;
f1 = 0;
f2 = 0;
h1 = 0;
h2 = 0;
h3 = 0;
h4 = 0;
for i = 1:(101 + E1)
    f1 = f1 + -2 * T(i+1) * T(i) + 2 * T(i+1) * Tamb(i);
    f2 = f2 + 2 * T(i+1) * (Qin(i) - Qout(i));
    h1 = h1 + ((T(i)^2) + (Tamb(i)^2) - 2 * T(i) * Tamb(i)) * 2;
    h2 = h2 + -T(i) * (Qin(i) - Qout(i));
    h3 = h3 + 2 * (Qin(i) - Qout(i)) * Tamb(i) *2;
    h4 = h4 + ((Qout(i)^2) + (Qin(i)^2) + 2 * Qout(i) * Qin(i)) * 2;
end
H = [h1 h2; h3 h4];
f = [f1; f2];

a = quadprog(H,f);
Tnew = [];
for i = 1:(101 + E1)
    Thold = -a(1) * T(i) - a(2) * Qout(i) + a(2) * Qin(i) + Tamb(i) * a(1);
    Tnew = [Tnew; Thold];
end

x = linspace(0,1,150);
y = linspace(0,1,111);
plot(x,T,y,Tnew)

%% Question 3
heatDemand = csvread('heatDemand.csv',1,1);
inputPrices = csvread('inputPrices.csv',1,1);
N = 360;
QinMax = (100 + E2) * 10^3;         % [W]
Ttank = 330 + E3;                      % [K]
Tamb = 275 + E1;                    % [K]   
Tmin = 315;                         % [K]
a1 = 1.96 * 10^-7;
a2 = 3.80 * 10^-9;
correctPriceVar = 60 * 10^6;
inputPrices = inputPrices * correctPriceVar;

for i = 1:N
    f = [inputPrices(i)*tDelta 0];
    A = [1 0;
         -1 0
         0 -1];
    b = [QinMax;
        0;
        Tmin];  
    Aeq = [a2 a1];
    
    
    
    linprog(f,A,b,Aeq,beq)
end







