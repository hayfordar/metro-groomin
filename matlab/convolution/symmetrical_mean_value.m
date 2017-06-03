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
    
    y = zeros(1, blocksize);
    
    n = 1;
    while n <= blocksize
        i = 1;
        y(n) = x(n);
        while i <= (M-1)/2 
            if (n - i) <= 0 || (n + i) > blocksize
                break
            end
            y(n) = y(n) + x(n + i) + x(n - i);
            i = i + 1;
        end
        y(n) = y(n) / (2*i - 1);
        n = n + 1;
    end

end