%% MATLAB implementation of FIR filter using the difference equation definition
% finite inpulse response filters give an output y(n):
% y(n) = h(k)x(n-k) for m = 0:M 
% where M is the number of coefficients in the numerator of the transfer
% function

function y = filterfir(x, h)
    % get lengths of impulse response h and input sample block
    blocksize = length(x);
    M = length(h);
    
    % init y(n)
    y = zeros(1,blocksize);

    % if either array is empty, exit now and return input signal
    if (blocksize == 0) || (M == 0)
        y(n) = x(n)
        return
    end
    
    
    n = 1;
    % for each n in the output y(n)
    while n <= blocksize
        k = 0;
        % for each value in range 0 -> size of impulse reponse
        while k < M
            % exit loop if we cannot index back any further
            if (n - k) <= 0
                break
            end
            % definition of fir filter, adjusted h(k) to deal with MATLAB
            % indicies
            y(n) = y(n) + h(k+1)*x(n-k);
            k = k + 1;
        end
        n = n + 1;
    end
end