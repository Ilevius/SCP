clc; close all; clear;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\simpleDcurves.txt");

data1 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\1.txt");
data2 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\2.txt");
data3 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\3.txt");
data4 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\4.txt");
data5 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\5.txt");
data6 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\6.txt");
% data7 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\7.txt");
% data8 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\8.txt");
% data9 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\9.txt");
% data10 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\10.txt");
% data11 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\11.txt");
% data12 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\12.txt");
% data13 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\13.txt");






plot(data(:,1), data(:,2).*data(:,1)*2*pi, '.');
hold on;
marker = '--';
plot(data1(:,1), data1(:,2), marker, data2(:,1), data2(:,2), marker, data3(:,1), data3(:,2), marker, ...
    data4(:,1), data4(:,2), marker, data5(:,1), data5(:,2), marker, data6(:,1), data6(:,2), marker, ...
    data1(:,1), data1(:,2), marker, data1(:,1), data1(:,2), marker, data1(:,1), data1(:,2), marker, ... 
    data1(:,1), data1(:,2), marker, data1(:,1), data1(:,2), marker, data1(:,1), data1(:,2), marker, ...
    data1(:,1), data1(:,2), marker);
