n = 7; % Codeword length
k = 4; % Message length
g = [1 0 1 1]; % Generator polynomial for (7,4) code

% Display cyclic code parameters
disp("Cyclic Codes:");
disp("n = " + n + ", k = " + k);
disp("Generator polynomial (g):");
disp(g);

% Input message
m = input("Enter a 4-bit binary number as a vector (e.g., [1 0 1 0]): ");

if length(m) ~= k || ~all(ismember(m, [0 1]))
    error("Input must be a 4-bit binary vector (e.g., [1 0 1 0]).");
end

% Pad the message with zeros
m_padded = [m, zeros(1, n - k)];

% Polynomial division to get the remainder (parity bits)
[~, remainder] = deconv(fliplr(m_padded), fliplr(g));
remainder = mod(fliplr(remainder), 2);

% Extract parity bits and form the codeword
parity_bits = remainder(end-(n-k)+1:end);
codeword = [m, parity_bits];

% Display the generated codeword
disp("Generated codeword:");
disp(codeword);

% Generate all codewords
disp("All Codewords:");
all_messages = dec2bin(0:(2^k - 1)) - '0'; % Generate all possible k-bit messages
all_codewords = zeros(2^k, n); % Initialize codewords array

for i = 1:size(all_messages, 1)
    m_padded = [all_messages(i, :), zeros(1, n - k)];
    [~, remainder] = deconv(fliplr(m_padded), fliplr(g));
    remainder = mod(fliplr(remainder), 2);
    parity_bits = remainder(end-(n-k)+1:end);
    all_codewords(i, :) = [all_messages(i, :), parity_bits];
end

% Display all messages and their corresponding codewords
disp("Message and Codewords:");
for i = 1:size(all_messages, 1)
    fprintf("Message: %s -> Codeword: %s\n", mat2str(all_messages(i, :)), mat2str(all_codewords(i, :)));
end

% Create decoding table (syndrome table)
H = [1 0 0 1 1 1 0; 0 1 0 1 1 0 1; 0 0 1 0 1 1 1]; % Example parity-check matrix
disp("Decoding Table (Syndrome Table):");
disp(H);

% Decode a sample received codeword
received = input("Enter a 7-bit received codeword as a vector (e.g., [1 0 1 1 0 0 1]): ");
if length(received) ~= n || ~all(ismember(received, [0 1]))
    error("Input must be a 7-bit binary vector (e.g., [1 0 1 1 0 0 1]).");
end

% Calculate syndrome
syndrome = mod(received * H.', 2);
disp("Syndrome for the received codeword:");
disp(syndrome);
all_syn=zeros(2^k -1,3);
for (i=1:15)
    all_syn(i, :) = mod(all_codewords(i, :) * H.', 2);  % This should produce a 1x3 vector
end
% Check for error
[~, error_index] = ismember(syndrome, all_syn, 'rows');
if error_index == 0
    disp("No errors detected. Codeword is valid.");
    decoded_message = received(1:k); % Extract original message bits
else
    disp("Error detected and corrected.");
    received(error_index) = mod(received(error_index) + 1, 2); % Correct error
    decoded_message = received(1:k); % Extract corrected message bits
end

disp("Decoded Message:");
disp(decoded_message);