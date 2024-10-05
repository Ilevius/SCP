clc; close all; clear;

data1 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\1.txt");
data2 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\2.txt");
data3 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\3.txt");
data4 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\4.txt");
data5 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\5.txt");
data6 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\6.txt");
data7 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\7.txt");
data8 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\8.txt");
data9 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\9.txt");
data10 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\10.txt");
data11 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\11.txt");
data12 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\12.txt");
data13 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\Repulsion\DataFigs\separateDcurves\A2Sc0,05G3v1\residues\13.txt");


IMMI2024(160 , 100, 14, 2, 7);
marker = '-';
plot(data1(:,1), data1(:,3), marker, data2(:,1), data2(:,3), marker, data3(:,1), data3(:,3), marker, ...
    data4(:,1), data4(:,3), marker, data5(:,1), data5(:,3), marker, data6(:,1), data6(:,3), marker, ...
    data7(:,1), data7(:,3), marker, data8(:,1), data8(:,3), marker, data9(:,1), data9(:,3), marker, ... 
    data10(:,1), data10(:,3), marker, data11(:,1), data11(:,3), marker, data12(:,1), data12(:,3), marker, ...
    data13(:,1), data13(:,3), marker);
xlim([0 2.5]); %ylim([0 0.05]);
grid on;

IMMI2024(160 , 100, 14, 2, 7);

plot(data1(:,1), data1(:,2)./(data1(:,1)*2*pi), marker, data2(:,1), data2(:,2)./(data2(:,1)*2*pi), marker, data3(:,1), data3(:,2)./(data3(:,1)*2*pi), marker, ...
    data4(:,1), data4(:,2)./(data4(:,1)*2*pi), marker, data5(:,1), data5(:,2)./(data5(:,1)*2*pi), marker, data6(:,1), data6(:,2)./(data6(:,1)*2*pi), marker, ...
    data7(:,1), data7(:,2)./(data7(:,1)*2*pi), marker, data8(:,1), data8(:,2)./(data8(:,1)*2*pi), marker, data9(:,1), data9(:,2)./(data9(:,1)*2*pi), marker, ... 
    data10(:,1), data10(:,2)./(data10(:,1)*2*pi), marker, data11(:,1), data11(:,2)./(data11(:,1)*2*pi), marker, data12(:,1), data12(:,2)./(data12(:,1)*2*pi), marker, ...
    data13(:,1), data13(:,2)./(data13(:,1)*2*pi), marker);
xlim([0 2.5]); ylim([0 0.5]);
grid on;