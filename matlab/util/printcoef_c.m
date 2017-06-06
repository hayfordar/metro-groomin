function printcoef_c(sos, g, n_sections)
    % Grab a and b coefficients
    b_coefs = sos(:, 1:3);
    a_coefs = sos(:, 4:6);

    % Grab gain
    gain = g;

    % Print the quantity of sections and gain 
    fprintf(1, 'static int sections = %d ;\n', n_sections);
    fprintf(1, 'static float G = %1.10e ;\n', gain);
    fprintf(1, '\n');

    % Print the a-coefficients 
    fprintf(1, 'float a[][3] = {\n');
    for i = 1 : n_sections - 1
        fprintf(1, '\t{%1.10e, %1.10e, %1.10e},\n', a_coefs(i,:));
    end
    % Print last coefficients, end with closing brace and semicolon
    fprintf(1,'\t{%1.10e, %1.10e, %1.10e}\n};\n', a_coefs(n_sections,:));

    % Print b-coefficients
    fprintf(1, 'float b[][3] = {\n');
    for i = 1 : n_sections - 1
        fprintf(1, '\t{%1.10e, %1.10e, %1.10e},\n', b_coefs(i,:));
    end
    % Print last coefficients, end with closing brace and semicolon
    fprintf(1,'\t{%1.10e, %1.10e, %1.10e}\n};\n', b_coefs(n_sections,:));
end