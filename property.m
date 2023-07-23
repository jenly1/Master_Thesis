% Function to transform data from excel to matlab variables 

function [temp,press,dens,SOS,TCD,visc,kvisc,dielec] = property(path,sheetno)
    matrix = xlsread(path, sheetno);                              % Create matrix of excel sheet
    cell = num2cell(matrix,[1 length(matrix(1,:))]);              % Create cells of each column in the matrix
    [temp,press,dens,SOS,TCD,visc,kvisc,dielec] = deal(cell{:});  % Assesing each cell to its respective physical property
end