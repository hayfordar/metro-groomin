%% MATLAB utility to create an IIR filter from a cascaded structure of 2nd order filters
%
% Creates an IIR filter that satisfies the provided poles and zeros using a
% series of 2nd order sections
%
% Requires a list of poles and zeros in the form ae^(+/-j2pif) and number
% of samples (N). x_specs and y_specs can be left blank by supplying empty
% arrays []. plotspec.m has details on the value ordering to create
% correctly-shaped specification bounds
%
       
function createiir(poles, zeros, x_specs, y_specs, N)

    % Get omega and normalized frequency f
    w = 2*pi*[0:N-1]/N;
    f = linspace(0,0.5,N) ;

    % Plot poles and zeros in respect to unit circle       
    plotpzcomplex(poles, zeros, w)

    % Get second order sections
    [sos,g] = createsos(zeros, poles, N);
    n_sections = size(sos, 1);

    % Plot all intermediate frequency responses and final
    Hf = loopsectionhfs(sos, g, f);

    % Plot the final gain separately, for ease of matching spec
    figure;
    xlabel('Frequency [Normalized] (cycle/sample)') ;
    ylabel('Filter Gain (dB)') ;
    title('Final Frequency Response');
    grid on ;
    zoom on ;
    hold on ;

    % Plot all specs
    plotallspecs(x_specs, y_specs);
        
    % Plot final gain
    plot(f, 20*log10(abs(Hf)), 'k');

    % Print generated filter as coefficients
    printcoef_c(sos, g, n_sections);
end

