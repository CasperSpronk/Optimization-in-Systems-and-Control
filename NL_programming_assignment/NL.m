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
%% Question 3 no control
VSL = 120;

x1_11question3_no = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11question3_no= repmat(x1_11question3_no,1,11);

x12_60question3_no = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60question3_no = repmat(x12_60question3_no,1,49);

x0question3_no = [x1_11question3_no,x12_60question3_no];

lb1question3_no = [20; 20; 20; 20; 90 * ones(4,1); 0; speedLimit; 1; 7000+100*E1; 1500];

lb2_11question3_no = [0; 0; 0; 0; 60 * ones(4,1); 0; speedLimit; 1; 7000+100*E1; 1500];
lb2_11question3_no = repmat(lb2_11question3_no,1,10);

lb12_60question3_no = [0; 0; 0; 0; 60 * ones(4,1); 0; speedLimit; 1; 2000+100*E2; 1500];
lb12_60question3_no = repmat(lb12_60question3_no,1,49);

lbquestion3_no = [lb1question3_no,lb2_11question3_no,lb12_60question3_no];

ub1question3_no = [20; 20; 20; 20; 90 * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];

ub2_11question3_no = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];
ub2_11question3_no = repmat(ub2_11question3_no,1,10);

ub12_60question3_no = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 2000+100*E2; 1500];
ub12_60question3_no = repmat(ub12_60question3_no,1,49);

ubquestion3_no = [ub1question3_no,ub2_11question3_no,ub12_60question3_no];
%fun = @g;
nlconfunc = @nlcon;
xQuestion3_no = fmincon(@fun,x0question3_no,[],[],[],[],lbquestion3_no,ubquestion3_no,nlconfunc);
fun(xQuestion3_no)/60/60

%% Question 3 60 km/h
VSL = 60;

x1_11question3_60 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11question3_60 = repmat(x1_11question3_60,1,11);

x12_60question3_60 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60question3_60 = repmat(x12_60question3_60,1,49);

x0question3_60 = [x1_11question3_60,x12_60question3_60];

lb1question3_60 = [20; 20; 20; 20; 90 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];

lb2_11question3_60 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];
lb2_11question3_60 = repmat(lb2_11question3_60,1,10);

lb12_60question3_60 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 2000+100*E2; 1500];
lb12_60question3_60 = repmat(lb12_60question3_60,1,49);

lbquestion3_60 = [lb1question3_60,lb2_11question3_60,lb12_60question3_60];

ub1question3_60 = [20; 20; 20; 20; 90 * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];

ub2_11question3_60 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];
ub2_11question3_60 = repmat(ub2_11question3_60,1,10);

ub12_60question3_60 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 2000+100*E2; 1500];
ub12_60question3_60 = repmat(ub12_60question3_60,1,49);

ubquestion3_60 = [ub1question3_60,ub2_11question3_60,ub12_60question3_60];
%fun = @g;
nlconfunc = @nlcon;
xQuestion3_60 = fmincon(@fun,x0question3_60,[],[],[],[],lbquestion3_60,ubquestion3_60,nlconfunc);
TTS = 0;
fun(xQuestion3_60)/60/60


% figure('Name','current speed with VSL starting at 60 km/h')
% plot(xQuestion3_60(5,:))
% hold on
% plot(xQuestion3_60(6,:))
% hold on
% plot(xQuestion3_60(7,:))
% hold on
% plot(xQuestion3_60(8,:))
% title('Current speed per lane')
% legend('Lane 1','Lane 2','Lane 3','Lane 4')

%% Question 3 120 km/h
VSL = 120;

x1_11question3_120 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11question3_120 = repmat(x1_11question3_120,1,11);

x12_60question3_120 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60question3_120 = repmat(x12_60question3_120,1,49);

x0question3_120 = [x1_11question3_120,x12_60question3_120];

lb1question3_120 = [20; 20; 20; 20; 90 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];

lb2_11question3_120 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];
lb2_11question3_120 = repmat(lb2_11question3_120,1,10);

lb12_60question3_120 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 2000+100*E2; 1500];
lb12_60question3_120 = repmat(lb12_60question3_120,1,49);

lbquestion3_120 = [lb1question3_120,lb2_11question3_120,lb12_60question3_120];

ub1question3_120 = [20; 20; 20; 20; 90 * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];

ub2_11question3_120 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];
ub2_11question3_120 = repmat(ub2_11question3_120,1,10);

ub12_60question3_120 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 2000+100*E2; 1500];
ub12_60question3_120 = repmat(ub12_60question3_120,1,49);

ubquestion3_120 = [ub1question3_120,ub2_11question3_120,ub12_60question3_120];
%fun = @g;
nlconfunc = @nlcon;
xQuestion3_120 = fmincon(@fun,x0question3_120,[],[],[],[],lbquestion3_120,ubquestion3_120,nlconfunc);
TTS = 0;
fun(xQuestion3_120)/60/60

% figure('Name','current speed with VSL starting at 120 km/h')
% plot(xQuestion3_120(5,:))
% hold on
% plot(xQuestion3_120(6,:))
% hold on
% plot(xQuestion3_120(7,:))
% hold on
% plot(xQuestion3_120(8,:))
% title('Current speed per lane')
% legend('Lane 1','Lane 2','Lane 3','Lane 4')
%% Question 3 77.15 km/h
VSL = 77.15;

