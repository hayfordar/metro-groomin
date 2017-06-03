%% unit tests for cumulative-mean value
% not much to test here as this algorithm is straightforward

% test simple case with small input block
y1 = cumulative_mean_value([1 2 3])
assert(isequal(y1, [1 1.5 2]));

% test larger input sample block with 0s
y2 = cumulative_mean_value([0 0 2 3 0 6])
assert(isequal(y2, [0 0 2/3 5/4 1 11/6]));

% test empty sample array
y3 = cumulative_mean_value([])
assert(isequal(y3, []));

% test length == 1
y4 = cumulative_mean_value([1])
assert(isequal(y4, [1]));