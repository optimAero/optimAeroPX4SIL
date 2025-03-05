% Define the range of alpha values (in radians)
alpha_range = linspace(-10, 10, 100) * pi / 180; % from -10 to 10 degrees

% Define elevator deflections (in radians)
elevator_levels = [-8, 0, 8] * pi / 180; % -8, 0, 8 degrees

% Initialize arrays to store results
lift = zeros(length(alpha_range), length(elevator_levels));
drag = zeros(length(alpha_range), length(elevator_levels));
moment = zeros(length(alpha_range), length(elevator_levels));

% Loop over elevator levels and alpha values
for i = 1:length(elevator_levels)
    for j = 1:length(alpha_range)
        [CF, CM] = simpleAero(alpha_range(j), 0, elevator_levels(i), elevator_levels(i), 0, 0);
        alpha = alpha_range(j);
        beta = 0;

        % rotate to body frame
        R2 = [cos(alpha), 0, -sin(alpha), 
                0 1 0; 
                sin(alpha), 0, cos(alpha)];
        Rn3 = [cos(-beta), sin(-beta), 0; 
                -sin(-beta), cos(-beta), 0; 
                0, 0, 1];
        R_wind2bod = R2 * Rn3;
        CF_wind = R_wind2bod'*CF;
        lift(j, i) = -CF_wind(3); % Lift is the negative of the third component of CF
        drag(j, i) = -CF_wind(1); % Drag is the negative of the first component of CF
        moment(j, i) = CM(2); % Pitch moment is the second component of CM
    end
end

% Plot Lift vs Alpha
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(alpha_range * 180 / pi, lift(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Alpha (degrees)');
ylabel('Lift Coefficient');
title('Lift vs Alpha');
legend;
grid on;
hold off;

% Plot Drag vs Alpha
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(alpha_range * 180 / pi, drag(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Alpha (degrees)');
ylabel('Drag Coefficient');
title('Drag vs Alpha');
legend;
grid on;
hold off;

% Plot Moment vs Alpha
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(alpha_range * 180 / pi, moment(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Alpha (degrees)');
ylabel('Pitch Moment Coefficient');
title('Moment vs Alpha');
legend;
grid on;
hold off;

%% 
% Define the range of beta values (in radians)
beta_range = linspace(-10, 10, 100) * pi / 180; % from -10 to 10 degrees

% Define elevator deflections (in radians)
elevator_levels = [-8, 0, 8] * pi / 180; % -8, 0, 8 degrees

% Initialize arrays to store results
lift = zeros(length(beta_range), length(elevator_levels));
drag = zeros(length(beta_range), length(elevator_levels));
moment = zeros(length(beta_range), length(elevator_levels));

% Loop over elevator levels and beta values
for i = 1:length(elevator_levels)
    for j = 1:length(beta_range)
        [CF, CM] = simpleAero(0, beta_range(j), elevator_levels(i), elevator_levels(i), 0, 0);
        disp(CF)
        alpha = 0;
        beta = beta_range(j);

        % rotate to body frame
        R2 = [cos(alpha), 0, -sin(alpha), 
                0 1 0; 
                sin(alpha), 0, cos(alpha)];
        Rn3 = [cos(-beta), sin(-beta), 0; 
                -sin(-beta), cos(-beta), 0; 
                0, 0, 1];
        R_wind2bod = R2 * Rn3;
        CF_wind = R_wind2bod'*CF;
        lift(j, i) = -CF_wind(3); % Lift is the negative of the third component of CF
        drag(j, i) = -CF_wind(1); % Drag is the negative of the first component of CF
        moment(j, i) = CM(2); % Pitch moment is the second component of CM
    end
end

% Plot Lift vs Beta
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(beta_range * 180 / pi, lift(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Beta (degrees)');
ylabel('Lift Coefficient');
title('Lift vs Beta');
legend;
grid on;
hold off;

% Plot Drag vs Beta
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(beta_range * 180 / pi, drag(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Beta (degrees)');
ylabel('Drag Coefficient');
title('Drag vs Beta');
legend;
grid on;
hold off;

% Plot Moment vs Beta
figure;
hold on;
for i = 1:length(elevator_levels)
    plot(beta_range * 180 / pi, moment(:, i), 'DisplayName', sprintf('Elevator = %d deg', elevator_levels(i) * 180 / pi), 'LineWidth', 2);
end
xlabel('Beta (degrees)');
ylabel('Pitch Moment Coefficient');
title('Moment vs Beta');
legend;
grid on;
hold off;
