function [dxdf, xx] = dxdf(x, y, h)
    % ������ �� x 
    yy = y(1):h:y(length(y));
    % ���������� ����� y
    xx = spline(y,x,yy);
    % ����� ��� ��� � ������ �����
    dxdf = diff(xx)/h;
    n = length(dxdf);
    xx = xx(1:n);
    
    % % selfTest
    % x = 0.1:0.1:10;
    % y = x.^2;
    % df = naive_diff(transpose(x), transpose(y));
    % selfTest = figure('Name','Self test','NumberTitle','off');;
    % plot(df(:,1), df(:,2), '--g');
    % % end selfTest

    % 
    % % %  spline Test
    % x = 0:0.1:10;
    % y = x.^2;
    % h = 0.01;
    % 
    % [dxdf1, xx1] = dxdf(x, y, h);
    % 
    % %   ������ �� x 
    % xx = x(1):h:x(length(x));
    % %   ���������� ����� y
    % yy = spline(x,y,xx);
    % % graph is OK
    % selfTest = figure('Name','Spline results','NumberTitle','off');;
    % plot(x, y, xx, yy, '--');
    % grid on;
    % 
    % dxdf = h./diff(yy);
    % n = length(dxdf);
    % xx = xx(1:n);
    % d = figure('Name','Diff result','NumberTitle','off');;
    % plot(xx, dxdf, '--', xx1, dxdf1, 'o');
    % grid on;

    % % end spline Test
end