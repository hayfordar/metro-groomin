%% MATLAB implementation of symmetrical-mean value calculator
% interesting permutation of running-mean value where window for the mean
% is symmetrical in respect to the current input value x(n)
%
% y(n) = (1/M)(x(n-(M-1)/2) + ... + x(n) + .. x(n+(M-1)/2))  
%
% Corner cases where full M-sized window can't be fit causes similar course
% of action to running-mean value, where we average across the maximum
% amount of values we can when M-samples aren't available in the requested
% range.

function y = symmetrical_mean_value(x, M)
    blocksize = length(x);
    
    if blocksize == 0 || M == 0
        y = x;
        return
    elseif (rem(M,2) == 0) || (~isreal(M)) || (rem(M,1) ~= 0)
        error('ERROR: Window size M must be a real, non-negative, odd integer')
    end
    y = x
    

end