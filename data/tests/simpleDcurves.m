clc; close;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\YtopvsYbot.txt");

fp = figure;
plot(data(:,1), data(:,2), data(:,1), data(:,6), '--')
legend('P_{top}','P_{bottom}');

fr = figure;
plot(data(:,1), data(:,3), data(:,1), data(:,7), '--')
legend('R_{top}','R_{bottom}');

fm = figure;
plot(data(:,1), data(:,4), data(:,1), data(:,8), '--')
legend('M_{top}','M_{bottom}');

fs = figure;
plot(data(:,1), data(:,5), data(:,1), data(:,9), '--')
legend('S_{top}','S_{bottom}');


data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\TtopvsTbot.txt");

fp = figure;
plot(data(:,1), data(:,2), data(:,1), data(:,6), '--')
legend('T11_{top}','T11_{bottom}');

fr = figure;
plot(data(:,1), data(:,3), data(:,1), data(:,7), '--')
legend('T12_{top}','T12_{bottom}');

fm = figure;
plot(data(:,1), data(:,4), data(:,1), data(:,8), '--')
legend('T21_{top}','T21_{bottom}');

fs = figure;
plot(data(:,1), data(:,5), data(:,1), data(:,9), '--')
legend('T22_{top}','T22_{bottom}');