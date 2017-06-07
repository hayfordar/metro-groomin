%% MATLAB utility to create an IIR filter from a cascaded structure of 2nd order filters
% Creates an IIR filter that satisfies the provided poles and zeros using a
% series of 2nd order sections

% Quantity of steps, setup normalized omega/f
N = 1001;
w = 2*pi*[0:N-1]/N;
f = linspace(0,0.5,N) ;

% System poles
poles = [0.91*exp(j*2*pi*0.10*[-1 1]) ...
    0.50*exp(j*2*pi*0.125*[-1 1]) ...
    0.69*exp(j*2*pi*0.15*[-1 1]) ...
    0.68*exp(j*2*pi*0.20*[-1 1]) ...
    0.72*exp(j*2*pi*0.23*[-1 1]) ...
    0.94*exp(j*2*pi*0.26*[-1 1]) ...
    ];

% System zeros
zeros = [1.00*exp(j*2*pi*0.00*[-1 1]) ...
    0.36*exp(j*2*pi*0.02*[-1 1]) ...
    0.90*exp(j*2*pi*0.35*[-1 1]) ...
    ];

% Plot poles and zeros in respect to unit circle       
plotpzcomplex(poles, zeros, w)

% Run filter sections %
[sos,g] = createsos(zeros, poles, N);
n_sections = size(sos, 1);

Hf = loopsectionhfs(sos, g, f);

%% Plot the final gain separately, for ease of matching spec
figure;

% Make spec bound 1
x1 = [0 0 0.04 0.04];
y1 = [-40 -120 -120 -40];
plotspec(x1,y1);

% Make spec bound 2
x2 = [0.1 0.1 0.25 0.25];
y2 = [-5 -7 -2 0];
plotspec(x2,y2);

% Make spec bound 3
x3 = [0.32 0.32 0.5 0.5];
y3 = [-35 -120 -120 -35];
plotspec(x3,y3);

% Plot final gain
plot(f, 20*log10(abs(Hf)), 'k');

% Label and format
xlabel('Frequency [Normalized] (cycle/sample)') ;
ylabel('Filter Gain (dB)') ;
grid on ;
zoom on ;
hold on ;

%% Print generated filter as coefficients
printcoef_c(sos, g, n_sections);

