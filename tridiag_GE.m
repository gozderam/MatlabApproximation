function [x] = tridiag_GE(d1, d2, d3, b)
% Function TRIDIAG_GE returns the solution of the system of linear
% equations with thridiagonal matrix (d1, d2, d3 - diagonals, b - vector of constant terms).
% It uses Gauss Elimination algorithm.

N = length(d2);
M = [[0;d1], d2, [d3;0]];
x = zeros(N, 1);

for i = 1:N-1
   b(i+1) = b(i+1) - (M(i+1, 1)/M(i, 2))*b(i);
   M(i+1, 1:2) = M(i+1, 1:2) - (M(i+1, 1)/M(i, 2)) * M(i, 2:3);
end

x(N)= b(N)/M(N, 2);
for i=N-1:-1:1
    x(i) = (b(i) - x(i+1)*M(i, 3)) / M(i, 2);
end