x1_11question3_77 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11question3_77 = repmat(x1_11question3_77,1,11);

x12_60question3_77 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60question3_77 = repmat(x12_60question3_77,1,49);

x0question3_77 = [x1_11question3_77,x12_60question3_77];

lb1question3_77 = [20; 20; 20; 20; 90 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];

lb2_11question3_77 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 7000+100*E1; 1500];
lb2_11question3_77 = repmat(lb2_11question3_77,1,10);

lb12_60question3_77 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 1; 2000+100*E2; 1500];
lb12_60question3_77 = repmat(lb12_60question3_77,1,49);

lbquestion3_77 = [lb1question3_77,lb2_11question3_77,lb12_60question3_77];

ub1question3_77 = [20; 20; 20; 20; 90 * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];

ub2_11question3_77 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 7000+100*E1; 1500];
ub2_11question3_77 = repmat(ub2_11question3_77,1,10);

ub12_60question3_77 = [rho_m * ones(4,1); speedLimit * ones(4,1); Inf; speedLimit; 1; 2000+100*E2; 1500];
ub12_60question3_77 = repmat(ub12_60question3_77,1,49);

ubquestion3_77 = [ub1question3_77,ub2_11question3_77,ub12_60question3_77];
%fun = @g;
nlconfunc = @nlcon;
xQuestion3_77 = fmincon(@fun,x0question3_77,[],[],[],[],lbquestion3_77,ubquestion3_77,nlconfunc);
TTS = 0;
fun(xQuestion3_77)/60/60
%% Question 4
rampMaxQueue = 20 - E3;

VSL = 60;

x1_11question4 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 7000+100*E1; 1500];
x1_11question4 = repmat(x1_11question4,1,11);

x12_60question4 = [20 * ones(4,1); 90 * ones(4,1); 0; VSL; 1; 2000+100*E2; 1500];
x12_60question4 = repmat(x12_60question4,1,49);

x0question3_120 = [x1_11question4,x12_60question4];

lb1question4 = [20; 20; 20; 20; 90 * ones(4,1); 0; 60; 0; 7000+100*E1; 1500];

lb2_11question4 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 0; 7000+100*E1; 1500];
lb2_11question4 = repmat(lb2_11question4,1,10);

lb12_60question4 = [0; 0; 0; 0; 60 * ones(4,1); 0; 60; 0; 2000+100*E2; 1500];
lb12_60question4 = repmat(lb12_60question4,1,49);

lbquestion4 = [lb1question4,lb2_11question4,lb12_60question4];

ub1question4 = [20; 20; 20; 20; 90 * ones(4,1); rampMaxQueue; speedLimit; 1; 7000+100*E1; 1500];

ub2_11question4 = [rho_m * ones(4,1); speedLimit * ones(4,1); rampMaxQueue; speedLimit; 1; 7000+100*E1; 1500];
ub2_11question4 = repmat(ub2_11question4,1,10);

ub12_60question4 = [rho_m * ones(4,1); speedLimit * ones(4,1); rampMaxQueue; speedLimit; 1; 2000+100*E2; 1500];
ub12_60question4 = repmat(ub12_60question4,1,49);

ubquestion4 = [ub1question4,ub2_11question4,ub12_60question4];
%fun = @g;
nlconfunc = @nlcon;
xQuestion4 = fmincon(@fun,x0question3_120,[],[],[],[],lbquestion4,ubquestion4,nlconfunc);
fun(xQuestion4)/60/60

% figure('Name','current speed with ramp meter on')
% plot(xQuestion4(5,:))
% hold on
% plot(xQuestion4(6,:))
% hold on
% plot(xQuestion4(7,:))
% hold on
% plot(xQuestion4(8,:))
% title('Current speed per lane')
% legend('Lane 1','Lane 2','Lane 3','Lane 4')


%% plots
figure('Name','Vsl')
plot(xQuestion3_no(10,:))
hold on
plot(xQuestion3_60(10,:))
hold on
plot(xQuestion3_120(10,:))
hold on 
plot(xQuestion3_77(10,:))
title('Vsl')
xlabel('k')
ylabel('Speed [km/h]')
legend('no control','question 3 initial guess 60 km/h','question 3 initial guess 120 km/h','question 3 initial guess 77.15 km/h')

figure('Name','Vsl question 4')
plot(xQuestion4(10,:))
title('Vsl')
xlabel('k')
ylabel('Speed [km/h]')
legend('question 4')

figure('Name','ramp queue')
plot(xQuestion3_no(9,:))
hold on
plot(xQuestion3_120(9,:))
hold on
plot(xQuestion3_60(9,:))
hold on
plot(xQuestion4(9,:))
title('ramp queue')
xlabel('k')
ylabel('cars')
legend('no control','question 3 initial guess 60 km/h','question 3 initial guess 120 km/h','question 4')

figure('Name','ramp metering rate')
plot(xQuestion4(11,:))
title('ramp metering rate')
xlabel('k')
ylabel('r(k)')
legend('question 4')


