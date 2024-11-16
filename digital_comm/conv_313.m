rate = '1/3';
g = [1 0 1 1; 1 1 0 1; 1 1 1 0];

disp("Convolutional Code Parameters:");
disp("Rate: " + rate);
disp("Generator polynomial (G):");
disp(g);

input_bits = [1 0 1 1];
disp("Input sequence:");
disp(input_bits);

len_input = length(input_bits);
disp("Length of input bits: " + len_input);

output_bits = [];
shift_register = zeros(1, size(g, 2) - 1);

for i = 1:len_input
    current_input = input_bits(i);
    shift_register = [current_input, shift_register(1:end-1)];
    output = mod(g * [current_input, shift_register]', 2);
    output_bits = [output_bits, output'];
end

disp("Output sequence:");
disp(output_bits);

len_output = length(output_bits);
disp("Length of output bits: " + len_output);
