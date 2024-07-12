clc; close;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\data\simpleDcurves.txt");
plot(data(:,1), data(:,2), '.')

hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\1Curve.txt");
plot(data(:,1), data(:,2), 'o')



hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\3Curve.txt");
plot(data(:,1), data(:,2), 'o')


hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\4Curve.txt");
plot(data(:,1), data(:,2), 'o')

hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\5Curve.txt");
plot(data(:,1), data(:,2), 'o')


hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\6Curve.txt");
plot(data(:,1), data(:,2), 'o')


hold on;
data = load("C:\Users\tiama\OneDrive\Рабочий стол\IMMI\Super Curve Program\fortran\SCP\7Curve.txt");
plot(data(:,1), data(:,2), 'o')


