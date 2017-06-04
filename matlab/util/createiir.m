%% MATLAB utility to create an IIR filter from a cascaded structure of 2nd order filters
% This MATLAB script plots poles and zeroes against the unit circle, then
% creates a series of second order filters that meets the specifications


%% System properties and initialisations

% Quantity of steps, setup omega 
N = 1001;
w = 2*pi*[0:N-1]/N;

% System poles
pole_iir = [0.91*exp(j*2*pi*0.10*[-1 1]) ...
            0.50*exp(j*2*pi*0.125*[1 -1]) ...
            0.69*exp(j*2*pi*0.15*[-1 1]) ...
            0.68*exp(j*2*pi*0.20*[-1 1]) ...
            0.72*exp(j*2*pi*0.23*[-1 1]) ...
            0.94*exp(j*2*pi*0.26*[-1 1]) ...
            ];

% System zeros
zero_iir = [1.00*exp(j*2*pi*0.00*[-1 1]) ...
            0.36*exp(j*2*pi*0.02*[-1 1]) ...
            0.90*exp(j*2*pi*0.35*[-1 1]) ...
            ];
        
%% Plot poles and zeros in respect to unit circle       
figure (1);            % Create figure 1     
clf;
plot(exp(j*w));        % Plot the unit circle
hold on                 % Stay on figure 1

% Plot real and imaginary of poles, zeros
plot(real(pole_iir), imag(pole_iir), 'x');
plot(real(zero_iir), imag(zero_iir), 'o');

% Square axis, force manual square
axis square;
axis([-2 2 -2 2]);
grid;

% Labeling
xlabel('Re(z)');
ylabel('Im(z)');
title('Poles and Zeros in Respect to Unit Circle');

%% Gather and plot frequency response

% Get and b coefficients
a = poly(pole_iir) ;
b = poly(zero_iir) ;

% Evaluate numerator and denominator for z = e^(j2pif)
f = linspace(-0.5, 0.5, 1001);
z = exp(j*2*pi*f);
num = polyval(b, z);
den = polyval(a, z); 

% Get frequency response
hf = 20*log10(abs(num./den));

%% Create filter sections

% Calculate maximum gain
gmax = filternorm(b, a, inf);

% Adjust filter by scale factor g to reduce gain to 0dB
k = 1/gmax;

% Run filter sections %
createsos(zero_iir, pole_iir, k);
