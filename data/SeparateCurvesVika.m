clc; close all; clear;
data1 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\1.txt");
data2 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\2.txt");
data3 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\3.txt");
data4 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\4.txt");
data5 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\5.txt");
data6 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\6.txt");
data7 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\7.txt");
data8 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\8.txt");
data9 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\9.txt");
data10 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\10.txt");
data11 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\11.txt");
data12 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\12.txt");
data13 = load("C:\Users\tiama\OneDrive\������� ����\IMMI\Super Curve Program\data\A2Sc0,05G3v1\13.txt");

h = 0.005;
[gv12, gv11] = dxdf(data1(:,1), data1(:,2), h);
[gv22, gv21] = dxdf(data2(:,1), data2(:,2), h);
[gv32, gv31] = dxdf(data3(:,1), data3(:,2), h);
[gv42, gv41] = dxdf(data4(:,1), data4(:,2), h);
[gv52, gv51] = dxdf(data5(:,1), data5(:,2), h);
[gv62, gv61] = dxdf(data6(:,1), data6(:,2), h);
[gv72, gv71] = dxdf(data7(:,1), data7(:,2), h);
[gv82, gv81] = dxdf(data8(:,1), data8(:,2), h);
[gv92, gv91] = dxdf(data9(:,1), data9(:,2), h);
[gv102, gv101] = dxdf(data10(:,1), data10(:,2), h);
[gv112, gv111] = dxdf(data11(:,1), data11(:,2), h);
[gv122, gv121] = dxdf(data12(:,1), data12(:,2), h);
[gv132, gv131] = dxdf(data13(:,1), data13(:,2), h);

lineX = [0 2.5]; lineY = [0 0];




widthmm = 160;
hightmm = 120;
textpt = 14;
multiple = 1;
widpi = (650/127)*widthmm*multiple;
higpi = (480/127)*hightmm*multiple;
textri = textpt*multiple;
set(0, 'DefaultAxesFontSize', textri, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontSize', textri, 'DefaultTextFontName', 'Times New Roman');

slownPlot = figure();
set (slownPlot, 'Position', [200 200 widpi higpi]);

mrk = '-'; yFac = 1/(2*pi);
plot( data1(:,1), data1(:,2)./data1(:,1)*yFac, mrk, data2(:,1), data2(:,2)./data2(:,1)*yFac, mrk, data3(:,1), data3(:,2)./data3(:,1)*yFac, mrk ...
    , data4(:,1), data4(:,2)./data4(:,1)*yFac, mrk, data5(:,1), data5(:,2)./data5(:,1)*yFac, mrk, data6(:,1), data6(:,2)./data6(:,1)*yFac, mrk...
    , data7(:,1), data7(:,2)./data7(:,1)*yFac, mrk, data8(:,1), data8(:,2)./data8(:,1)*yFac, mrk, data9(:,1), data9(:,2)./data9(:,1)*yFac, mrk...
    ,data10(:,1), data10(:,2)./data10(:,1)*yFac, mrk, data11(:,1), data11(:,2)./data11(:,1)*yFac, mrk ...
    ,data12(:,1), data12(:,2)./data12(:,1)*yFac, mrk, data13(:,1), data13(:,2)./data13(:,1)*yFac, mrk, 'LineWidth',2)
xlim([0 2.5]); ylim([0 0.5]);


grVelPlot = figure();
mrk = '-'; yFac = 2*pi;
set (grVelPlot, 'Position', [200 200 widpi higpi]);
plot(gv11, gv12*yFac, mrk, gv21, gv22*yFac, mrk, gv31, gv32*yFac, mrk, gv41, gv42*yFac, mrk, ...
    gv51, gv52*yFac, mrk, gv61, gv62*yFac, mrk, gv71, gv72*yFac, mrk, gv81, gv82*yFac, mrk, ...
    gv91, gv92*yFac, mrk, gv101, gv102*yFac, mrk,gv111, gv112*yFac, mrk,gv121, gv122*yFac, mrk, ...
    gv131, gv132*yFac, mrk,lineX, lineY, 'black--', 'LineWidth',2);

