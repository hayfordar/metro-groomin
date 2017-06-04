%% unit tests for running_mean_value(x, M)

% test small window on array of size > 2M
y1 = running_mean_value([1 2 3 4 5 6 7 8], 3)
assert(isequal(y1,[1 1.5 2 3 4 5 6 7]));

% test on array of size slightly above window size M
y2 = running_mean_value([6 3 2 9 10], 4)
assert(isequal(y2, [6 4.5 11/3 5 6]));

% test window size is greater than size of sample block
y3 = running_mean_value([1 2 3], 5)
assert(isequal(y3, [1 1.5 2]));

% test window size is 1
y4 = running_mean_value([4 5 7 88], 1)
assert(isequal(y4, [4 5 7 88]));

% return input array if window size is 0
y5 = running_mean_value([1 2 4], 0)
assert(isequal(y5, [1 2 4]));

% return blank if input block is empty
y6 = running_mean_value([], 10)
assert(isequal(y6, []));

% test with some zeroes scattered about the sample
y7 = running_mean_value([0 0 1 4 6 2 0 1 9], 3)
assert(isequal(y7, [0 0 1/3 5/3 11/3 4 8/3 1 10/3]));

