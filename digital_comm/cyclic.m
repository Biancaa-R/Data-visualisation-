n = 7;
k = 4;

g = [1 0 1 1];

m = input("Enter a 4-bit binary number as a vector (e.g., [1 0 1 0]): ");

if length(m) ~= k || ~all(ismember(m, [0 1]))
    error("Input must be a 4-bit binary vector (e.g., [1 0 1 0]).");
end

m_padded = [m, zeros(1, n - k)];

[~, remainder] = deconv(m_padded, g);
remainder = mod(remainder, 2);

parity_bits = remainder(end-(n-k)+1:end);

codeword = [parity_bits, m];

disp("Generated codeword:");
disp(codeword);
