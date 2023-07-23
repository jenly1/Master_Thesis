% Data extraction based on timestamps of different gas mixture measurements

function [trans_mean, Tsens_mean] = Xensor_extract(path,day_index)
    % Create matrix containing numbers from excel sheet
    [num,txt,raw] = xlsread(path);                            
    
    % Timestamps 
    Time = raw(4:end,2); % Output is cell array
    
    % Rest of parameters
    num = num(4:end,4:6);                    % Specify relevant values           
    cell = num2cell(num,[1 length(num(1,:))]); % Create cells of each column in the matrix               
    [Trans,Pt,Tsens] = deal(cell{:}); %Asesing each cell to its respective physical property
    
    % Average of transfer based on timestamps
    time_stamps_day1 = {'13:35:00','14:04:00','14:17:00','14:53:00','15:37:00','16:03:00','16:25:00'};%,'16:45:00'}; % 5 min have been added to each starting time to achieve stable values
    time_stamps_day2 = {'12:40:00','13:09:00','14:13:00','14:26:00','14:50:00','15:12:00','15:32:00','15:47:00','16:05:00','16:15:00'};
    time_stamps_day3 = {'11:15:00','11:30:00','11:50:00','12:10:00','12:24:00','12:39:00','12:57:00','13:13:00','13:27:00','13:42:00','13:53:00','14:30:00'};
    time_stamps_day4 = {'12:04:00','12:13:00','12:28:00','12:40:00','12:47:00','12:54:00'};
    time_stamps_day5 = {'12:18:00','12:30:00','12:52:00','13:10:00','13:29:00','13:39:00'};
    time_stamps = {time_stamps_day1, time_stamps_day2,time_stamps_day3,time_stamps_day4,time_stamps_day5};
    index=[];trans_mean=[];Tsens_mean=[];time_index=1;
    
    for i=1:length(Time)-1
        if Time{i}(1:8) == time_stamps{day_index}{time_index}
            if time_stamps{day_index}{time_index} == time_stamps{day_index}{1}          %if first timestamp, just collect index
                index(end+1) = i;
                time_index=time_index+1;
            elseif time_stamps{day_index}{time_index} == time_stamps{day_index}{end}    %if last timestamp, break the for loop
                index(end+1) = i;
                trans_mean(end+1) = mean(Trans(index(end-1):index(end)));
                Tsens_mean(end+1) = mean(Tsens(index(end-1):index(end)));
                break
            else                                                                        %else, compute the average transfer between relevant indeces          
                index(end+1) = i;
                trans_mean(end+1) = mean(Trans(index(end-1):index(end)));
                Tsens_mean(end+1) = mean(Tsens(index(end-1):index(end)));
                time_index=time_index+1;
            end
        end
    end
end 

