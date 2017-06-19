%% Plots intermediate and final frequency responses
%
% Takes in a matrix of section order sections (sos) where each row is a
% complete section. 1:3 should be the numerator, 4:6 the denominator. Also
% takes in gain (g) and normalized frequency f
%
function Hf = loopsectionhfs(sos, g, f)
    % Setup of figure
    figure;
    xlabel('Frequency [Normalized] (cycle/sample)') ;
    ylabel('Filter Gain (dB)') ;
    title('Intermediate and Final Frequency Response');
    grid on ;
    zoom on ;
    hold on ;

    % Create color vector to change color of each line on plot
    colors = ['y', 'm', 'c', 'r', 'g', 'b', 'k'] ;
    Hf = g * ones(size(f)) ;

    % Substitution for z = e^{j2pif}
    z = exp(j*2*pi*f) ;
    
    % Iterate through sections, plotting intermediate Hf
    color_i = 1;
    
    % Loop through each section of coefficients
    for i = 1: size(sos, 1)
        % Circle through color buffer without indexing out of bounds
        if color_i > length(colors)
            color_i = 1;
        end
        % Put denominator coefficients in first
        Hf = Hf ./ polyval(sos(i, 4:6), z) ;
        % Plot intermediate Hf
        plot(f, 20*log10(abs(Hf)), strcat(colors(i),'--'));
        % Include coefficients from numerator
        Hf = Hf .* polyval(sos(i, 1:3),z) ;
        color_i = color_i + 1;
    end
    
    % Plot final obtained Hf
    plot(f, 20*log10(abs(Hf)), 'k.-', 'LineWidth', 3);
end