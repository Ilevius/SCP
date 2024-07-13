clc; close;

widthmm = 200;
hightmm = 140;
textpt = 14;
multiple = 1;
widpi = (650/127)*widthmm*multiple;
higpi = (480/127)*hightmm*multiple;
textri = textpt*multiple;
set(0, 'DefaultAxesFontSize', textri, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontSize', textri, 'DefaultTextFontName', 'Times New Roman');

f_pol = figure();

set (f_pol, 'Position', [200 200 widpi higpi]);
data1 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\1.txt");
data2 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\2.txt");
data3 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\3.txt");
data4 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\4.txt");
data5 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\5.txt");
data6 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\6.txt");
data7 = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\curves\7.txt");
mrk = '-';
plot(data1(:,1), data1(:,2)./data1(:,1), mrk, data2(:,1), data2(:,2)./data2(:,1), mrk, data3(:,1), data3(:,2)./data3(:,1), mrk ...
    , data4(:,1), data4(:,2)./data4(:,1), mrk, data5(:,1), data5(:,2)./data5(:,1), mrk, data6(:,1), data6(:,2)./data6(:,1), mrk...
    , data7(:,1), data7(:,2)./data7(:,1), mrk, 'LineWidth', 2)
xlim([0 1.5]); ylim([0 5]);
