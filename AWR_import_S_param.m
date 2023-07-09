% S-parameters AWR-imported

%%

clc;
clear all;
close all;

Z0 = 50;
gm = 10.98;
gds = 0.48;
Y11 = 0;
Y12 = 0;
Y21 = gm;
Y22 = gds;

y_LowFreq_params = [Y11, Y12; Y21, Y22];

S11_meas_dB_5GHz = -1.62;
S12_meas_dB_5GHz = -26.8;
S21_meas_dB_5GHz = 11;
S22_meas_dB_5GHz = -10.6;
S_matrix_dB_5GHz = [S11_meas_dB_5GHz, S12_meas_dB_5GHz; S21_meas_dB_5GHz, S22_meas_dB_5GHz];
S_matrix_mag_5GHz = [db2mag(S11_meas_dB_5GHz), db2mag(S12_meas_dB_5GHz); db2mag(S21_meas_dB_5GHz), db2mag(S22_meas_dB_5GHz)];

S11_meas_deg_5GHz = -174.6;
S12_meas_deg_5GHz = 6.325;
S21_meas_deg_5GHz = 63;
S22_meas_deg_5GHz = -143;
S_matrix_deg_5GHz = [S11_meas_deg_5GHz, S12_meas_deg_5GHz; S21_meas_deg_5GHz, S22_meas_deg_5GHz];

S11_meas_5GHz = db2mag(S11_meas_dB_5GHz)*cos(deg2rad(S11_meas_deg_5GHz)) + j*db2mag(S11_meas_dB_5GHz)*sin(deg2rad(S11_meas_deg_5GHz));
S12_meas_5GHz = db2mag(S12_meas_dB_5GHz)*cos(deg2rad(S12_meas_deg_5GHz)) + j*db2mag(S12_meas_dB_5GHz)*sin(deg2rad(S12_meas_deg_5GHz));
S21_meas_5GHz = db2mag(S21_meas_dB_5GHz)*cos(deg2rad(S21_meas_deg_5GHz)) + j*db2mag(S21_meas_dB_5GHz)*sin(deg2rad(S21_meas_deg_5GHz));
S22_meas_5GHz = db2mag(S22_meas_dB_5GHz)*cos(deg2rad(S22_meas_deg_5GHz)) + j*db2mag(S22_meas_dB_5GHz)*sin(deg2rad(S22_meas_deg_5GHz));

S_matrix_meas_5GHz = [S11_meas_5GHz, S12_meas_5GHz; S21_meas_5GHz, S12_meas_5GHz];
Y_matrix_conv_5GHz = s2y(S_matrix_meas_5GHz, Z0);


S11_meas_dB_200MHz = 0.135;
S12_meas_dB_200MHz = -38.8;
S21_meas_dB_200MHz = 23.4;
S22_meas_dB_200MHz = -9.11;
S_matrix_dB_200MHz = [S11_meas_dB_200MHz, S12_meas_dB_200MHz; S21_meas_dB_200MHz, S22_meas_dB_200MHz];
S_matrix_mag_200MHz = [db2mag(S11_meas_dB_200MHz), db2mag(S12_meas_dB_200MHz); db2mag(S21_meas_dB_200MHz), db2mag(S22_meas_dB_200MHz)];


S11_meas_deg_200MHz = -17.18;
S12_meas_deg_200MHz = 82.08;
S21_meas_deg_200MHz = 170.7;
S22_meas_deg_200MHz = -16.81;
S_matrix_deg_200MHz = [S11_meas_deg_200MHz, S12_meas_deg_200MHz; S21_meas_deg_200MHz, S22_meas_deg_200MHz];

S11_meas_200MHz = db2mag(S11_meas_dB_200MHz)*cos(deg2rad(S11_meas_deg_200MHz)) + j*db2mag(S11_meas_dB_200MHz)*sin(deg2rad(S11_meas_deg_200MHz));
S12_meas_200MHz = db2mag(S12_meas_dB_200MHz)*cos(deg2rad(S12_meas_deg_200MHz)) + j*db2mag(S12_meas_dB_200MHz)*sin(deg2rad(S12_meas_deg_200MHz));
S21_meas_200MHz = db2mag(S21_meas_dB_200MHz)*cos(deg2rad(S21_meas_deg_200MHz)) + j*db2mag(S21_meas_dB_200MHz)*sin(deg2rad(S21_meas_deg_200MHz));
S22_meas_200MHz = db2mag(S22_meas_dB_200MHz)*cos(deg2rad(S22_meas_deg_200MHz)) + j*db2mag(S22_meas_dB_200MHz)*sin(deg2rad(S22_meas_deg_200MHz));

S_matrix_meas_200MHz = [S11_meas_200MHz, S12_meas_200MHz; S21_meas_200MHz, S12_meas_200MHz];
Y_matrix_conv_200MHz = s2y(S_matrix_meas_200MHz, Z0);

s_LowFreq_params_model = y2s(y_LowFreq_params, Z0);
