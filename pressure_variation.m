% Pressure variation script 
clc; clear all

black="#000000";
blue="#0072BD";
orange="#D95319";
lblue="#4DBEEE";
red="#A2142F";

day_index = [4,5];
P_day1 = [105.58, 110.92, 130.45, 145.60, 159.55]; % [kPa]
P_day2 = [105.52, 115.65, 130.35, 145.52, 160.52]; % [kPa]

d2_mean = 0.01826; % from the second reflection [m]

% path_optim = {'/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.25_11.57.38_RIO_Log.xlsx',
              % '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.31_12.09.34_RIO_Log.xlsx'};

path_BGA = {'/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230525_entire day.xlsx',
            '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230531.xlsx'};

path_XEN = {'/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-25-04DC44_X#1.xlsx',
            '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-31-04DC44_X#1.xlsx'};

SOS_optim=[]; SOS_BGA=[]; SOS_NTP_BGA=[]; TCD_XEN=[];

for i=1:length(day_index)

    % [t1_mean,t2_mean,T1_mean,T2_mean] = Ultrasonic_extract(path_optim{i},day_index(i)+1); % WRONG!(deviating points are taken into considerate)
    [SOS_mean,SOS_NTP_mean,T_mean] = BGA_extract(path_BGA{i},day_index(i)); 
    [trans_mean, Tsens_mean] = Xensor_extract(path_XEN{i},day_index(i));

    % SOS_optim = [SOS_optim, d2_mean./(t2_mean*10^-6)]; % WRONG!(deviating points are taken into considerate)
    SOS_BGA = [SOS_BGA, SOS_mean];
    SOS_NTP_BGA = [SOS_NTP_BGA, SOS_NTP_mean];
    TCD_XEN = [TCD_XEN, 1./(trans_mean*1.65)*1000];    % [mW/mK]
end

% Manual removal of deviating points, which after values have been averaged based on time-stamps 
t_optim = [40.29,40.2868,40.2965,40.3054,40.3117, 40.2344, 40.2203, 40.2178, 40.2149, 40.2157];
SOS_optim = d2_mean./(t_optim*10^-6);

% Absolute difference
% ----------------------------------------------------------------------------------
day1_BGA = SOS_BGA(1:5); 
day2_BGA = SOS_BGA(6:end); 

day1_optim = SOS_optim(1:5); 
day2_optim = SOS_optim(6:end); 

day1_XEN = TCD_XEN(1:5); 
day2_XEN = TCD_XEN(6:end); 

