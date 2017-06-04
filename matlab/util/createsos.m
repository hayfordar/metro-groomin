function createsos(zeros, poles, k)
% CALC_SOS	Section-ize and calculate coefficients to implement filter
%
% 	calc_sos(zeros, poles, k) creates second-order sections to implement
%	a filter described by the input poles, zeros, and gain factor k. 
%	This function generates plots of the gains from each section, as well
%	as the total gain of the filter. The created coefficients are dumped
%	to stdout in the form of C code such that they can be easily pasted
%	into the real-time C code for testing on the STM32F4 discovery board.
%

% Author: ECE 486 Lab Group 1
% Author: Andrew Hayford
% Author: Sebastian Luy
% Author: Robert Sepanek
% calc_sos function file
% February 20th, 2015

%% Set up filter sections and initialisations for plotting %%
[sos, g] = zp2sos(zeros, poles, k, 'up', 'inf') ;

% Section-ize the filter %
q_sect = size(sos, 1) ;

% Create linearly spaced values of normalized frequency f %
f = linspace(0,0.5,1001) ;

% Substitution for z = e^{j2pif} %
z = exp(j*2*pi*f) ; 

% Obtain a and b coefficients %
b = poly(zeros)*k ;
a = poly(poles) ;


%% Plot gain of all sections with final gain %%
figure (3);
% Plot ideal (desired H(f)) %
Hf = polyval(b, z)./polyval(a, z) ;
plot(f, 20*log10(abs(Hf))) ;

% Label and format %
xlabel('Frequency [Normalized] (cycle/sample)') ;
ylabel('Filter Gain (dB)') ;
axis([0 0.5 -60 60]) ;
grid on ;
zoom on ;
hold on ;

% Create color vector to change color of each line on plot %
colors = ['y', 'm', 'c', 'r', 'g', 'b', 'k'] ;
Hf = g * ones(size(f)) ;

% Iterate through sections, plotting intermediate gains
for i = 1: size(sos, 1) ;
    Hf = Hf ./ polyval(sos(i, 4:6), z) ;
    plot(f, 20*log10(abs(Hf)), colors(i));
    Hf = Hf .* polyval(sos(i, 1:3),z) ;
end

% Plot final obtained gain %
plot(f, 20*log10(abs(Hf)), 'k');

%% Plot the final gain separately, for ease of matching spec %%
figure (4)

% Make spec bound 1 %
x = [0 0 0.04 0.04];
y = [-40 -60 -60 -40];
h1 = patch;
set(h1, 'FaceAlpha', 0.5);
set(h1, 'XData', x);
set(h1, 'YData', y);
hold on

% Make spec bound 2 %
x = [0.1 0.1 0.25 0.25];
y = [-7 -5 0 -2];
h2 = patch;
set(h2, 'FaceAlpha', 0.5);
set(h2, 'XData', x);
set(h2, 'YData', y);
hold on

% Make spec bound 3 %
x = [0.32 0.32 0.5 0.5];
y = [-60 -35 -35 -60];
h = patch;
set(h, 'FaceAlpha', 0.5);
set(h, 'XData', x);
set(h, 'YData', y);
hold on

% Plot final gain %
plot(f, 20*log10(abs(Hf)), 'k');

% Label and format %
xlabel('Frequency [Normalized] (cycle/sample)') ;
ylabel('Filter Gain (dB)') ;
axis([0 0.5 -60 60]) ;
grid on ;
zoom on ;
hold on ;

%% Print generated filter properties as easy-to-copy C code %%

% Grab a and b coefficients %
b_coefs = sos(:, 1:3) ;
a_coefs = sos(:, 4:6) ;

% Grab gain %
gain = g ;

% Print the quantity of sections and gain %
fprintf(1, 'static int sections = %d ;\n', q_sect) ;
fprintf(1, 'static float G = %1.10e ;\n', gain) ;
fprintf(1, '\n') ;

% Print the a-coefficients %
fprintf(1, 'float a[][3] = {\n');
for i = 1 : q_sect - 1
    fprintf(1, '\t{%1.10e, %1.10e, %1.10e},\n', a_coefs(i,:)) ;
end
% Print last coefficients, end with closing brace and semicolon %
fprintf(1,'\t{%1.10e, %1.10e, %1.10e}\n};\n', a_coefs(q_sect,:)) ;
    
% Print b-coefficients
fprintf(1, 'float b[][3] = {\n');
for i = 1 : q_sect - 1
    fprintf(1, '\t{%1.10e, %1.10e, %1.10e},\n', b_coefs(i,:)) ;
end
% Print last coefficients, end with closing brace and semicolon %
fprintf(1,'\t{%1.10e, %1.10e, %1.10e}\n};\n', b_coefs(q_sect,:)) ;





