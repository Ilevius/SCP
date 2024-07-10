clc; close;


data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\top_conditions.txt");

fp = figure;
plot(data(:,1), data(:,2))
legend('T11 on top');

fr = figure;
plot(data(:,1), data(:,3))
legend('T12 on top');

fm = figure;
plot(data(:,1), data(:,4))
legend('T21 on top');

fs = figure;
plot(data(:,1), data(:,5))
legend('T22 on top');


data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\tests\bottom_conditions.txt");

fp = figure;
plot(data(:,1), data(:,2))
legend('T11 on bottom');

fr = figure;
plot(data(:,1), data(:,3))
legend('T12 on bottom');

fm = figure;
plot(data(:,1), data(:,4))
legend('T21 on bottom');

fs = figure;
plot(data(:,1), data(:,5))
legend('T22 on bottom');