% f1=figure(1);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(P_day1,day1_BGA,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(P_day2,day2_BGA,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
% % plott(3)=plot(P_day1,SOS_NTP_BGA(1:5),"--",'Color',black,'LineWidth',4,'MarkerSize',12);
% % plott(4)=plot(P_day2,SOS_NTP_BGA(6:end),"--",'Color',lblue,'LineWidth',4,'MarkerSize',12);
% ylabel("Speed of sound [m/s]")
% xlabel("Pressure [kPa]")
% legend('1/0','0.982/0.012','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

f2=figure(2);
hold on; grid on;
plott=zeros(1,2);
plott(1)=plot(P_day1,day1_optim,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(P_day2,day2_optim,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
ylabel("Speed of sound [m/s]")
xlabel("Pressure [kPa]")
legend('1/0','0.982/0.012','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off
% 
% f3=figure(3);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(P_day1,day1_XEN,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(P_day2,day2_XEN,"-s",'Color',orange,'LineWidth',4,'MarkerSize',12);
% ylabel("Thermal conductivity [mW/mK]")
% xlabel("Pressure [kPa]")
% legend('1/0','0.982/0.012','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% sens_bga_1 = (day1_BGA(1)-day1_BGA(end))/(P_day1(1)-P_day1(end));
% sens_bga_2 = (day2_BGA(1)-day2_BGA(end))/(P_day2(1)-P_day2(end));

sens_optim_1 = (day1_optim(1)-day1_optim(end))/(P_day1(1)-P_day1(end));
sens_optim_2 = (day2_optim(1)-day2_optim(end))/(P_day2(1)-P_day2(end));

% sens_optim_methane=(454.116-453.962)/(130.45-159.55);


% Relative difference
% ----------------------------------------------------------------------------------
for i=1:length(day1_optim)
    day1_rel_BGA(i)=(day1_BGA(i)-day1_BGA(1))/day1_BGA(1);
    day2_rel_BGA(i)=(day2_BGA(i)-day2_BGA(1))/day2_BGA(1);

    day1_rel_optim(i)=(day1_optim(i)-day1_optim(1))/day1_optim(1);
    day2_rel_optim(i)=(day2_optim(i)-day2_optim(1))/day2_optim(1);

    day1_rel_XEN(i)=(day1_XEN(i)-day1_XEN(1))/day1_XEN(1);
    day2_rel_XEN(i)=(day2_XEN(i)-day2_XEN(1))/day2_XEN(1);
end


% f4=figure(4);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(P_day1,day1_rel_BGA,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(P_day2,day2_rel_BGA,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel("Pressure [kPa]")
% title('BGA')
% legend('1/0','0.982/0.012','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% 
% f5=figure(5);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(P_day1,day1_rel_optim,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(P_day2,day2_rel_optim,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel("Pressure [kPa]")
% title('opTim')
% legend('1/0','0.982/0.012','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% % 
% f6=figure(6);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(P_day1,day1_rel_XEN,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(P_day2,day2_rel_XEN,"-s",'Color',orange,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel("Pressure [kPa]")
% title('XEN-TCG3880')
% legend('1/0','0.982/0.012','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% Implementation of pressure correction
% ----------------------------------------------------------------------------------
compos = [0,1.2];
P_corr_coeff_SOS = 0.0034;
P_corr_coeff_TCD = 0.6583e-3;
P_corr = 101.3; % [kPa]

BGA_corr = SOS_BGA + P_corr_coeff_SOS*(P_corr-[P_day1 P_day2]);
optim_corr = SOS_optim + P_corr_coeff_SOS*(P_corr-[P_day1 P_day2]);
XEN_corr = TCD_XEN + P_corr_coeff_TCD*(P_corr-[P_day1 P_day2]);

f7=figure(7);
hold on; grid on;
plott=zeros(1,6);
plott(1)=plot(compos,[SOS_BGA(1) SOS_BGA(6)],"-",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos,[SOS_BGA(3) SOS_BGA(8)],"-",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(3)=plot(compos,[SOS_BGA(5) SOS_BGA(end)],"-",'Color',lblue,'LineWidth',4,'MarkerSize',12);
plott(4)=plot(compos,[BGA_corr(1) BGA_corr(6)],"--",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(5)=plot(compos,[BGA_corr(3) BGA_corr(8)],"--",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(6)=plot(compos,[BGA_corr(5) BGA_corr(end)],"--",'Color',lblue,'LineWidth',4,'MarkerSize',12);
ylabel('Speed of sound [m/s]')
xlabel("Hydrogen concentration [%]")
legend('P = 105.5 kPa','P = 145.5 kPa','P = 160.5 kPa','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

f8=figure(8);
hold on; grid on;
plott=zeros(1,6);
plott(1)=plot(compos,[SOS_optim(1) SOS_optim(6)],"-",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos,[SOS_optim(3) SOS_optim(8)],"-",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(3)=plot(compos,[SOS_optim(5) SOS_optim(end)],"-",'Color',lblue,'LineWidth',4,'MarkerSize',12);
plott(4)=plot(compos,[optim_corr(1) optim_corr(6)],"--",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(5)=plot(compos,[optim_corr(3) optim_corr(8)],"--",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(6)=plot(compos,[optim_corr(5) optim_corr(end)],"--",'Color',lblue,'LineWidth',4,'MarkerSize',12);
ylabel('Speed of sound [m/s]')
xlabel("Hydrogen concentration [%]")
legend('P = 105.5 kPa','P = 145.5 kPa','P = 160.5 kPa','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

f9=figure(9);
hold on; grid on;
plott=zeros(1,6);
plott(1)=plot(compos,[TCD_XEN(1) TCD_XEN(6)],"-",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos,[TCD_XEN(3) TCD_XEN(8)],"-",'Color',red,'LineWidth',4,'MarkerSize',12);
plott(3)=plot(compos,[TCD_XEN(5) TCD_XEN(end)],"-",'Color',orange,'LineWidth',4,'MarkerSize',12);
plott(4)=plot(compos,[XEN_corr(1) XEN_corr(6)],"--",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(5)=plot(compos,[XEN_corr(3) XEN_corr(8)],"--",'Color',red,'LineWidth',4,'MarkerSize',12);
plott(6)=plot(compos,[XEN_corr(5) XEN_corr(end)],"--",'Color',orange,'LineWidth',4,'MarkerSize',12);
ylabel('Thermal conductivity [mW/mK]')
xlabel("Hydrogen concentration [%]")
legend('P = 105.5 kPa','P = 145.5 kPa','P = 160.5 kPa','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

% Max deviation in corrected values 
% ----------------------------------------------------------------------------------
BGA_dev = abs(SOS_BGA(6)-SOS_BGA(end))/SOS_BGA(6)*100
optim_dev = abs(SOS_optim(6)-SOS_optim(end))/SOS_optim(6)*100
XEN_dev = abs(TCD_XEN(6)-TCD_XEN(end))/TCD_XEN(6)*100


BGA_corr_dev = abs(BGA_corr(6)-BGA_corr(end))/BGA_corr(6)*100
optim_corr_dev = abs(optim_corr(6)-optim_corr(8))/optim_corr(6)*100
XEN_corr_dev = abs(XEN_corr(6)-XEN_corr(end))/XEN_corr(6)*100

% Figure format
% ----------------------------------------------------------------------------------
f1.Position=[50,50,1000,600];
f2.Position=[50,50,1000,600];
f3.Position=[50,50,1000,600];
f4.Position=[50,50,1000,600];
f5.Position=[50,50,1000,600];
f6.Position=[50,50,1000,600];
f7.Position=[50,50,1000,600];
f8.Position=[50,50,1000,600];
f9.Position=[50,50,1000,600];
