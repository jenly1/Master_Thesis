% Theoretical TCD for binary gas mixture based on xen-3880 manual, with
% gas1=hydrogen, gas2=methane

function [Kmix, rel_diff]=Xensor_theoretical(compos_binary)
    % Hydrogen fraction
    a=compos_binary/100;
    
    for i=1:length(a)
        % Methane fraction
        b = 1-a(i);            
        
        % TCD [W/mK]
        K1 = 180e-3;     
        K2 = 34e-3;    
        
        % Dynamic viscosity [Pas]
        mu1 = 8.85;                 % https://www.lmnoeng.com/Flow/GasViscosity.php
        mu2 = 11;
        
        % Molar mass [kg/kmol]
        M1 = 2;
        M2 = 16; 
        
        % Thermal conductivity of binary gas mixture 
        F12 = (8*(1+M1/M2))^(-1/2) * (1+(mu1/mu2)^(1/2)*(M2/M1)^(1/4))^2;
        Kmix(i) = (a(i)*K1/(a(i)+b*F12) + b*K2/(b+a(i)*F12)) * 10^3;            % W/mK --> m(W/mK)
        
        if i == 1
            rel_diff(i) = 0;
        else
            rel_diff(i) = (Kmix(i)-Kmix(1))/Kmix(1);
        end 
    end
end