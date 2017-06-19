%% MATLAB implementation of the intermediate function from Direct Form II
%
% View filteriir.m for an explaination of how the intermediate function
% plays into the output y(n) of a 2nd order IIR filtered input sample block
% x(n)
%
% m(k) = x(k) + a1*x(k-1) + a2*x(k-2)
%
% The intermediate function is called directly in the equation for y(n)
%
% y(n) = 1/a0 ( b0*m(n) + b1*m(n-1) + b2*m(n-2) )
%
function mn = df2_interm_f(k, x, a)
    if length(a) ~= 3
        error('Coefficients need to be in array [a0 a1 a2]')
    end
    mn = 0;
    
    if k < 1
        return
    end
    
    mn = x(k);
    
    if k - 1 < 1
        return
    end
    
    mn = mn - a(2)*x(k-1);
    
    if k - 2 < 1
        return
    end
    
    mn = mn - a(3)*x(k-2);
end
    
            
    
    