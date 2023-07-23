%% Post-processing algorithm for sensor output 
clc; clear all

% H2 concentration according to for calibration curve and validation curves 
compos_binary_GC_1 = [0, 0.2025, 0.4050, 0.6050, 0.8, 0.9625, 1.15, 1.35, 1.54];    % Cal mixtures
compos_binary_GC_2 = [0, 0.24, 0.42, 0.58, 0.6933, 0.8067, 1, 1.1933, 1.41];        % Val mixtures
compos_trinary_GC = [0.36,0.7575,0.95,1.15,1.35];

% Comparison with REFPROP
% ----------------------------------------------------------------------------------------------------------------
blue="#0072BD";
orange="#D95319";
yellow="#EDB120";
purple="#7E2F8E";
green="#77AC30";
lblue="#4DBEEE";
red="#A2142F";
black="#000000";

path_REFPROP = "/Users/jenly/Documents/MEX/MATLAB/REFPROP_DATA/constant_T_CH4_H2.xlsx";
compos = [0, 0.01, 0.1, 0.25, 0.5, 0.75, 1, 1.5];

for sheetno=1:length(compos)
    [temp,press,dens,SOS,TCD,visc,kvisc,dielec] = property(path_REFPROP,sheetno);
    
    % Properties extracted at SSL conditions for each gas composition
    compos_TCD(sheetno) = TCD(1);
    compos_SOS(sheetno) = SOS(1);
    
    rel_diff_TCD(sheetno)=(compos_TCD(sheetno)-compos_TCD(1))/compos_TCD(1);
    rel_diff_SOS(sheetno)=(compos_SOS(sheetno)-compos_SOS(1))/compos_SOS(1);
end

% XENSOR - Compute average transfer for each composition 
% ----------------------------------------------------------------------------------------------------------------
% Xensor1=[]; Xensor2=[]; XEN1_T_mean=[]; XEN2_T_mean=[];
% path_list = {
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-10-04DC44_X#1_second half of the day.xlsx',
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-10-04DC43_X#2_second half of the day.xlsx',
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-11-04DC44_X#1.xlsx',
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-11-04DC43_X#2.xlsx',
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-24-04DC44_X#1.xlsx',
%             '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/TCD_2023-05-24-04DC43_X#2.xlsx'
%             };
% 
% for path_index=1:length(path_list)
%     if path_index <= 2
%         day_index=1;
%         [trans_mean, T_mean] = Xensor_extract(path_list{path_index},day_index);
%         if path_index == 1
%             Xensor1 = [Xensor1,trans_mean];
%             XEN1_T_mean = [XEN1_T_mean,T_mean];
%         else
%             Xensor2 = [Xensor2,trans_mean];
%             XEN2_T_mean = [XEN2_T_mean,T_mean];
%         end
%     elseif path_index > 2 && path_index <= 4
%         day_index=2;
%         [trans_mean, T_mean] = Xensor_extract(path_list{path_index},day_index);
%         if path_index == 3
%             Xensor1 = [Xensor1,trans_mean];
%             XEN1_T_mean = [XEN1_T_mean,T_mean];
%         else
%             Xensor2 = [Xensor2,trans_mean];
%             XEN2_T_mean = [XEN2_T_mean,T_mean];
%         end
%     else
%         day_index=3;
%         [trans_mean, T_mean] = Xensor_extract(path_list{path_index},day_index);
%         if path_index == 5
%             Xensor1 = [Xensor1,trans_mean];
%             XEN1_T_mean = [XEN1_T_mean,T_mean];
%         else
%             Xensor2 = [Xensor2,trans_mean];
%             XEN2_T_mean = [XEN2_T_mean,T_mean];
%         end
%     end 
% end

