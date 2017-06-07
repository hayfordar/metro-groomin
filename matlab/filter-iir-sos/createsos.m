%% MATLAB implementation of second-order filter generator to meet filter specs
%
% createsos(zeros, poles, ) creates second-order sections to implement
% a filter described by the input poles and zeros
%

function [sos,g] = createsos(zeros, poles, N)
    % Obtain a and b coefficients 
    b = poly(zeros) ;
    a = poly(poles) ;
      
    % Calculate maximum gain and adjust numerator by scale factor to reduce
    % gain to 0dB
    gmax = filternorm(b, a, inf);
    k = 1/gmax;
    
    % setup sections
    [sos, g] = zp2sos(zeros, poles, k, 'up', 'inf') ;
end



