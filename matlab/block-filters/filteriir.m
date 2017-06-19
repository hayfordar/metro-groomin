%% MATLAB implementation of a 2nd-order IIR filter
% An nth even-order filter can be created by chain rule, i.e.,
% y(n) = G * F_(n-0)( (F_(n-1)( ... F_2( F_1( x(n) ) ) ... ) )
% where G is the gain and F_(n-i) is the output of an IIR filter at the
% (n-i)th stage
%
% To calculate y(n) using an infinite inpulse response filter, we can use
% the representation of a second order IIR filter's transfer function:
%
% H(z) = G (b0 + b1*z^-1 + b2*z^-2)/(a0 + a1*z^-1 + a2*z^-2)
%
% rearranging terms in the discrete time domain gives:
% a0*y(n) + a1*y(n-1) + a2*y(n-2) = b0*x(n) + b1*x(n-1) + b2*x(n-2)
% and again rearranging terms to get y(n) = ...
% y(n) = 1/a0 ( b0*x(n) + b1*x(n-1) + b2*x(n-2) - a1*y(n-1) - a2*y(n-2) )
%
% if we use the direct form II representation, we can simplify the y(n-1)
% and y(n-2) unknowns to something in terms of x(n). this will give us an
% intermediate function m(n), where is given by:
%
% m(n) = x(n) - a1*x(n-1) - a2*x(n-2)
%
% and by reviewing the direct form II representation again, we can get
% everything on the right hand side in terms of m(n), x(n), and our known
% coefficients
%
% y(n) = 1/a0 ( b0*m(n) + b1*m(n-1) + b2*m(n-2) )
%

function y = filteriir(x, b, a)
    if length(b) ~= length(a)
        error('ERROR: The transfer function must be a ratio of quadratics');
    end
    
    if a(1) == 0
        error('ERROR: A value of a0 == 0 will cause divide by zero')
    end
    
    blocksize = length(x);
    y = zeros(1, blocksize);
    
    % We don't need to do anything if samples block is blank
    if blocksize == 0
        return
    end
    
    n = 1;
    
    % go through all samples 
    while n <= blocksize
        % y(n) = 1/a0 ( b0*m(n) + b1*m(n-1) + b2*m(n-2) )
        y(n) = (b(1)*df2_interm_f(n, x, a) + ...
                b(2)*df2_interm_f(n-1, x, a) + ...
                b(3)*df2_interm_f(n-2, x, a) ...
                ) * 1/a(1);

        n = n + 1;
    end
end