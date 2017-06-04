%% unit test for FIR filter implementation

% very simple test where M = blocksize
y1 = filterfir([1 2 3], [1 2 3])
assert(isequal([1 4 10], y1)); 

% try with more coefficients this time
y2 = filterfir([1 2 3 4 5 6 7 8],[1 2 3])
assert(isequal([1 4 10 16 22 28 34 40], y2));

% try with more scattered dataset
y3 = filterfir([2 2 2 1 2 3 9 8 7],[1 2 3 4])
assert(isequal([2 6 12 19 18 18 25 43 62], y3));