% Define the frequency range for the Bode plot
a = -2;
b = 2;
w = logspace(a, b);
n=input("Enter the numerator");
d=input("Enter the denominator");
% Create the transfer function
sys_tf = tf(n, d);

% Plot the Bode plot of the original system
figure;
bode(sys_tf, w);
title('Bode Plot of the Original System');
grid on;

% Calculate the gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
[gm, pm, gcf, pcf] = margin(sys_tf);
value = [gm, pm, gcf, pcf];
disp('Original system margins:');
disp(value);

choice= input("Enter 1 for gm, 2 for pm and 3 for wgc variation");
switch choice

    case 1
        gm_des = 30;

        % Calculate the required gain adjustment
        gm_db = 20 * log10(gm);  % Convert gm to dB
        disp(gm_db);
        gm_mag = -(gm_des - gm_db);  % Calculate the required increase in dB
        k = power(10, gm_mag/20);  % Convert the dB increase to a multiplicative factor

        % Create the new transfer function with the adjusted gain
        sys_tf_adjusted = tf(k * n, d);

        % Plot the Bode plot of the adjusted system
        figure;
        bode(sys_tf_adjusted, w);
        title('Bode Plot of the Adjusted System');
        grid on;
        
        % Calculate the new gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
        [gm, pm, gcf, pcf] = margin(sys_tf_adjusted);
        value = [gm, pm, gcf, pcf];
        disp('Adjusted system margins:');
        disp(value);
        gm_db = 20 * log10(gm);  % Convert gm to dB
        disp(gm_db);

    case 2
        % Desired phase margin in degrees
        pm_des = 30;
        
        % Calculate the phase value corresponding to the desired phase margin at the gain crossover frequency
        gcf_phase_desired = -180 + pm_des;
        
        % Extract the magnitude and phase response
        [mag, phase, wout] = bode(sys_tf, w);
        mag_dB = 20*log10(squeeze(mag)); % Convert magnitude to dB
        phase_deg = squeeze(phase); % Extract phase response in degrees
        
        % Interpolate to find the frequency corresponding to the desired phase value
        gcf_new = interp1(phase_deg, wout, gcf_phase_desired);
        
        % Display the calculated gain crossover frequency
        disp(['Calculated Gain Crossover Frequency (GCF): ', num2str(gcf_new)]);
        
        
        gcf_mag = interp1(wout, mag_dB, gcf_new );
        disp(gcf_mag);
        
        k = power(10, -gcf_mag/20);  % Convert the dB increase to a multiplicative factor
        
        % Create the new transfer function with the adjusted gain
        sys_tf_adjusted = tf(k * n, d);
        
        % Plot the Bode plot of the adjusted system
        figure;
        bode(sys_tf_adjusted, w);
        title('Bode Plot of the Adjusted System');
        grid on;
        
        % Calculate the new gain margin (gm), phase margin (pm), gain crossover frequency (gcf), and phase crossover frequency (pcf)
        [gm, pm, gcf, pcf] = margin(sys_tf_adjusted);
        value = [gm, pm, gcf, pcf];
        disp('Adjusted system margins:');
        disp(value);
        disp(pm);

    case 3
        % Desired gain crossover frequency
        gcf_des = 1.5;
        
        % Obtain the magnitude and phase at the desired frequency
        [mag, phase, wout] = bode(sys_tf, w);
        mag_dB = 20*log10(squeeze(mag));
        gcf1_mag = interp1(wout, mag_dB, gcf);
        disp(gcf1_mag);
        k_prime = power(10,gcf1_mag / 20);
        disp(k_prime);
        gcf_mag = interp1(wout, mag_dB, gcf_des);
        
        % Calculate the required gain adjustment
        required_gain_dB = -gcf_mag;  % To make magnitude 0 dB at 1.5 rad/s
        k = 10^(required_gain_dB / 20);  % Convert the dB to a multiplicative factor
        
        % Create the new transfer function with the adjusted gain
        sys_tf_adjusted = tf(k * n, d);
        
        % Plot the Bode plot of the adjusted system
        figure;
        bode(sys_tf_adjusted, w);
        title('Bode Plot of the Adjusted System');
        grid on;
        
        [mag, phase, wout] = bode(sys_tf_adjusted, w);
        mag=squeeze(mag);
        omega_des = interp1( mag, wout,1);
        disp(omega_des)
end
