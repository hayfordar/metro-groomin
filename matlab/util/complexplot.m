function complexplot(poles, zeros, w)
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
    
    
    


