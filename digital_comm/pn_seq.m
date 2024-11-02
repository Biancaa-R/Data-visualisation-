clc;
clear all;
close all;

num = input("Enter the input number: ");
value = dec2bin(num);
n = length(value);     
list1 = []; 

% Initialize the output sequence with the last bit of the initial value
op = value(end); 

% Convert binary string to a numeric array of 0s and 1s
current_sequence = double(value) - '0'; 

% Append initial sequence to list1
list1 = [list1; current_sequence];

len= power(2,n) -1;
while size(list1, 1) < len 
    num1 = randi([0, 1]); 
    current_sequence = [num1, current_sequence(1:end-1)]; 
    
    % Check for uniqueness and presence of at least one '1'
    if any(current_sequence) && ~ismember(current_sequence, list1, 'rows')
        op = [op; current_sequence(end)]; % Append the last bit to output
        list1 = [list1; current_sequence]; % Append the unique sequence to list1
    end
end

disp('Generated PN Sequence:');
disp(list1);

