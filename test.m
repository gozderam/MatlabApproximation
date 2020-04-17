function [TAB, MSE] = test(x_points, fun, m)
% Function TEST returns TAB - matrix, which colums are: arguments, values
% of target function fun, values of approximate function, and relative error in m points. 
% MSE is the value of mean squared error for this data. Furhermore, function draws plots of fun
% and approximation function.

% approximation
approx_fun = approximation(x_points, fun);
h = (x_points(length(x_points))-x_points(1))/(m-1);
x = x_points(1):h:x_points(length(x_points));
y_exact = fun(x);
y_approx = zeros(1, length(x));
for i=1:length(x)
    y_approx(i) = approx_fun(x(i));
end

% plot
figure;
plot(x, y_exact, x, y_approx);
legend("target function", "approximation function");
TAB=[x', y_exact', y_approx', (abs(y_exact-y_approx)./abs(y_exact))'];
MSE = mean_squared_error(y_exact, y_approx);
end

