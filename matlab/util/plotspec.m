%% Simple plotting tool that allows for plotting of filter specification bounds
% Bounds are plotted as squares in the form:
%
% x1,y1        x4,y4
% |------------|
% |            |
% |------------|
% x2,y2        x3,y3
%

function plotspec(x, y)
    h = patch;
    set(h, 'FaceAlpha', 0.5);
    set(h, 'XData', x);
    set(h, 'YData', y);
    hold on
    