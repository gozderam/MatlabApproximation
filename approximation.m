function [approx_fun] = approximation(x_points, fun)
% Function APPROXIMATION returns function approx_fun, which is the
% approximation function (continuous least squares approximation)
% fun in space of linear splines. Spline functions are defined on points
% from x_points vector.

n = length(x_points);

% diagonals
diag2 = zeros(n, 1);
diag3 = zeros(n-1, 1);

% vector of constant terms
d = zeros(n, 1);

xi = x_points(1);
xi1 = x_points(2);
g1 = @(x) ((xi1-x)./(xi1-xi)) .* ((xi1-x)./(xi1-xi));
diag2(1) = integral_value(g1,xi,xi1);
gi = @(x) fun(x) .* (((xi1-x)./(xi1-xi)));
d(1) = integral_value(gi, xi, xi1);

xi = x_points(n-1);
xi1 = x_points(n);
gn = @(x) ((x-xi)./(xi1-xi)) .* ((x-xi)./(xi1-xi));
diag2(n) = integral_value(gn, xi, xi1);
gn = @(x) fun(x) .* ((x-xi)./(xi1-xi));
d(n) = integral_value(gn, xi, xi1);

for i=2:n-1
    xi_1 = x_points(i-1);
    xi = x_points(i);
    xi1 = x_points(i+1);
    gi = @(x) ((x-xi_1)./(xi-xi_1) .* (x-xi_1)./(xi-xi_1));
    gii = @(x) ((xi1-x)./(xi1-xi) .*(xi1-x)./(xi1-xi) );
    diag2(i) = integral_value(gi, xi_1, xi) + integral_value(gii, xi, xi1);
    gi = @(x) ((x-xi_1)./(xi-xi_1)) .* fun(x);
    gii = @(x) ((xi1-x)./(xi1-xi) .* fun(x) );
    d(i) = integral_value(gi, xi_1, xi) + integral_value(gii, xi, xi1);   
end

for i=1:n-1
    xi=x_points(i);
    xi1=x_points(i+1);
    gi = @(x) ((xi1-x)./(xi1-xi)) .* ((x-xi)./(xi1-xi));
    diag3(i) = integral_value(gi, xi, xi1);
end

diag1 = diag3;

% solution vector
L = tridiag_GE(diag1, diag2, diag3, d)';

base_splines = cell(n, 1);
approx_fun = @(x) 0;
for i=1:n
    base_splines{i} = spline(i, x_points);
    approx_fun = @(x) approx_fun(x) + L(i)*base_splines{i}(x);
end



