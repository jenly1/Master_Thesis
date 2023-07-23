%% Post-processing algorithm for REFPROP 

clc, clearvars, close all

path_const_T = "/Users/jenly/Documents/MEX/MATLAB/REFPROP_DATA/constant_T_CH4_H2_5_compos.xlsx";
path_const_P = "/Users/jenly/Documents/MEX/MATLAB/REFPROP_DATA/constant_P_CH4_H2_5_compos.xlsx";

style = ["--","-.","-",":","-","-"];
marker = ["none","none","none","none","o","|"];

blue="#0072BD";
orange="#D95319";
purple="#7E2F8E";
green="#77AC30";
lblue="#4DBEEE";

% compos = [0, 0.01, 0.1, 0.25, 0.5, 0.75, 1, 1.5];% 2, 3, 4, 5];
compos = [0, 1, 2, 3, 4, 5];
% compos = [0, 0.5, 1.5, 2.5, 3.5, 4.5];
% compos = [0, 0.1, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6];


for sheetno = 1:length(compos)
    % Call for function to create properties 
    [tempT,pressT,densT,SOST,TCDT,viscT,kviscT,dielecT] = property(path_const_T,sheetno);
    [tempP,pressP,densP,SOSP,TCDP,viscP,kviscP,dielecP] = property(path_const_P,sheetno);
    
    
%   Relative sensitivity 
%   -------------------------------------------------------------------
%   Properties extracted at SSL conditions for each gas composition
    compos_TCD(sheetno) = TCDT(1);
    compos_SOS(sheetno) = SOST(1);
    compos_dens(sheetno) = densT(1);
    compos_kvisc(sheetno) = kviscT(1);
    compos_diele(sheetno) = dielecT(1);
    compos_visc(sheetno) = viscT(1);


%   Absolute sensitivity 
%   -------------------------------------------------------------------  
    % pressT = pressT*10;     % MPa --> atm
    pressT = pressT*10^3;   % MPa --> kPa

    sens_SOS_P(sheetno) = (SOST(end)-SOST(1))/(pressT(end)-pressT(1));      % constant T, (m/s)/atm
    sens_SOS_T(sheetno) = (SOSP(end)-SOSP(1))/(tempP(end)-tempP(1));        % constant p, (m/s)/K
    sens_TCD_P(sheetno) = (TCDT(end)-TCDT(1))/(pressT(end)-pressT(1));      % constant T, (W/mK)/atm
    sens_TCD_T(sheetno) = (TCDP(end)-TCDP(1))/(tempP(end)-tempP(1));        % constant p, (W/mK)/K
    
    
