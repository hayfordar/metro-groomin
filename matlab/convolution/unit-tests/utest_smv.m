%% Unit tests for symmetric-mean value algorithm

% below should throw an error, as we cannot have even, negative,
% non-integer, or complex values for window size

%y1 = symmetrical_mean_value([1 2], 2)
%y2 = symmetrical_mean_value([1 3], -3)
%y3 = symmetrical_mean_value([1 2 3 4], 1.5)

% standard case, window size fits within bounds of block
y1 = symmetrical_mean_value([0 2 4 8 6 3], 5)
assert(isequal(y1, [0 2 4 23/5 17/3 3]));

% another standard use case, window half size of block
y2 = symmetrical_mean_value([0 2 4 8 6 3], 3)
assert(isequal(y2, [0 2 14/3 6 17/3 3]));

% use case, average across 1 elements centered at x(n) is x(n)
y3 = symmetrical_mean_value([0 2 4 8 6 3], 1)
assert(isequal(y3, [0 2 4 8 6 3]));

% test case with window size larger than blocksize
y4 = symmetrical_mean_value([0 2 4 8 6 3], 9)
assert(isequal(y4, [0 2 4 23/5 17/3 3])); 

% test odd array size
y5 = symmetrical_mean_value([0 1 2 3 4 5 6 7 8], 3)
assert(isequal(y5, [0 1 2 3 4 5 6 7 8]));
