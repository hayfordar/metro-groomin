%% Plots poles and zeros of a causal system on the unit circle
%
% This function assumes the system is causal, and thus will return an error
% if the number of zeros is greater than or equal to the number of poles
%

function plotpzcomplex(poles, zeros, w)
    % Return error if system will not be causal
    if length(zeros) >= length(poles)
        error('ERROR: System must have more poles than zeros to be causal')
    end

    % Setup figure
    figure; 
    clf;
    hold on;
    axis square;
    axis([-2 2 -2 2]);
    grid;
    xlabel('Re(z)');
    ylabel('Im(z)');
    title('System Poles (x) and Zeros (o)');
    
    % Plot unit circle
    plot(exp(j*w));
    
    % Plot system poles and zeros on unit circle
    plot(real(poles), imag(poles), 'x');
    plot(real(zeros), imag(zeros), 'o');
end
    
    
    


