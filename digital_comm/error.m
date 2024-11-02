n = 6;
k = 3;

% Define parity matrix
P = [0 1 1; 1 1 1; 1 1 0];

I_k = eye(k);       
G = [P I_k];      

m = input("Enter a 3-bit binary number as a vector (e.g., [1 0 1]): ");

if length(m) ~= k || ~all(ismember(m, [0 1]))
    error("Input must be a 3-bit binary vector (e.g., [1 0 1]).");
end

% Calculate codeword
codeword = mod(m * G, 2);

% Display codeword
disp("Generated codeword:");
disp(codeword);
