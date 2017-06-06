%% MATLAB implementation of second-order filter generator to meet filter specs
%
% createsos(zeros, poles, ) creates second-order sections to implement
% a filter described by the input poles and zeros
% This function generates plots of the gains from each section, as well
% as the total gain of the filter. The created coefficients are dumped
% to stdout in a format which is compliant with most C/C++ compilers
%

function createsos(zeros, poles, N)
    % Obtain a and b coefficients 
    b = poly(zeros) ;
    a = poly(poles) ;
      
    % Calculate maximum gain and adjust numerator by scale factor to reduce
    % gain to 0dB
    gmax = filternorm(b, a, inf);
    k = 1/gmax;
    b = b*k;
    
    % setup sections
    [sos, g] = zp2sos(zeros, poles, k, 'up', 'inf') ;
    q_sect = size(sos, 1) ;

    % Create linearly spaced values of normalized frequency f
    f = linspace(0,0.5,N) ;

    % Substitution for z = e^{j2pif}
    z = exp(j*2*pi*f) ; 
    
    %% Plot gain of all sections with final gain
    figure (2);

    % Plot ideal (desired H(f))
    Hf = polyval(b, z)./polyval(a, z) ;
    plot(f, 20*log10(abs(Hf))) ;

    % Label and format
    xlabel('Frequency [Normalized] (cycle/sample)') ;
    ylabel('Filter Gain (dB)') ;
    %axis([0 0.5 -60 60]) ;
    grid on ;
    zoom on ;
    hold on ;

    % Create color vector to change color of each line on plot
    colors = ['y', 'm', 'c', 'r', 'g', 'b', 'k'] ;
    Hf = g * ones(size(f)) ;

    % Iterate through sections, plotting intermediate gains
    color_i = 1;
    for i = 1: size(sos, 1)
        if color_i > length(colors)
            color_i = 1;
        end
        Hf = Hf ./ polyval(sos(i, 4:6), z) ;
        plot(f, 20*log10(abs(Hf)), colors(i));
        Hf = Hf .* polyval(sos(i, 1:3),z) ;
        color_i = color_i + 1;
    end

    % Plot final obtained gain
    plot(f, 20*log10(abs(Hf)), 'k');

    %% Plot the final gain separately, for ease of matching spec
    figure (3)

    % Make spec bound 1
    x1 = [0 0 0.04 0.04];
    y1 = [-40 -60 -60 -40];
    plotspec(x1,y1);

    % Make spec bound 2
    x2 = [0.1 0.1 0.25 0.25];
    y2 = [-5 -7 -2 0];
    plotspec(x2,y2);

    % Make spec bound 3
    x3 = [0.32 0.32 0.5 0.5];
    y3 = [-35 -60 -60 -35];
    plotspec(x3,y3);

    % Plot final gain
    plot(f, 20*log10(abs(Hf)), 'k');

    % Label and format
    xlabel('Frequency [Normalized] (cycle/sample)') ;
    ylabel('Filter Gain (dB)') ;
    %axis([0 0.5 -60 60]) ;
    grid on ;
    zoom on ;
    hold on ;

    %% Print generated filter as coefficients
    printcoef_c(sos, g, q_sect);

end



