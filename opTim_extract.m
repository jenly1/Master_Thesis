% Data extraction

function [t1_mean,t2_mean,T1_mean,T2_mean] = opTim_extract(path,day_index)
    % Read data 
    [num,txt] = xlsread(path,'A:P'); % A:S is the columns of relevance 
    
    % Extract relevant columns
    Time = txt(2:end,1);
    t1 = num(:,6);
    t2 = num(:,9);
    T1 = num(:,13);
    T2 = num(:,15);
    
    % Average of transfer based on timestamps
    time_stamps_day1 = {'13.32','14.02','14.11','14.47','15.30','15.57','16.26','16:35'}; % 5 min have been added to each starting time to achieve stable values
    time_stamps_day2 = {'12.40','13.09','14.13','14.26','14.50','15.12','15.32','15.47','16.05','16.15'};
    time_stamps_day3 = {'11.39','12.05','12.24','12.39','12.57','13.13','13.27','13.42','13.51','15.00'};
    time_stamps_distance = {'15.47','17.03','18.46'};
    time_stamps_day4 = {'12.01','12.11','12.28','12.40','12.48','12.53'};
    time_stamps_day5 = {'12.18','12.30','12.52','13.10','13.29','13.39'};
    time_stamps = {time_stamps_day1, time_stamps_day2,time_stamps_day3,time_stamps_distance,time_stamps_day4,time_stamps_day5};
    index=[];t1_mean=[];t2_mean=[];T1_mean=[];T2_mean=[];time_index=1; 
    
    for row=1:length(Time)-1
        if Time{row}(1:5) == time_stamps{day_index}{time_index}
            if time_stamps{day_index}{time_index} == time_stamps{day_index}{1}          %if first timestamp, just collect index
                index(end+1) = row;
                time_index=time_index+1;
            elseif time_stamps{day_index}{time_index} == time_stamps{day_index}{end}    %if last timestamp, break the loop
                index(end+1) = row;
                t1_mean(end+1) = mean(nonzeros(t1(index(end-1):index(end))));
                t2_mean(end+1) = mean(nonzeros(t2(index(end-1):index(end))));
                T1_mean(end+1) = mean(nonzeros(T1(index(end-1):index(end))));
                T2_mean(end+1) = mean(nonzeros(T2(index(end-1):index(end))));
                break
            else                                                                        %else, compute the average between relevant indeces          
                index(end+1) = row;
                t1_mean(end+1) = mean(nonzeros(t1(index(end-1):index(end))));
                t2_mean(end+1) = mean(nonzeros(t2(index(end-1):index(end))));
                T1_mean(end+1) = mean(nonzeros(T1(index(end-1):index(end))));
                T2_mean(end+1) = mean(nonzeros(T2(index(end-1):index(end))));
                time_index=time_index+1;
            end
        end
    end
end