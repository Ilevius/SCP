clc; close all; clear;

data1 = load("residues\1.txt");
data2 = load("residues\2.txt");
data3 = load("residues\3.txt");
data4 = load("residues\4.txt");
data5 = load("residues\5.txt");
data6 = load("residues\6.txt");
data7 = load("residues\7.txt");



IMMIstyle2024(160 , 100, 14, 2, 7);
IMMIstyle2024(widthmm , hightmm, textpt, lineWidth, markerSize)
marker = '-';
plot(data1(:,1), data1(:,3), marker, data2(:,1), data2(:,3), marker, data3(:,1), data3(:,3), marker, ...
    data4(:,1), data4(:,3), marker, data5(:,1), data5(:,3), marker, data6(:,1), data6(:,3), marker, ...
    data7(:,1), data7(:,3), marker);
xlim([0 2.5]); ylim([0 0.05]);
grid on;





