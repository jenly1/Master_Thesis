% Temperature variation script
clc; clear all

black="#000000";
blue="#0072BD";
lblue="#4DBEEE";

day_index = [6,7]; 

path_BGA = {'/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230601.xlsx',
            '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230608.xlsx'};

SOS=[]; SOS_NTP=[]; T=[];
for i=1:length(day_index)
    [SOS_mean,SOS_NTP_mean,T_mean] = BGA_extract(path_BGA{i},day_index(i)); 

    SOS = [SOS, SOS_mean];
    SOS_NTP = [SOS_NTP, SOS_NTP_mean];
    T = [T, T_mean];
end

% Deleting values were the temperature is increased
SOS(7)=[];      % 452.9826
SOS(19)=[];     % 458.8755
SOS(25)=[];     % 463.9148
SOS=SOS(7:end); % Delete first methane values because temperature is not stable 

T(7)=[]; T(19)=[]; T(25)=[];
T=T(7:end);

% Sort for each temperature 
SOS1=SOS(7:12); T1=T(7:12);
SOS2=SOS(1:6);  T2=T(1:6);
SOS3=SOS(13:18);T3=T(13:18);
SOS4=SOS(19:24);T4=T(19:24);


for n=0:3
    SOS1_1(n+1)=SOS(1+6*n); T1_1(n+1)=T(1+6*n); % pure methane
    SOS1_2(n+1)=SOS(3+6*n); T1_2(n+1)=T(3+6*n);

    SOS2_1(n+1)=SOS(2+6*n); T2_1(n+1)=T(2+6*n); % 0.5% hydrogen
    SOS2_2(n+1)=SOS(4+6*n); T2_2(n+1)=T(4+6*n);

    SOS3_1(n+1)=SOS(3+6*n); T3_1(n+1)=T(3+6*n); % 1% hydrogen 
    SOS3_2(n+1)=SOS(5+6*n); T3_2(n+1)=T(5+6*n);
end

% Order by temperature 
SOS1_1([1 2])=SOS1_1([2 1]); T1_1([1 2])=T1_1([2 1]); 
SOS1_2([1 2])=SOS1_2([2 1]); T1_2([1 2])=T1_2([2 1]);
SOS2_1([1 2])=SOS2_1([2 1]); T2_1([1 2])=T2_1([2 1]);
SOS2_2([1 2])=SOS2_2([2 1]); T2_2([1 2])=T2_2([2 1]);
SOS3_1([1 2])=SOS3_1([2 1]); T3_1([1 2])=T3_1([2 1]);
SOS3_2([1 2])=SOS3_2([2 1]); T3_2([1 2])=T3_2([2 1]);


% Absolute difference
% ----------------------------------------------------------------------------------
f1=figure(1);
hold on; grid on;
plott=zeros(1,3);
plott(1)=plot(T1_1,SOS1_1,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(T2_1,SOS2_1,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(3)=plot(T3_1,SOS3_1,"-^",'Color',lblue,'LineWidth',4,'MarkerSize',12);
ylabel("Speed of sound [m/s]")
xlabel("Temperature [°C]")
legend('1/0','0.9955/0.0045','0.991/0.009','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

% f2=figure(2);
% hold on; grid on;
% plott=zeros(1,3);
% plott(1)=plot(T1_2,SOS1_2,"-o",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(T2_2,SOS2_2,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(T3_2,SOS3_2,"-^",'Color',lblue,'LineWidth',4,'MarkerSize',12);
% ylabel("Speed of sound [m/s]")
% xlabel("Temperature [°C]")
% legend('1/0','0.9955/0.0045','0.991/0.009','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% Temperature correction 
% ----------------------------------------------------------------------------------
compos = [0, 0.45, 0.9];
T_corr_coeff = 0.6564;
T_corr = 293.3-273.15;

T2 = [T1_1(2) T2_1(2) T3_1(2)];
T3 = [T1_1(3) T2_1(3) T3_1(3)];
T4 = [T1_1(4) T2_1(4) T3_1(4)];

SOS2 = [SOS1_1(2) SOS2_1(2) SOS3_1(2)];
SOS3 = [SOS1_1(3) SOS2_1(3) SOS3_1(3)];
SOS4 = [SOS1_1(4) SOS2_1(4) SOS3_1(4)];

SOS2_corr=SOS2+T_corr_coeff*(T_corr-T2);
SOS3_corr=SOS3+T_corr_coeff*(T_corr-T3);
SOS4_corr=SOS4+T_corr_coeff*(T_corr-T4);

f3=figure(3);
hold on; grid on;
plott=zeros(1,6);
plott(1)=plot(compos,SOS2,"-",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos,SOS3,"-",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(3)=plot(compos,SOS4,"-",'Color',lblue,'LineWidth',4,'MarkerSize',12);
plott(4)=plot(compos,SOS2_corr,"--",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(5)=plot(compos,SOS3_corr,"--",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(6)=plot(compos,SOS4_corr,"--",'Color',lblue,'LineWidth',4,'MarkerSize',12);
ylabel('Speed of sound [m/s]')
xlabel("Hydrogen concentration [%]")
legend('T = 29.1 °C','T = 38.0 °C','T = 46.9 °C','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

BGA_dev = abs(SOS2(3)-SOS4(3))/SOS4(3)*100;
BGA_corr_dev = abs(SOS2_corr(3)-SOS4_corr(3))/SOS4_corr(3)*100;

% Figure format
% ----------------------------------------------------------------------------------
f1.Position=[50,50,1000,600];
f2.Position=[50,50,1000,600];
f3.Position=[50,50,1000,600];
