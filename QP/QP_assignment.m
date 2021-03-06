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
dt = 3600;
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
    f1 = f1 + -2*dt*(T(i))^2+2*T(i+1)*dt*T(i)+2*T(i)*Tamb(i)*dt-2*T(i+1)*dt*Tamb(i);
    f2 = f2 + (2*(Qin(i)-Qout(i))*dt*T(i)-2*dt*T(i+1)*(Qin(i)-Qout(i)));
    h1 = h1 + ((T(i)^2)*dt^2+(Tamb(i)*dt)^2-2*Tamb(i)*T(i)^2*dt^2)*2;
    h2 = h2 + (-2*T(i)*dt^2*(Qin(i)-Qout(i))+2*(Qin(i)-Qout(i))*dt^2*Tamb(i))*2;
    h3 = 0;
    h4 = h4 + (dt^2*((Qout(i)^2) + (Qin(i)^2) - 2 * Qout(i) * Qin(i)))*2;
end

H = [h1 h2; h3 h4];
H = (H+H')/2;
f = [f1; f2];

a = quadprog(H,f);
Tnew = [];


for i = 1:(101 + E1)
    Thold = (-a(1) * T(i) - a(2) * Qout(i) + a(2) * Qin(i) + Tamb(i) * a(1)) * dt + T(i);
    Tnew = [Tnew; Thold];
end

x = linspace(0,1,111);
y = linspace(0,1,101 + E1);
plot(x,Tnew,x,T(1:111))


%% Question 3
dt = 3600;
heatDemand = csvread('heatDemand.csv',1,1);
inputPrices = csvread('inputPrices.csv',1,1);
N = 360;
QinMax = (100 + E2) * 10^3;         % [W]
Ttank = 330 + E3;                   % [K]
Tamb = 275 + E1;                    % [K]   
Tmin = 315;                         % [K]
a1 = 1.96 * 10^-7;
a2 = 3.80 * 10^-9;
correctPriceVar = 3600 * 10^6;
inputPrices = inputPrices / correctPriceVar;

f = [inputPrices(1:N,1)*dt; zeros(N+1,1)];
A = [zeros(N,N+1) -eye(N,N);
    eye(N,N) zeros(N,N+1);
    -eye(N,N) zeros(N,N+1)];
b = [-Tmin*ones(N,1); QinMax*ones(N,1); zeros(N,1)];

partSquareMatrixAeq = (a1 * dt - 1) * eye(N,N + 1);
for i = 1:N
    partSquareMatrixAeq(i,i+1) = 1;
end
partSquareMatrixAeq(1,1) = 0;

Aeq = [-eye(N)*a2*dt partSquareMatrixAeq];

beq = [-a2*heatDemand(1)*dt+a1*Tamb*dt+(1-a1*dt)*Ttank];

for i = 2:N
   beq(i,1) = -a2 * heatDemand(i,1) * dt + a1 * Tamb * dt;
end

%lb = zeros(1,2*N+1);
%ub = [ones(1,N)*QinMax Inf*ones(1,N+1)];
solution3 = linprog(f,A,b,Aeq,beq);

totalCost3 = 0;
for i = 1:N
    if size(solution3) ~= 0
        totalCost3 = totalCost3 + solution3(i,1) * inputPrices(i,1) * 3600;
    end
end


disp("the total cost of keeping the temperature to the minimum is equal to " + totalCost3 + " euros");


%% Question 4
Tmax = 368;                             % [K]
totalCost4 = 0;                         % [euro]
meanSquareErrorCost = 0.1 + E2/10;      % [euro/K^2]
Tref = 323;                             % [K]   

f = [inputPrices(1:N,1)*dt; zeros(N-1,1); -2*Tref*meanSquareErrorCost; zeros(1,1)];

H = [zeros(2*N+1,2*N+1)];
H(2*N,2*N) = 2*meanSquareErrorCost;

A = [zeros(N,N+1) -eye(N,N);
    eye(N,N) zeros(N,N+1);
    -eye(N,N) zeros(N,N+1);
    zeros(N,N+1) eye(N,N)];

b = [-Tmin*ones(N,1);
    QinMax*ones(N,1);
    zeros(N,1); 
    Tmax*ones(N,1)];

solution4 = quadprog(H,f,A,b,Aeq,beq);

for i = 1:N
    if size(solution4) ~= 0
        totalCost4 = totalCost4 + solution4(i,1) * inputPrices(i,1) * 3600;
    end
end

if size(solution4) ~= 0
    totalCost4 = totalCost4 + (solution4(end-1) - Tref)^2 * meanSquareErrorCost;
end
terminalCost = (solution4(end-1) - Tref)^2 * meanSquareErrorCost;
disp("the total cost of keeping the temperature to the minimum is equal to " + totalCost4 + " euros");
disp("the terminal cost is equal to " + terminalCost + " euros");



