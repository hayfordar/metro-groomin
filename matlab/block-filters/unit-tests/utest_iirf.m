%% Unit testing for IIR filter using blocks, no access to historic blocks

% Simple test case, coefficents all set to 1, simple x = n input signal
yn1 = filteriir([1 2 3 4 5], [1 1 1], [1 1 1]);
assert(isequal(yn1, [1 2 2 0 -3]));

% All pass filter, output signal should be input signal
yn2 = filteriir([1 2 3 4 5], [1 0 0], [1 0 0]);
assert(isequal(yn2, [1 2 3 4 5]));

% No pass filter, output signal should be 0
yn3 = filteriir([1 2 3 4 5], [0 0 0], [1 0 0]);
assert(isequal(yn3, [0 0 0 0 0]));