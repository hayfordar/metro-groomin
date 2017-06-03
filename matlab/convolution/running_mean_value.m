%% MATLAB implementation of running-mean value calculator
% signals are read in as blocks of samples of size 'blocksize'
% where the average is taken over the last 'M'-many samples
%
% This can be expressed mathematically as:
% y(n) = (1/M)(x(n-i)) for i=0:i=M-1
% x(n) is the samples of the input signal
%
% The nth sample of y(n) is given by the average over the last 'M'-many 
% samples of x(n)

function y = running_mean_value(x, M)
   blocksize = length(x);
   
   if blocksize == 0 || M == 0
       y = x;
       return;
   end
   
   y = zeros(1,blocksize);
   
   % for each sample
   for n = 1:blocksize
       i = 0;
       % continue until we reach window size or
       % we reach the first sample in the block
       while (i <= (M-1)) && ((n-i) > 0)
           y(n) = y(n) + x(n-i);
           i = i + 1;
       end
       % in case where we don't have M-many samples, we know how many
       % samples we've actually included in the running mean value
       y(n) = y(n) / i;
   end
end

