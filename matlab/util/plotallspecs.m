%% Plots all specs provided
%
% Loops through and plots all specs provided in matrixes X and Y. Errors
% out if specification matrices do not have same amount of rows
%

function plotallspecs(x_specs, y_specs)
    % Return error if spec dimensions don't match
    if size(x_specs, 1) ~= size(y_specs,1)
        error('ERROR: Supplied spec bounds do not match in size')
    end

    % Plot all specs in the matrix
    for n = 1:size(x_specs, 1)
        plotspec(x_specs(n,:), y_specs(n,:));
    end
end