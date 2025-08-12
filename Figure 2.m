clear; close all;

% New data
data = [1, 0.93, -2.40; % D1 values
        2, 0.10, 0.66]; % D10 values
x = data(:,1); % X-axis values
y = data(:,2:3); % Y-axis values

% Create bar plot
figure;
b = bar(x, y, 'grouped'); % Grouped bar plot and capture bar handles

% Set bar colors explicitly
b(1).FaceColor = [1 0 0]; % Red for year t
b(2).FaceColor = [1 1 0]; % Yellow for year t+1

% Adjust axis limits
grid on;
xlim([0.5, 2.5]);  % Adjusted x-axis range
ylim([-3, 2]);  % Adjusted y-axis to fit data

% Add labels and legend
ylabel('\DeltaEDF (%)', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'XTick', x, 'XTickLabel', {'D1', 'D10'}, 'FontSize', 12);

% Move legend to the bottom
legend({'year t', 'year t+1'}, 'Location', 'southoutside', 'Orientation', 'horizontal');

hold on;
boxWidth = 0.8; % Adjusted width to match bar grouping
boxHeight = max(max(y)) - min(min(y)) + 0.5; % Enclosing all bars with padding

for i = 1:length(x)
    y_min = min(min(y)) - 0.2; % Start slightly below the lowest bar
    rectangle('Position', [x(i) - boxWidth/2, y_min, boxWidth, boxHeight], ...
              'EdgeColor', 'k', 'LineStyle', '--', 'LineWidth', 1.5);
end
hold off;