%   TCD/SOS vs. p, T
%   -------------------------------------------------------------------
    % f1=figure(1);
    % plot(pressT,SOST,'Color',blue,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % %title("Isothermal simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Pressure [kPa]");
    % ylabel("Speed of sound [m/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','SouthEast');
    % grid on; hold on; set(gca,'FontSize',35); 

    % f2=figure(2);
    % plot(pressT,TCDT,'Color',orange,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isothermal simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Pressure [kPa]");
    % ylabel("Thermal conductivity [mW/mK]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','SouthEast');
    % grid on; hold on; set(gca,'FontSize',35); %ax=gca; ax.YAxis.Exponent=-3;
    
    % f3=figure(3);
    % plot(tempP,SOSP,'Color',blue,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isobaric simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Temperature [K]");
    % ylabel("Speed of sound [m/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f4=figure(4);
    % plot(tempP,TCDP,'Color',orange,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % xlabel("Temperature [K]");
    % % title("Isobaric simulation for different CH_{4}/H_{2} ratios");
    % ylabel("Thermal conductivity [mW/mK]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); %ax=gca; ax.YAxis.Exponent=-3;

    % % visc/kvisc/dielec vs. p, T
    % % -------------------------------------------------------------------
    % f1=figure(1);
    % plot(pressT,kviscT,'Color',purple,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isothermal simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Pressure [atm]");
    % ylabel("Kinematic viscosity [cm^{2}/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f2=figure(2);
    % plot(pressT,dielecT,'Color',green,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isothermal simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Pressure [atm]");
    % ylabel("Dielectric constant [-]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f3=figure(3);
    % plot(pressT,viscT,'Color',lblue,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isothermal simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Pressure [atm]");
    % ylabel("Dynamic viscosity [uPa/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f4=figure(4);
    % plot(tempP,kviscP,'Color',purple,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isobaric simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Temperature [K]");
    % ylabel("Kinematic viscosity [cm^{2}/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f5=figure(5);
    % plot(tempP,dielecP,'Color',green,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % xlabel("Temperature [K]");
    % % title("Isobaric simulation for different CH_{4}/H_{2} ratios");
    % ylabel("Dielectric constant [-]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
    % f6=figure(6);
    % plot(tempP,viscP,'Color',lblue,'LineStyle',style(sheetno),'Marker',marker(sheetno),'MarkerSize',12,'LineWidth',4);
    % % title("Isonaric simulation for different CH_{4}/H_{2} ratios");
    % xlabel("Temperature [K]");
    % ylabel("Dynamic viscosity [uPa/s]");
    % legend('1/0','0.99/0.01','0.98/0.02','0.97/0.03','0.96/0.04','0.95/0.05','Location','best');
    % grid on; hold on; set(gca,'FontSize',35); 
    % 
end

% Absolute difference, property vs. composition 
% -------------------------------------------------------------------
% f5=figure(5);
% yyaxis left
% plot(compos,compos_TCD,'Color',orange,'LineWidth',4)
% xlabel("Hydrogen concentration [%]")
% ylabel("Thermal conductivity [mW/mK]")
% yyaxis right
% plot(compos,compos_SOS,'Color',blue,'LineWidth',4)
% ylabel("Speed of sound [m/s]")
% grid; ax = gca; set(ax,'FontSize',35);
% ax.YAxis(1).Color = orange; ax.YAxis(1).Exponent=-3;
% ax.YAxis(2).Color = blue;
% 
% f6=figure(6);
% yyaxis right
% plot(compos,compos_visc,'Color',lblue,'LineWidth',4);
% xlabel("Hydrogen concentration [%]")
% ylabel("Dynamic viscosity [yPa/s]")
% yyaxis left
% plot(compos,compos_dens,'Color',green,'LineWidth',4)
% ylabel("Density [kg/m^3]")
% grid; ax = gca; set(ax,'FontSize',35);
% ax.YAxis(2).Color = lblue; ax.YAxis(2).Exponent=-6;
% ax.YAxis(1).Color = green;

% Relative difference, property vs. composition
% -------------------------------------------------------------------
% for i=1:length(compos)
%     rel_diff_TCD(i)=(compos_TCD(i)-compos_TCD(1))/compos_TCD(1);
%     rel_diff_SOS(i)=(compos_SOS(i)-compos_SOS(1))/compos_SOS(1);
%     rel_diff_kvisc(i)=(compos_kvisc(i)-compos_kvisc(1))/compos_kvisc(1);
%     rel_diff_diele(i)=(compos_diele(i)-compos_diele(1))/compos_diele(1);
%     rel_diff_visc(i)=(compos_visc(i)-compos_visc(1))/compos_visc(1);
%     rel_diff_dens(i)=(compos_dens(i)-compos_dens(1))/compos_dens(1);
% end
% 
% f7=figure(7);
% hold on; grid on; 
% ylabel('Relative difference, \Delta_{r} [-]')
% xlabel('Hydrogen concentration [%]')
% plott = zeros(1,5);
% plott(1)=plot(compos,rel_diff_TCD,"-o",'Color',orange,'LineWidth',4,'MarkerSize',12);
% plott(2)=plot(compos,rel_diff_SOS,"-s",'Color',blue,'LineWidth',4,'MarkerSize',12);
% plott(3)=plot(compos,rel_diff_dens,"-x",'Color',green,'LineWidth',4,'MarkerSize',12);
% plott(4)=plot(compos,rel_diff_visc,"-d",'Color',lblue,'LineWidth',4,'MarkerSize',12);
% plott(5)=plot(compos,rel_diff_kvisc,"-^",'Color',purple,'LineWidth',4,'MarkerSize',12);
% legend('TCD','SOS','\rho','\mu','\nu','Location','NorthWest')
% set(gca,'FontSize',35)
% set(plott,{'MarkerFaceColor'}, get(plott,'Color')); 
% set(0, 'DefaultFigureRenderer', 'painters');
% hold off


% p, T correction coefficients
% -------------------------------------------------------------------
sens_SOS_T_avg = mean(sens_SOS_T);      % T correction for SOS [(m/s)/K]
sens_SOS_P_avg = mean(sens_SOS_P);      % p correction for SOS [(m/s)/kPa]
sens_TCD_T_avg = mean(sens_TCD_T);      % T correction for TCD [m(W/mK)/K]
sens_TCD_P_avg = mean(sens_TCD_P);      % p correction for TCD [m(W/mK)/kPa]

% Uncertainty analysis 
% -------------------------------------------------------------------
% Methodological errors (uncertainty in REFPROP)
e_SOS = 0.001;                      
e_TCD = 0.05;      

% Theoretical errors (uncertainty in developed correction coefficients)
for i=1:length(compos)
    e_T_SOS_diff(i)=sens_SOS_T(i)-sens_SOS_T_avg;
    e_P_SOS_diff(i)=sens_SOS_P(i)-sens_SOS_P_avg;
    e_T_TCD_diff(i)=sens_TCD_T(i)-sens_TCD_T_avg;
    e_P_TCD_diff(i)=sens_TCD_P(i)-sens_TCD_P_avg;
end

e_T_SOS=max(abs(e_T_SOS_diff));
e_P_SOS=max(abs(e_P_SOS_diff));
e_T_TCD=max(abs(e_T_TCD_diff));
e_P_TCD=max(abs(e_P_TCD_diff));

% Total uncertainty 
SOS_T_uncert = sqrt(e_T_SOS^2 + e_SOS^2);
SOS_P_uncert = sqrt(e_P_SOS^2 + e_SOS^2);
TCD_T_uncert = sqrt(e_T_TCD^2 + e_TCD^2);
TCD_P_uncert = sqrt(e_P_TCD^2 + e_TCD^2);

fprintf('\nThe temperature uncertainty for SOS is: %.4f (m/s)/K \n', SOS_T_uncert)
fprintf('The temperature uncertainty for TCD is: %.4f (mW/mK)/K \n', TCD_T_uncert)
fprintf('The pressure uncertainty for SOS is: %.4f (m/s)/(kPa) \n', SOS_P_uncert)
fprintf('The pressure uncertainty for TCD is: %.4f (mW/mK)/(kPa) \n', TCD_P_uncert)

% Implementation of uncertainty 
% -------------------------------------------------------------------
% % Methodological error
% TCD_plu_e_m = compos_TCD*(1+e_TCD);
% TCD_min_e_m = compos_TCD*(1-e_TCD);
% SOS_plu_e_m = compos_SOS*(1+e_SOS);
% SOS_min_e_m = compos_SOS*(1-e_SOS);
% 
% % Total uncertainty - temperature 
% TCD_plu_u_T = compos_TCD*(1+TCD_T_uncert);
% TCD_min_u_T = compos_TCD*(1-TCD_T_uncert);
% SOS_plu_u_T = compos_SOS*(1+SOS_T_uncert);
% SOS_min_u_T = compos_SOS*(1-SOS_T_uncert);

% % Total uncertainty - pressure  
% TCD_plu_u_P = compos_TCD*(1+TCD_P_uncert);
% TCD_min_u_P = compos_TCD*(1-TCD_P_uncert);
% SOS_plu_u_P = compos_SOS*(1+SOS_P_uncert);
% SOS_min_u_P = compos_SOS*(1-SOS_P_uncert);

% f1=figure(1);
% hold on; grid on;
% plot(compos,compos_TCD,'Color',orange,'LineWidth',4)
% plot(compos,TCD_plu_e_m,'Color',orange,'LineWidth',4,'LineStyle','--')
% plot(compos,TCD_plu_u_T,'Color',orange,'LineWidth',4,'LineStyle',':')
% plot(compos,TCD_min_e_m,'Color',orange,'LineWidth',4,'LineStyle','--')
% plot(compos,TCD_min_u_T,'Color',orange,'LineWidth',4,'LineStyle',':')
% ylabel("Thermal conductivity [mW/(mK)]]")
% legend('REFPROP TCD','\epsilon_m = 5%','u_T = 5.15%','Location','NorthWest')
% xlabel("Hydrogen concentration [%]")
% ylabel("Thermal conductivity [mW/m-K]")
% set(gca,'FontSize',35); hold off;
% 
% f2=figure(2);
% hold on; grid on; 
% plot(compos,compos_SOS,'Color',blue,'LineWidth',4,'MarkerSize',12);
% plot(compos,SOS_plu_e_m,'Color',blue,'LineWidth',4,'LineStyle','--');
% plot(compos,SOS_plu_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
% plot(compos,SOS_min_e_m,'Color',blue,'LineWidth',4,'LineStyle','--');
% plot(compos,SOS_min_u_T,'Color',blue,'LineWidth',4,'LineStyle',':');
% ylabel('Speed of sound [m/s]')
% xlabel('Hydrogen concentration [%]')
% legend('REFPROP SOS','\epsilon_m = 0.1%','u_T = 0.86%','Location','NorthWest')
% set(gca,'FontSize',35); hold off

% ---------- Figure format 
f1.Position=[50,50,1000,600];
f2.Position=[50,50,1000,600];
f3.Position=[50,50,1000,600];
f4.Position=[50,50,1000,600];
f5.Position=[50,50,1000,600];
f6.Position=[50,50,1000,600];
f7.Position=[50,50,1000,600];


% --------- Stupid stuff to check 
% check ideal gas 
c=sqrt(pressT./densT); 
% The speed has a weak dependence on frequency and pressure in ordinary air
% deviating slightly from ideal behavior.
% pressure increases but density increases as well. 
% shows that the ratio between pressure and density is approx. the same,
% however density increases slighty faster than the pressure, leading to
% a slightly decreased speed of sound. shows for all gas composition ratios. 
