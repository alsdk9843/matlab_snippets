% S-parameters model

%%

clc;
clear all;
close all;

Z0 = 50;

S_measuredHEMT = sparameters('TGF2018_S_parameters.s2p');
parameters = S_measuredHEMT.Parameters;
param_size = size(parameters);

n = 0;
%%

freq = S_measuredHEMT.Frequencies;
freq_step = freq(2)-freq(1);
last_freq = freq(1) + (freq(2)-freq(1))*(size(freq)-1);

index_800MHz = 1;
index_8GHz = index_800MHz +(8*10^9 - freq(index_800MHz))/(freq_step);


S_matrix_HEMT_8GHz_s2p = parameters(:,:,index_8GHz);
Y_matrix_HEMT_8GHz = s2y(S_matrix_HEMT_8GHz_s2p, Z0);

S_matrix_HEMT_800MHz_s2p = parameters(:,:,index_800MHz);
Y_matrix_HEMT_800MHz = s2y(S_matrix_HEMT_800MHz_s2p, Z0);

%%

for n = drange(1:param_size(3))
   S11_measHEMT(n) = parameters(4*n - 3);
end

for n = drange(1:param_size(3))
   S12_measHEMT(n) = parameters(4*n - 2);
end

for n = drange(1:param_size(3))
   S21_measHEMT(n) = parameters(4*n - 1);
end

for n = drange(1:param_size(3))
   S22_measHEMT(n) = parameters(4*n - 0);
end


S11_measHEMT_dB = 20*log10(abs(S11_measHEMT));
S12_measHEMT_dB = 20*log10(abs(S12_measHEMT));
S21_measHEMT_dB = 20*log10(abs(S21_measHEMT));
S22_measHEMT_dB = 20*log10(abs(S22_measHEMT));

S11_measHEMT_ang = unwrap(radtodeg(angle(S11_measHEMT)));
S12_measHEMT_ang = unwrap(radtodeg(angle(S12_measHEMT)));
S21_measHEMT_ang = unwrap(radtodeg(angle(S21_measHEMT)));
S22_measHEMT_ang = unwrap(radtodeg(angle(S22_measHEMT)));



%%

gm = 0.1078;
gds = 0.0003;
Av = gm/gds;
Cgd = 0.044*10^-12;
Cgs = 0.645*10^-12;
Cds = 0.078*10^-12;
f = freq(1):freq_step:last_freq(1);
w = 2*pi*f;
Y0 = 1/Z0;

Y11_model = i.*w.*(Cgs + Cgd);
Y12_model = - i.*w.*Cgd;
Y21_model = gm - i.*w.*Cgd;
Y22_model = gds + i.*w.*(Cds + Cgd);

for n = drange(1:param_size(3))
    Y_param_model(1, 1, n) = Y11_model(n);
    Y_param_model(1, 2, n) = Y12_model(n);
    Y_param_model(2, 1, n) = Y21_model(n);
    Y_param_model(2, 2, n) = Y22_model(n);
    
    S_param_model_y2s(:, :, n) = y2s(Y_param_model(:, :, n),Z0);
end


for n = drange(1:param_size(3))
   S11_model_y2s(n) = S_param_model_y2s(4*n - 3);
end

for n = drange(1:param_size(3))
   S12_model_y2s(n) = S_param_model_y2s(4*n - 2);
end

for n = drange(1:param_size(3))
   S21_model_y2s(n) = S_param_model_y2s(4*n - 1);
end

for n = drange(1:param_size(3))
   S22_model_y2s(n) = S_param_model_y2s(4*n - 0);
end


S11_model_y2s_dB = 20*log10(abs(S11_model_y2s));
S12_model_y2s_dB = 20*log10(abs(S12_model_y2s));
S21_model_y2s_dB = 20*log10(abs(S21_model_y2s));
S22_model_y2s_dB = 20*log10(abs(S22_model_y2s));

S11_model_y2s_ang = radtodeg(angle(S11_model_y2s));
S12_model_y2s_ang = radtodeg(angle(S12_model_y2s));
S21_model_y2s_ang = radtodeg(angle(S21_model_y2s));
S22_model_y2s_ang = radtodeg(angle(S22_model_y2s));



figure (1)
% ax = gca;
plot(freq, S11_measHEMT_dB, '-.r','LineWidth', 2);
hold on;
plot(freq, S12_measHEMT_dB, '-.b','LineWidth', 2);
hold on;
plot(freq, S21_measHEMT_dB, '-.m','LineWidth', 2);
hold on;
plot(freq, S22_measHEMT_dB, '-.k','LineWidth', 2);
hold on;
plot(freq, S11_model_y2s_dB, '-r','LineWidth', 2);
hold on;
plot(freq, S12_model_y2s_dB, '-b','LineWidth', 2);
hold on;
plot(freq, S21_model_y2s_dB, '-m','LineWidth', 2);
hold on;
plot(freq, S22_model_y2s_dB, '-k','LineWidth', 2);
hold on;
grid on;
title('S-parameters - TGF2018 - Qorvo HEMT');
xlabel('Freq (GHz)');
ylabel('S - parameters mag. (dB)');
% ax = gca; % handle of current axes
% ax.FontSize = 12;
% ax.TickDir = 'out';
% ax.TickLength = [0.02,0.02];
% ylim = [-2,16];
% xlim([0 30]*10^9);
% ax.TickLength = [0.02,0.02];
leg1 = legend('S11 measured (HEMT)', 'S12 measured (HEMT)', 'S21 measured (HEMT)', 'S22 measured (HEMT)', 'S11 model (HEMT)', 'S12 model (HEMT)', 'S21 model (HEMT)', 'S22 model (HEMT)');


figure (2)
% ax = gca;
plot(freq, S11_measHEMT_ang, '-.r','LineWidth', 2);
hold on;
plot(freq, S12_measHEMT_ang, '-.b','LineWidth', 2);
hold on;
plot(freq, S21_measHEMT_ang, '-.m','LineWidth', 2);
hold on;
plot(freq, S22_measHEMT_ang, '-.k','LineWidth', 2);
hold on;
plot(freq, S11_model_y2s_ang, '-r','LineWidth', 2);
hold on;
plot(freq, S12_model_y2s_ang, '-b','LineWidth', 2);
hold on;
plot(freq, S21_model_y2s_ang, '-m','LineWidth', 2);
hold on;
plot(freq, S22_model_y2s_ang, '-k','LineWidth', 2);
hold on;
grid on;
title('S-parameters - TGF2018 - Qorvo HEMT');
xlabel('Freq (GHz)');
ylabel('S - parameters ang. (deg)');
% ax = gca; % handle of current axes
% ax.FontSize = 12;
% ax.TickDir = 'out';
% ax.TickLength = [0.02,0.02];
% ylim = [-2,16];
% xlim([0 30]*10^9);
% ax.TickLength = [0.02,0.02];
leg2 = legend('S11 measured (HEMT)', 'S12 measured (HEMT)', 'S21 measured (HEMT)', 'S22 measured (HEMT)', 'S11 model (HEMT)', 'S12 model (HEMT)', 'S21 model (HEMT)', 'S22 model (HEMT)');


