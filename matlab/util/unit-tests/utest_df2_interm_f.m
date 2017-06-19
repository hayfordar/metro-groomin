%% Unit testing of the intermediate function m(n)
%
% This file contains unit tests of df2_interm_f(k, x, a),
% which calculates the value:
%
% m(n) = x(n) - a1*x(n-1) - a2*x(n-3) 
%
% where m(n) is the value of the intermediate function as given by the
% Direct Form II representation of a second order IIR filter, x(n) is the
% nth sample of the input signal x, and a1 and a2 are coefficients of the
% transfer function below:
%
% H(z) = G (b0 + b1*z^-1 + b2*z^-2)/(a0 + a1*z^-1 + a2*z^-2)
%

% Polynomial coefficients of denominator of transfer function
a = [1 2 3];

% Input Samples
x = [0 1 2 3 10 10 10 10 9 8 7 6];

% Try to index at 0
mn = df2_interm_f(0, x, a);
assert(isequal(mn, 0));

% All polynomial coefficients as zero
mn = df2_interm_f(5, x, [0 0 0]);
assert(isequal(mn, x(5)));

% Corner case 1, no x(n-1)
mn = df2_interm_f(1, x, a);
assert(isequal(mn, x(1)));

% Corner case 2, no x(n-2)
mn = df2_interm_f(2, x, a);
assert(isequal(mn, x(2) - a(2)*x(1)));

% Normal case 1
mn = df2_interm_f(3, x, a);
assert(isequal(mn, x(3) - a(2)*x(2) - a(3)*x(1)));

% Normal case 2
mn = df2_interm_f(7, x, a);
assert(isequal(mn, x(7) - a(2)*x(6) - a(3)*x(5)));