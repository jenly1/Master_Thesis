% Data extraction for BGA 

function [SOS_mean,SOS_NTP_mean,T_mean] = BGA_extract(path,day_index)
    % Create matrix containing numbers from excel sheet
    data = xlsread(path);

    % Relevant data
    Time = data(2:end,1);
    SOS = data(2:end,5);
    SOS_NTP = data(2:end,6);
    T = data(2:end,7);
    
    % Average based on timestamps 
    time_stamps_day1 = [500,1900,3540,4320,6480,9120,10700];%,11788]; %for pure methane
    % time_stamps_day1 = [150,1800,3780,4560,6720,9360,10920];
    time_stamps_day2 = [300,2040,5880,6660,8100,9420,10620,11520,12600,13132];
    time_stamps_day3 = [10,700,2160,3000,3900,4980,5940,6780,7680,8640,12700];
    time_stamps_day4 = [4620,5280,6180,6960,7380,7800];
    time_stamps_day5 = [2100,2820,4140,5220,6360,7000];
    time_stamps_day6 = [6636,7500,8540,9020,9440,9860,10220,11000,11300,11700,12000,12500,12700,13000];
    time_stamps_day7 = [1,360,960,1440,1920,2220,2640,4500,5400,5800,6180,6840,7260,7740,9540,10020,10440,10920,11280,11700,12060]; 

    time_stamps={time_stamps_day1,time_stamps_day2,time_stamps_day3,time_stamps_day4,time_stamps_day5,time_stamps_day6,time_stamps_day7};
    SOS_mean=[];SOS_NTP_mean=[];T_mean=[];
    
    time_stamps_day = time_stamps{day_index};
    for i=1:length(time_stamps_day)-1
        SOS_mean(end+1) = mean(SOS(time_stamps_day(i):time_stamps_day(i+1)));
        SOS_NTP_mean(end+1) = mean(SOS_NTP(time_stamps_day(i):time_stamps_day(i+1)));
        T_mean(end+1) = mean(T(time_stamps_day(i):time_stamps_day(i+1)));
    end
end