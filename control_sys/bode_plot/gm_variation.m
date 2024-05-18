% Define the numerator and denominator of the transfer function
n = [1];
d = [0.1 1.1 1 0];

% Define the frequency range for the Bode plot
a = -2;
b = 2;
w = logspace(a, b);

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

% Desired gain margin in dB
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

% Commented out detailed information about the margin function
%{
    margin  Gain and phase margins and crossover frequencies.
 
    [Gm,Pm,Wcg,Wcp] = margin(SYS) computes the gain margin Gm, the phase
    margin Pm, and the associated frequencies Wcg and Wcp, for the SISO
    open-loop model SYS (continuous or discrete). The gain margin Gm is
    defined as 1/G where G is the gain at the -180 phase crossing. The
    phase margin Pm is in degrees. The frequencies Wcg and Wcp are in
    radians/TimeUnit (relative to the time units specified in SYS.TimeUnit,
    the default being seconds).
 
    The gain margin in dB is derived by
       Gm_dB = 20*log10(Gm)
    The loop gain at Wcg can increase or decrease by this many dBs before
    losing stability, and Gm_dB<0 (Gm<1) means that stability is most
    sensitive to loop gain reduction.  If there are several crossover
    points, margin returns the smallest margins (gain margin nearest to
    0dB and phase margin nearest to 0 degrees).
 
    For a S1-by...-by-Sp array of linear systems, margin returns
    arrays of size [S1 ... Sp] such that
       [Gm(j1,...,jp),Pm(j1,...,jp)] = margin(SYS(:,:,j1,...,jp)) .
 
    [Gm,Pm,Wcg,Wcp] = margin(MAG,PHASE,W) derives the gain and phase margins
    from the Bode magnitude, phase, and frequency vectors MAG, PHASE, and W
    produced by BODE. margin expects gain values MAG in absolute units and
    phase values PHASE in degrees. Interpolation is performed between
    frequency points to approximate the true stability margins. comment out the entire thing
%}