% % -------- TCD experimental temperature correction 
% T_corr_cal = (59.0615-59.0206)/(28.0093-27.7970);
% T_corr_val = (59.2860-59.1860)/(30.7803-30.1882);
% T_corr = 293.3-273.15;
% 
% TCD_T_uncert = 0.0515;
% TCD_plu_u_T = compos_TCD*(1+TCD_T_uncert);
% TCD_min_u_T = compos_TCD*(1-TCD_T_uncert);
% 
% scaling = 1.75;
% Kmix_exp = 1./Xensor1*1000 / scaling;    %[mW/mK]
% 
% XEN1_1=Kmix_exp(1:9);
% XEN1_2=[Kmix_exp(16:24)];
% 
% XEN1_1_corr=XEN1_1+T_corr_cal*(T_corr-XEN1_T_mean(1:9));
% XEN1_2_corr=XEN1_2+T_corr_val*(T_corr-[XEN1_T_mean(16:24)]);
% 
% f1=figure(1);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(compos,compos_TCD,"-o",'Color',orange,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos,TCD_plu_u_T,":",'Color',orange,'LineWidth',4);
% plott(3)=plot(compos_binary_GC_1,XEN1_1,"-^",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(4)=plot(compos_binary_GC_2,XEN1_2,"-s",'Color',lblue,'LineWidth',4,'MarkerSize',12);
% plott(5)=plot(compos_binary_GC_1,XEN1_1_corr,"-^",'Color',red,'LineWidth',4,'MarkerSize',12);
% plott(6)=plot(compos_binary_GC_2,XEN1_2_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
% plott(7)=plot(compos,TCD_min_u_T,":",'Color',orange,'LineWidth',4);
% xlabel("Hydrogen concentration [%]")
% ylabel("Thermal conductivity [mW/m-K]")
% legend('REFPROP','Uncertainty 5.15%','XEN cal','XEN unknown','XEN cal (T comp)','XEN unknown (T comp)','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% % --------Compute theoretical value from Xensor manual
% [Kmix_theo, rel_diff]=Xensor_theoretical(compos_binary_GC_1);
% Kmix_exp = 1./Xensor1(1:9)*1000;    %[mW/mK]
% Kmix_exp_ratio = Kmix_exp/1.75;     %1.52;
% 
% 
% for i=1:length(Kmix_exp_ratio)
%     Kmix_exp_corr(i) = Kmix_exp_ratio(i)-(Kmix_exp_ratio(i)-Kmix_exp_ratio(end))*compos_binary_GC_1(i);
%     Kmix_exp_corr(i) = Kmix_exp_ratio(i)-(Kmix_exp_ratio(i)-Kmix_theo(i));
% end
% 
% f2=figure(2);
% hold on; grid on;
% plott=zeros(1,3);
% plott(1)=plot(compos_binary_GC_1,Kmix_theo,"-+",'Color',orange,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_1,Kmix_exp,"-s",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos_binary_GC_1,Kmix_exp_ratio,"-o",'Color',green,'LineWidth',4,'MarkerSize',12);
% % plott(4)=plot(compos_binary_GC,Kmix_exp_corr,"--",'Color',"#7E2F8E",'LineWidth',4,'MarkerSize',12);
% xlabel("Hydrogen concentration [%]")
% ylabel("Thermal conductivity [mW/m-K]")
% legend('Theoretical','Experimental','Experimental (scaled)','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% opTim - Compute average SOS for each composition 
% ----------------------------------------------------------------------------------------------------------------
% % Computation of the distance based on standard gases nitrogen and argon 
% SOS_N2 = 352.16; % obtained from REFPORP, P=101.3, T=298.3K [m/s]
% SOS_Ar = 321.75; % obtained from REFPORP, P=101.3, T=298.3K [m/s]
% path_standard_gas = '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.24_11.34.14_RIO_Log.xlsx';
% day_index = 4;
% [t1_mean,t2_mean,T1_mean,T2_mean] = opTim_extract(path_standard_gas,day_index);
% 
% d_N2 = [t1_mean(1) t2_mean(1)]*10^-6*SOS_N2; % cm
% d_Ar = [t1_mean(2) t2_mean(2)]*10^-6*SOS_Ar; % cm
% 
% d1_mean = mean([d_N2(1) d_Ar(1)]);
% d2_mean = mean([d_N2(2) d_Ar(2)]);
% 
% % Compute speed of sound
% opTim_SOS1=[]; opTim_SOS2=[]; opTim_T1=[]; opTim_T2=[]; t2=[];
% 
% path_ultra = {'/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.10_13.26.40_RIO_Log.xlsx',
%               '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.11_10.21.04_RIO_Log.xlsx',
%               '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/Ultrasonic_23.05.24_11.34.14_RIO_Log.xlsx'};
% 
% for path_index=1:length(path_ultra)
%     [t1_mean,t2_mean,T1_mean,T2_mean] = opTim_extract(path_ultra{path_index},path_index);
% 
%     SOS1_mean = d1_mean./(t1_mean*10^-6);   % Cal mixtures
%     SOS2_mean = d2_mean./(t2_mean*10^-6);   % Val mixtures 
% 
%     opTim_SOS1=[opTim_SOS1,SOS1_mean]; 
%     opTim_SOS2=[opTim_SOS2,SOS2_mean]; 
%     opTim_T1=[opTim_T1,T1_mean]; 
%     opTim_T2=[opTim_T2,T2_mean];
% end

% BGA - Compute average SOS for each composition 
% ----------------------------------------------------------------------------------------------------------------
BGA_SOS=[]; BGA_NTP_SOS=[]; BGA_T=[];
path_BGA = {"/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230510_second half of the day.xlsx",
            "/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230511.xlsx",
            '/Users/jenly/Documents/MEX/MATLAB/EXP_DATA/BGA_20230524_entire_day.xlsx'};

for path_index=1:length(path_BGA)
    [SOS_mean,SOS_NTP_mean,T_mean] = BGA_extract(path_BGA{path_index},path_index);
    BGA_SOS = [BGA_SOS,SOS_mean];
    BGA_NTP_SOS = [BGA_NTP_SOS,SOS_NTP_mean];
    BGA_T = [BGA_T,T_mean];
end

% -------- SOS experimental temperature correction 
T_corr = 293.3-273.15;
T_corr_cal = (450.4798-450.2218)/(26.9432-26.6031);       % Calibration mixtures
T_corr_val = (452.6591-452.0575)/(29.9589-29.1157);       % Validation mixtures 

SOS_T_uncert = 0.0086;
SOS_plu_u_T = compos_SOS*(1+SOS_T_uncert);
SOS_min_u_T = compos_SOS*(1-SOS_T_uncert);

% ---------------------- BGA binary
BGA_SOS_binary_1=BGA_SOS(1:9);
BGA_NTP_SOS_binary_1=BGA_NTP_SOS(1:9);

BGA_SOS_binary_2=[BGA_SOS(16:24)];
BGA_NTP_SOS_binary_2=[BGA_NTP_SOS(16:24)];

BGA_SOS_binary_1_corr=BGA_SOS_binary_1 + T_corr_cal*(T_corr-BGA_T(1:9)); % works 
BGA_SOS_binary_2_corr=BGA_SOS_binary_2 + T_corr_val*(T_corr-[BGA_T(16:24)]); % works 

f2=figure(2);
hold on; grid on;
plott=zeros(1,9);
plott(1)=plot(compos,compos_SOS,"-o",'Color',blue,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos,SOS_plu_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
plott(3)=plot(compos_binary_GC_1,BGA_SOS_binary_1,"-^",'Color',black,'LineWidth',4,'MarkerSize',12);
plott(4)=plot(compos_binary_GC_2,BGA_SOS_binary_2,"-s",'Color',lblue,'LineWidth',4,'MarkerSize',12);
plott(5)=plot(compos_binary_GC_1,BGA_NTP_SOS_binary_1,"-^",'Color',yellow,'LineWidth',4,'MarkerSize',12);
plott(6)=plot(compos_binary_GC_2,BGA_NTP_SOS_binary_2,"-s",'Color',purple,'LineWidth',4,'MarkerSize',12);
plott(7)=plot(compos_binary_GC_1,BGA_SOS_binary_1_corr,"-^",'Color',red,'LineWidth',4,'MarkerSize',12);
plott(8)=plot(compos_binary_GC_2,BGA_SOS_binary_2_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
plott(9)=plot(compos,SOS_min_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
ylabel("Speed of sound [m/s]")
xlabel("Hydrogen concentration [%]")
legend('REFPROP','Uncertainty 0.86%','BGA cal','BGA unknown','BGA cal (NTP)','BGA unknown (NTP)','BGA cal (T comp)','BGA unknown (T comp)','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off

% ---------------------- BGA trinary
% BGA_SOS_trinary_1=BGA_SOS(11:15);
% BGA_NTP_SOS_trinary_1=BGA_NTP_SOS(11:15);
% 
% f3=figure(3);
% hold on; grid on;
% plott=zeros(1,5);
% plott(1)=plot(compos,compos_SOS,"-o",'Color',blue,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos,SOS_plu_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
% plott(3)=plot(compos_trinary_GC,BGA_SOS_trinary_1,"-^",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(4)=plot(compos_trinary_GC,BGA_NTP_SOS_trinary_1,"-^",'Color',yellow,'LineWidth',4,'MarkerSize',12);
% plott(5)=plot(compos,SOS_min_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
% ylabel("Speed of sound [m/s]")
% xlabel("Hydrogen concentration [%]")
% legend('REFPROP','Uncertainty 0.86%','BGA', 'BGA (NTP)' ,'Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% ----------------------- opTim by average - WRONG! (cuz using theoretical coefficient)
% opTim_SOS2_1=opTim_SOS2(1:9);
% 
% opTim_SOS2_2=[opTim_SOS2(24) opTim_SOS2(16:23)];
% 
% opTim_SOS2_1_corr = opTim_SOS2_1 + T_corr_coeff*(T_corr-opTim_T1(1:9));
% opTim_SOS2_2_corr = opTim_SOS2_2 + T_corr_coeff*(T_corr-[opTim_T1(24) opTim_T1(16:23)]);

% f4=figure(4);
% hold on; grid on;
% plott=zeros(1,4);
% plott(1)=plot(compos_binary_GC_1,opTim_SOS2_1,'-^','Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_2,opTim_SOS2_2,'-s','Color',lblue,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos_binary_GC_1,opTim_SOS2_1_corr,'-^','Color',red,'LineWidth',4,'MarkerSize',12');
% plott(4)=plot(compos_binary_GC_2,opTim_SOS2_2_corr,'-s','Color',green,'LineWidth',4,'MarkerSize',12');
% ylabel("Speed of sound [m/s]")
% xlabel("Hydrogen concentration [%]")
% legend('opTim cal','opTim unknown','opTim cal corr','opTim unknown corr','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% ----------------------- opTim by manual reading by erasing deviating points and conducting an average 
% t_manual_cal = [40.455,40.413,40.372,40.332,40.291,40.239,40.191,40.149,40.108]*10^-6;
% t_manual_val = [40.2953,40.2461,40.2041,40.1666,40.142,40.113,40.0718,40.0281,39.9801]*10^-6;
% 
% SOS2_mean_cal = d2_mean./t_manual_cal;
% SOS2_mean_val = d2_mean./t_manual_val;
% 
% T_corr = 293.3-273.15;
% T_corr_cal = (d2_mean/40.4321e-6 - SOS2_mean_cal(1))/(23.962-opTim_T1(1));
% T_corr_val = (d2_mean/40.2398e-6 - SOS2_mean_val(1))/(26.914-26.1618);
% 
% SOS2_mean_cal_corr = SOS2_mean_cal + T_corr_cal*(T_corr-opTim_T1(1:9));
% SOS2_mean_val_corr = SOS2_mean_val + T_corr_val*(T_corr-[26.1618 opTim_T1(16:23)]);
% 
% f5=figure(5);
% hold on; grid on;
% plott=zeros(1,4);
% plott(1)=plot(compos_binary_GC_1,SOS2_mean_cal,'-^','Color',black,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_2,SOS2_mean_val,'-s','Color',lblue,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos_binary_GC_1,SOS2_mean_cal_corr,'-^','Color',red,'LineWidth',4,'MarkerSize',12');
% plott(4)=plot(compos_binary_GC_2,SOS2_mean_val_corr,'-s','Color',green,'LineWidth',4,'MarkerSize',12');
% ylabel("Speed of sound [m/s]")
% xlabel("Hydrogen concentration [%]")
% legend('opTim cal','opTim unknown','opTim cal (T comp)','opTim unknown (T comp)','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% Relative difference
% -------------------------------------------------------------------------
% for i=1:length(compos_binary_GC_1)
%     rel_BGA_NTP(i) = (BGA_NTP_SOS_binary_2(i)-BGA_NTP_SOS_binary_2(1))/BGA_NTP_SOS_binary_2(1);
%     % rel_BGA_corr(i) = (BGA_SOS_binary_2_corr(i)-BGA_SOS_binary_2_corr(1))/BGA_SOS_binary_2_corr(1);
%     % rel_optim_corr(i) = (SOS2_mean_val_corr(i)-SOS2_mean_val_corr(1))/SOS2_mean_val_corr(1);
%     % rel_XEN_corr(i) = (XEN1_1_corr(i)-XEN1_1_corr(1))/XEN1_1_corr(1);
% end
% % 
% f5=figure(5);
% hold on; grid on;
% plott=zeros(1,3);
% plott(1)=plot(compos,rel_diff_SOS,"-o",'Color',blue,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_1,rel_BGA_NTP,"-s",'Color',red,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos_binary_GC_1,rel_BGA_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel('Hydrogen concentration [%]')
% legend('REFPROP','BGA (NTP)','BGA (T comp) ','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% 
% f6=figure(6);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(compos,rel_diff_SOS,"-o",'Color',blue,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_1,rel_optim_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel('Hydrogen concentration [%]')
% legend('REFPROP','opTim (T comp)','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% % % 
% f7=figure(7);
% hold on; grid on;
% plott=zeros(1,3);
% plott(1)=plot(compos,rel_diff_TCD,"-o",'Color',orange,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_1,rel_XEN_corr,"-s",'Color',black,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos_binary_GC_1,rel_XEN_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel('Hydrogen concentration [%]')
% legend('REFPROP','XEN','XEN (T comp)','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% 

% % H2 sensitivites 
% % ---------------------------------------------------------------------------------
% sens_REF_SOS = (compos_SOS(end)-compos_SOS(1))/(compos(end)-compos(1))
% sens_REF_TCD = (compos_TCD(end)-compos_TCD(1))/(compos(end)-compos(1))
% sens_BGA = (BGA_SOS_binary_2_corr(end)-BGA_SOS_binary_2_corr(1))/(compos_binary_GC_2(end)-compos_binary_GC_2(1))
% sens_optim = (SOS2_mean_val_corr(end)-SOS2_mean_val_corr(1))/(compos_binary_GC_2(end)-compos_binary_GC_2(1))
% sens_XEN = (XEN1_1_corr(end)-XEN1_1_corr(1))/(compos_binary_GC_1(end)-compos_binary_GC_1(1))

% Max deviation in corrected values 
% ----------------------------------------------------------------------------------
% BGA_dev_corr    = abs(448.72-448.18)/448.18*100
% optim_dev_corr  = abs(451.535-449.8)/449.8*100
% XEN_dev_corr    = abs(32.6141-32.3197)/32.3197*100


% Validation between corrected cal and unknown curve 
% ----------------------------------------------------------------------------------
% f1=figure(1);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(compos_binary_GC_1,XEN1_1_corr,"-^",'Color',red,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos_binary_GC_2,XEN1_2_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
% xlabel("Hydrogen concentration [%]")
% ylabel("Thermal conductivity [mW/m-K]")
% legend('XEN cal corr','XEN unknown corr','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off
% 
% 
f2=figure(2);
hold on; grid on;
plott=zeros(1,2);
plott(1)=plot(compos_binary_GC_1,BGA_SOS_binary_1_corr,"-^",'Color',red,'LineWidth',4,'MarkerSize',12);
plott(2)=plot(compos_binary_GC_2,BGA_SOS_binary_2_corr,"-s",'Color',green,'LineWidth',4,'MarkerSize',12);
ylabel("Speed of sound [m/s]")
xlabel("Hydrogen concentration [%]")
legend('BGA cal corr','BGA unknown corr','Location','NorthWest')
set(gca,'FontSize',35)
set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
set(0, 'DefaultFigureRenderer', 'painters');
hold off
% 
% f3=figure(3);
% hold on; grid on;
% plott=zeros(1,2);
% plott(1)=plot(compos_binary_GC_1,opTim_SOS2_1_corr,'-^','Color',red,'LineWidth',4,'MarkerSize',12');
% plott(2)=plot(compos_binary_GC_2,opTim_SOS2_2_corr,'-s','Color',green,'LineWidth',4,'MarkerSize',12');
% ylabel("Speed of sound [m/s]")
% xlabel("Hydrogen concentration [%]")
% legend('opTim cal corr','opTim unknown corr','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off

% % Temperature graphs
% % ----------------------------------------------------------------------------------
% BGA_T_day1 = opTim_T1(1:9)
% BGA_T_day2 = [26.1618 opTim_T1(16:23)];

% Figure format
f1.Position=[50,50,1000,600];
f2.Position=[50,50,1000,600];
f3.Position=[50,50,1000,600];
f4.Position=[50,50,1000,600];
f5.Position=[50,50,1000,600];
f6.Position=[50,50,1000,600];
f7.Position=[50,50,1000,600];

