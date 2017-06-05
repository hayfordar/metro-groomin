function [a, b, hf] = getfreqresp(poles, zeros, N)
    a = poly(poles) ;
    b = poly(zeros) ;

    % Evaluate numerator and denominator for z = e^(j2pif)
    f = linspace(-0.5, 0.5, N);
    z = exp(j*2*pi*f);
    num = polyval(b, z);
    den = polyval(a, z); 

    % Get frequency response
    hf = 20*log10(abs(num./den));
    
end