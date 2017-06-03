%% MATLAB implementation of cumulative-mean value calculator
% cumulative-mean value given by:
% y(n) = sum(x(1) + ... x(n))/n
% or equivalently:
% y(n+1) = (x(n+1) + n*y(n))/n
%
% each value of y(n) is given by the average of all n-samples of x prior
%
function y = cumulative_mean_value(x)
    y = zeros(1, length(x));
    n = 1;
    
    % no values to calculate if no input samples
    if isequal(x, [])
        y = [];
        return
    end
    
    % while we're still in the block of samples of input
    while n <= length(x)
        i = 0;
        % add each sample prior to x(n+1)
        while i < n
            y(n) = y(n) + x(n-i);
            i = i + 1;
        end
        % divide by the number of samples included in the mean
        y(n) = y(n) / n;
        n = n + 1;
    end
end