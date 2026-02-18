%% P-MEDIAN FIREHOUSE OPTIMIZATION - WITH GEOGRAPHIC COORDINATES
clear; clc; close all;

%% ============================================================
%% STEP 1: FIRE STATION DATA (with coordinates)
%% ============================================================

% Fire station names
station_names = {
   'Station 1';
'Station 2';
'Station 3';
'Station 4';
'Station 5';
'Station 6';
'Station 7';
'Station 8';
'Station 9';
'Station 10';
'Station 11';
'Station 12';
'Station 13';
'Station 14';
'Station 15';
'Station 16';
'Station 17';
'Station 18';
'Station 19';
'Station 20';
'Station 21';
'Station 22';
'Station 23';
'Station 24';
'Station 25';
'Station 26';
'Station 27';
'Station 28';
'Station 29';
'Station 30';
'Station 31';
'Station 32';
'Station 33';
'Station 34';
'Station 35';
'Station 36';
'Station 37';
'Station 38';
'Station 39';
'Station 40';
'Station 41';
'Station 42';
'Station 43';
'Station 44';
'Station 48';
'Station 49';
'Station 51';

};

% Fire station coordinates [Latitude, Longitude]
% Replace with your actual station coordinates
station_coords = [
37.7794167, -122.4041 %1
37.7970177, -122.409903 %2
37.7866453, -122.41932 %3
37.7728017, -122.3891338 %4
37.7804403, -122.4307565 %5
37.7671333, -122.4308728 %6
37.7601493, -122.4151498 %7
37.7772643, -122.396732 %8
37.74588013, -122.4019089 %9
37.7856096, -122.4468208 %10
37.7487702 -122.4264568 %11
37.7634971, -122.4526425 %12
37.7955302, -122.4013816 %13
37.7790025, -122.4860393 %14
37.7234522, -122.4528989 %15
37.798667, -122.4367344 %16
37.7275127, -122.3850437 %17
37.7509913, -122.4905561 %18
37.7278448, -122.4789131 %19
37.7511787, -122.4562311%20
37.7754221,-122.4403113%21
37.7639839,-122.4736896%22
37.7614186,-122.5046368%23
37.753129,-122.4411063%24
37.746866,-122.3870744%25
37.7402754,-122.4332915%26
37.8025574,-122.4093845 %28
37.7661604,-122.4043895 %29
37.7798512,-122.4712068 %31
37.736298,-122.4211977 %32
37.710862,-122.4586023 %33
37.7794435,-122.5026391 %34
37.8092576,-122.4163837 %35
37.7749817, -122.4212385 %36
37.7574059, -122.3992349 %37
37.7896875, -122.4298575 %38
37.7400219, -122.4586757, %39
37.7476219, -122.4752903 %40
37.7933823, -122.4165096 %41
37.7315829, -122.405558 %42
37.7162557,-122.4315289 %43
37.7166527, -122.4004296 %44
37.7446106, -122.4018933 %49
37.8015569, -122.4554679 %51
];

%% ============================================================
%% STEP 2: DEMAND POINT DATA (with coordinates)
%% ============================================================

% Area/demand point names
demand_names = {
    'Area 1';
    'Area 2';
    'Area 3';
    'Area 4';
    'Area 5';
    'Area 6';
    'Area 7';
    'Area 8';
    'Area 9';
    'Area 10';
};

% Demand point coordinates [Latitude, Longitude]
% Replace with your actual area coordinates
demand_coords = [
    34.0500, -118.2400;   % Area 1
    34.0600, -118.2500;   % Area 2
    34.0450, -118.2350;   % Area 3
    34.0700, -118.2600;   % Area 4
    34.0480, -118.2380;   % Area 5
    34.0580, -118.2480;   % Area 6
    34.0620, -118.2420;   % Area 7
    34.0750, -118.2650;   % Area 8
    34.0780, -118.2680;   % Area 9
    34.0520, -118.2320;   % Area 10
];

%% ============================================================
%% STEP 3: DISTANCE MATRIX (km or miles)
%% ============================================================

% Distance from each DEMAND POINT (row) to each STATION (column)
distance_matrix = [
    % Stn1  Stn2  Stn3  Stn4
      2.1,  3.8,  2.9,  2.5;   % Area 1
      4.2,  1.6,  5.1,  3.7;   % Area 2
      2.8,  5.9,  1.9,  4.3;   % Area 3
      5.6,  2.4,  6.8,  4.9;   % Area 4
      2.5,  5.2,  2.0,  3.6;   % Area 5
      3.7,  2.8,  4.7,  3.4;   % Area 6
      4.5,  4.0,  5.2,  4.1;   % Area 7
      6.2,  5.1,  6.8,  5.8;   % Area 8
      6.8,  4.9,  7.6,  6.1;   % Area 9
      3.2,  4.9,  3.5,  3.9;   % Area 10
];

%% ============================================================
%% STEP 4: TRAVEL TIME MATRIX (minutes)
%% ============================================================

% Travel time from each DEMAND POINT (row) to each STATION (column)
travel_time_matrix = [
    % Stn1  Stn2  Stn3  Stn4
      3.5,  5.2,  4.8,  3.9;   % Area 1
      6.1,  2.3,  7.5,  5.4;   % Area 2
      4.2,  8.1,  2.9,  6.3;   % Area 3
      7.8,  3.6,  9.2,  6.7;   % Area 4
      3.9,  7.4,  3.1,  5.2;   % Area 5
      5.5,  4.1,  6.8,  4.9;   % Area 6
      6.3,  5.7,  7.2,  5.8;   % Area 7
      8.5,  7.2,  9.1,  7.9;   % Area 8
      9.2,  6.8,  10.5, 8.3;   % Area 9
      4.7,  6.9,  5.1,  5.6;   % Area 10
];

%% ============================================================
%% STEP 5: OPTIMIZATION SETTINGS
%% ============================================================

% What to optimize?
% 'time'     - Minimize total response time (RECOMMENDED for fire services)
% 'distance' - Minimize total distance
% 'both'     - Weighted combination of both

optimization_criterion = 'time';

% If using 'both', set weights (must sum to 1.0)
time_weight = 0.7;
distance_weight = 0.3;

% Since no population data, treat all areas equally
% (each area gets weight of 1.0)
demand_weights = ones(length(demand_names), 1);

%% ============================================================
%% DATA VALIDATION
%% ============================================================

n_stations = length(station_names);
n_areas = length(demand_names);

if size(distance_matrix, 1) ~= n_areas || size(distance_matrix, 2) ~= n_stations
    error('Distance matrix must be %d rows x %d columns (areas x stations)', n_areas, n_stations);
end

if size(travel_time_matrix, 1) ~= n_areas || size(travel_time_matrix, 2) ~= n_stations
    error('Travel time matrix must be %d rows x %d columns (areas x stations)', n_areas, n_stations);
end

if size(station_coords, 1) ~= n_stations || size(station_coords, 2) ~= 2
    error('Station coordinates must be %d rows x 2 columns (lat, lon)', n_stations);
end

if size(demand_coords, 1) ~= n_areas || size(demand_coords, 2) ~= 2
    error('Demand coordinates must be %d rows x 2 columns (lat, lon)', n_areas);
end

fprintf('╔════════════════════════════════════════════════╗\n');
fprintf('║     P-MEDIAN FIREHOUSE OPTIMIZATION           ║\n');
fprintf('║        WITH GEOGRAPHIC VISUALIZATION          ║\n');
fprintf('╚════════════════════════════════════════════════╝\n\n');
fprintf('Data loaded successfully:\n');
fprintf('  Stations: %d (with coordinates)\n', n_stations);
fprintf('  Demand areas: %d (with coordinates)\n', n_areas);
fprintf('  All areas weighted equally (no population data)\n\n');

%% ============================================================
%% STEP 6: SELECT COST MATRIX
%% ============================================================

switch optimization_criterion
    case 'time'
        cost_matrix = travel_time_matrix;
        cost_units = 'minutes';
        fprintf('Optimization: Minimize total response TIME\n\n');
        
    case 'distance'
        cost_matrix = distance_matrix;
        cost_units = 'distance units';
        fprintf('Optimization: Minimize total DISTANCE\n\n');
        
    case 'both'
        % Normalize both to 0-1 scale for fair comparison
        norm_time = travel_time_matrix / max(travel_time_matrix(:));
        norm_dist = distance_matrix / max(distance_matrix(:));
        cost_matrix = time_weight * norm_time + distance_weight * norm_dist;
        cost_units = 'weighted score';
        fprintf('Optimization: %.0f%% time + %.0f%% distance\n\n', ...
            time_weight*100, distance_weight*100);
end

%% ============================================================
%% STEP 7: ANALYZE CURRENT CONFIGURATION
%% ============================================================

fprintf('════════════════════════════════════════════════\n');
fprintf('CURRENT CONFIGURATION BASELINE\n');
fprintf('════════════════════════════════════════════════\n\n');

% Current - assign each area to nearest station
[current_min_time, current_assignment] = min(travel_time_matrix, [], 2);
[current_min_dist, ~] = min(distance_matrix, [], 2);

fprintf('Current Performance (all %d stations operating):\n\n', n_stations);

fprintf('Response Time:\n');
fprintf('  Average:  %.2f minutes\n', mean(current_min_time));
fprintf('  Maximum:  %.2f minutes\n', max(current_min_time));
fprintf('  Minimum:  %.2f minutes\n', min(current_min_time));
fprintf('  Std Dev:  %.2f minutes\n\n', std(current_min_time));

fprintf('Distance:\n');
fprintf('  Average:  %.2f units\n', mean(current_min_dist));
fprintf('  Maximum:  %.2f units\n', max(current_min_dist));
fprintf('  Minimum:  %.2f units\n', min(current_min_dist));
fprintf('  Std Dev:  %.2f units\n\n', std(current_min_dist));

% Calculate current objective
current_costs = cost_matrix(sub2ind(size(cost_matrix), 1:n_areas, current_assignment'));
current_objective = sum(current_costs);

fprintf('Current Objective Value: %.2f %s\n\n', current_objective, cost_units);

%% ============================================================
%% STEP 8: P-MEDIAN OPTIMIZATION FOR DIFFERENT p VALUES
%% ============================================================

fprintf('════════════════════════════════════════════════\n');
fprintf('P-MEDIAN OPTIMIZATION ANALYSIS\n');
fprintf('════════════════════════════════════════════════\n\n');

% Test different numbers of stations
max_p = min(n_stations, 8);  % Don't test more than 8
p_values = 1:max_p;

results = struct();

fprintf('Testing p = 1 to %d stations...\n\n', max_p);

for p_idx = 1:length(p_values)
    p = p_values(p_idx);
    
    fprintf('Solving for p = %d... ', p);
    
    % Solve P-median
    [selected, assignments, obj] = solveP_Median(cost_matrix, p, demand_weights);
    
    % Calculate performance metrics
    assigned_times = zeros(n_areas, 1);
    assigned_dists = zeros(n_areas, 1);
    
    for i = 1:n_areas
        assigned_times(i) = travel_time_matrix(i, assignments(i));
        assigned_dists(i) = distance_matrix(i, assignments(i));
    end
    
    % Store results
    results(p_idx).p = p;
    results(p_idx).selected_sites = selected;
    results(p_idx).assignments = assignments;
    results(p_idx).objective = obj;
    
    % Time metrics
    results(p_idx).avg_time = mean(assigned_times);
    results(p_idx).max_time = max(assigned_times);
    results(p_idx).min_time = min(assigned_times);
    results(p_idx).std_time = std(assigned_times);
    
    % Distance metrics
    results(p_idx).avg_dist = mean(assigned_dists);
    results(p_idx).max_dist = max(assigned_dists);
    
    % Coverage metrics
    results(p_idx).areas_under_5min = sum(assigned_times <= 5);
    results(p_idx).areas_under_8min = sum(assigned_times <= 8);
    results(p_idx).areas_under_10min = sum(assigned_times <= 10);
    results(p_idx).areas_over_15min = sum(assigned_times > 15);
    
    fprintf('Done. Obj: %.2f | Avg: %.2f min | Max: %.2f min\n', ...
        obj, results(p_idx).avg_time, results(p_idx).max_time);
end

%% ============================================================
%% STEP 9: RESULTS SUMMARY TABLE
%% ============================================================

fprintf('\n════════════════════════════════════════════════\n');
fprintf('OPTIMIZATION RESULTS SUMMARY\n');
fprintf('════════════════════════════════════════════════\n\n');

fprintf('┌────┬────────────┬──────────┬──────────┬──────────┬──────────┬──────────┐\n');
fprintf('│ p  │ Objective  │ Avg Time │ Max Time │ Avg Dist │  <8 min  │ >15 min  │\n');
fprintf('├────┼────────────┼──────────┼──────────┼──────────┼──────────┼──────────┤\n');

for r = results
    fprintf('│ %2d │ %10.2f │ %8.2f │ %8.2f │ %8.2f │ %2d/%2d    │ %2d/%2d    │\n', ...
        r.p, r.objective, r.avg_time, r.max_time, r.avg_dist, ...
        r.areas_under_8min, n_areas, r.areas_over_15min, n_areas);
end

fprintf('└────┴────────────┴──────────┴──────────┴──────────┴──────────┴──────────┘\n\n');

%% ============================================================
%% STEP 10: ANALYZE OPTIMAL CONFIGURATION (CURRENT p)
%% ============================================================

fprintf('════════════════════════════════════════════════\n');
fprintf('OPTIMAL vs CURRENT (p = %d stations)\n', n_stations);
fprintf('════════════════════════════════════════════════\n\n');

% Get results for current number of stations
current_p_idx = find([results.p] == n_stations);

if ~isempty(current_p_idx)
    opt = results(current_p_idx);
    
    fprintf('OPTIMAL STATION SELECTION:\n');
    for s = opt.selected_sites'
        fprintf('  ✓ Keep: %s (%.4f, %.4f)\n', station_names{s}, ...
                station_coords(s,1), station_coords(s,2));
    end
    
    % Stations to close
    all_stations = 1:n_stations;
    to_close = setdiff(all_stations, opt.selected_sites);
    
    if ~isempty(to_close)
        fprintf('\nSTATIONS TO CLOSE:\n');
        for s = to_close'
            fprintf('  ✗ Close: %s (%.4f, %.4f)\n', station_names{s}, ...
                    station_coords(s,1), station_coords(s,2));
        end
    else
        fprintf('\n✓ All stations should remain open (all are optimal)\n');
    end
    
    fprintf('\n');
    fprintf('PERFORMANCE COMPARISON:\n');
    fprintf('┌─────────────────────┬───────────┬───────────┬─────────────┐\n');
    fprintf('│ Metric              │  Current  │  Optimal  │ Improvement │\n');
    fprintf('├─────────────────────┼───────────┼───────────┼─────────────┤\n');
    
    % Average time
    improv_avg = (1 - opt.avg_time / mean(current_min_time)) * 100;
    fprintf('│ Avg Time (min)      │ %9.2f │ %9.2f │ %10.1f%% │\n', ...
        mean(current_min_time), opt.avg_time, improv_avg);
    
    % Max time
    improv_max = (1 - opt.max_time / max(current_min_time)) * 100;
    fprintf('│ Max Time (min)      │ %9.2f │ %9.2f │ %10.1f%% │\n', ...
        max(current_min_time), opt.max_time, improv_max);
    
    % Objective
    improv_obj = (1 - opt.objective / current_objective) * 100;
    fprintf('│ Objective Value     │ %9.2f │ %9.2f │ %10.1f%% │\n', ...
        current_objective, opt.objective, improv_obj);
    
    % Coverage <8 min
    current_under_8 = sum(current_min_time <= 8);
    fprintf('│ Areas <8 min        │ %9d │ %9d │ %+10d │\n', ...
        current_under_8, opt.areas_under_8min, opt.areas_under_8min - current_under_8);
    
    % Areas >15 min
    current_over_15 = sum(current_min_time > 15);
    fprintf('│ Areas >15 min       │ %9d │ %9d │ %10d │\n', ...
        current_over_15, opt.areas_over_15min, opt.areas_over_15min - current_over_15);
    
    fprintf('└─────────────────────┴───────────┴───────────┴─────────────┘\n\n');
    
    if improv_obj > 5
        fprintf('⚠️  RECOMMENDATION: Significant improvement (%.1f%%) possible by optimizing station selection.\n\n', improv_obj);
    elseif improv_obj > 0
        fprintf('ℹ️  Modest improvement (%.1f%%) possible by optimizing station selection.\n\n', improv_obj);
    else
        fprintf('✓ Current configuration is already optimal!\n\n');
    end
end

%% ============================================================
%% STEP 11: DETAILED ASSIGNMENTS
%% ============================================================

if ~isempty(current_p_idx)
    fprintf('════════════════════════════════════════════════\n');
    fprintf('DETAILED AREA ASSIGNMENTS (OPTIMAL)\n');
    fprintf('════════════════════════════════════════════════\n\n');
    
    opt_assignments = results(current_p_idx).assignments;
    
    for s = results(current_p_idx).selected_sites'
        areas_served = find(opt_assignments == s);
        
        fprintf('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
        fprintf('%s (%.4f, %.4f)\n', station_names{s}, ...
                station_coords(s,1), station_coords(s,2));
        fprintf('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
        fprintf('Serves %d areas\n\n', length(areas_served));
        
        fprintf('┌──────────────────────┬──────────┬──────────┐\n');
        fprintf('│ Area                 │   Time   │ Distance │\n');
        fprintf('├──────────────────────┼──────────┼──────────┤\n');
        
        for a = areas_served'
            fprintf('│ %-20s │ %6.1f m │ %6.2f u │\n', ...
                demand_names{a}, travel_time_matrix(a,s), distance_matrix(a,s));
        end
        
        fprintf('└──────────────────────┴──────────┴──────────┘\n');
        
        % Station statistics
        times = travel_time_matrix(areas_served, s);
        dists = distance_matrix(areas_served, s);
        
        fprintf('Station Performance:\n');
        fprintf('  Avg time: %.2f min | Max time: %.2f min\n', mean(times), max(times));
        fprintf('  Avg dist: %.2f u   | Max dist: %.2f u\n\n', mean(dists), max(dists));
    end
end

%% ============================================================
%% STEP 12: IDENTIFY PROBLEM AREAS
%% ============================================================

if ~isempty(current_p_idx)
    fprintf('════════════════════════════════════════════════\n');
    fprintf('PROBLEM AREA ANALYSIS\n');
    fprintf('════════════════════════════════════════════════\n\n');
    
    opt_times = zeros(n_areas, 1);
    for i = 1:n_areas
        opt_times(i) = travel_time_matrix(i, opt_assignments(i));
    end
    
    % Find areas with poor coverage
    poor_areas = find(opt_times > 10);
    critical_areas = find(opt_times > 15);
    
    if ~isempty(poor_areas)
        fprintf('Areas with >10 minute response (even with optimal configuration):\n\n');
        fprintf('┌──────────────────────┬──────────┬──────────┬─────────────────┐\n');
        fprintf('│ Area                 │   Time   │ Distance │ Nearest Station │\n');
        fprintf('├──────────────────────┼──────────┼──────────┼─────────────────┤\n');
        
        for p = poor_areas'
            marker = '';
            if opt_times(p) > 15
                marker = '🚨';
            end
            fprintf('│ %s %-17s │ %6.1f m │ %6.2f u │ %-15s │\n', ...
                marker, demand_names{p}, opt_times(p), ...
                distance_matrix(p, opt_assignments(p)), ...
                station_names{opt_assignments(p)});
        end
        
        fprintf('└──────────────────────┴──────────┴──────────┴─────────────────┘\n\n');
        
        if ~isempty(critical_areas)
            fprintf('⚠️  %d critical area(s) with >15 min response\n', length(critical_areas));
            fprintf('   Consider adding a new station near these areas.\n\n');
        end
    else
        fprintf('✓ All areas have <10 minute response with optimal configuration!\n\n');
    end
end

%% ============================================================
%% STEP 13: RECOMMENDATIONS
%% ============================================================

fprintf('════════════════════════════════════════════════\n');
fprintf('RECOMMENDATIONS\n');
fprintf('════════════════════════════════════════════════\n\n');

% Find minimum p needed for good coverage
target_coverage = 0.80;  % 80% of areas under 8 minutes
recommended_p = 0;

for r = results
    coverage_ratio = r.areas_under_8min / n_areas;
    if coverage_ratio >= target_coverage && recommended_p == 0
        recommended_p = r.p;
    end
end

fprintf('1. NUMBER OF STATIONS:\n');
if recommended_p > 0 && recommended_p < n_stations
    fprintf('   You can achieve %.0f%% coverage (<8 min) with only %d stations.\n', ...
        target_coverage*100, recommended_p);
    fprintf('   Consider closing %d station(s) to save costs.\n\n', n_stations - recommended_p);
elseif recommended_p > n_stations
    fprintf('   To achieve %.0f%% coverage (<8 min), you need %d stations.\n', ...
        target_coverage*100, recommended_p);
    fprintf('   Consider adding %d new station(s).\n\n', recommended_p - n_stations);
else
    fprintf('   Current number of stations (%d) is appropriate.\n\n', n_stations);
end

if ~isempty(current_p_idx) && improv_obj > 2
    fprintf('2. STATION SELECTION:\n');
    fprintf('   Reconfigure to use optimal stations shown above.\n');
    fprintf('   Expected improvement: %.1f%%\n\n', improv_obj);
end

if exist('critical_areas', 'var') && ~isempty(critical_areas)
    [worst_time, worst_idx] = max(opt_times);
    fprintf('3. WORST-SERVED AREA:\n');
    fprintf('   %s (%.4f, %.4f) has %.1f min response time.\n', ...
            demand_names{worst_idx}, demand_coords(worst_idx,1), ...
            demand_coords(worst_idx,2), worst_time);
    fprintf('   This area needs special attention.\n\n');
end

%% ============================================================
%% STEP 14: VISUALIZATIONS
%% ============================================================

% Figure 1: Main dashboard
figure('Position', [50, 50, 1600, 900], 'Name', 'P-Median Analysis');

% Plot 1: Average time vs p
subplot(2,3,1);
plot([results.p], [results.avg_time], '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.2 0.4 0.8]);
xlabel('Number of Stations (p)');
ylabel('Average Response Time (min)');
title('Average Response Time vs p');
grid on;
yline(8, 'r--', '8 min target', 'LineWidth', 1.5);
xlim([0.5, max_p+0.5]);

% Plot 2: Max time vs p
subplot(2,3,2);
plot([results.p], [results.max_time], '-s', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.8 0.2 0.2]);
xlabel('Number of Stations (p)');
ylabel('Maximum Response Time (min)');
title('Maximum Response Time vs p');
grid on;
yline(15, 'r--', '15 min critical', 'LineWidth', 1.5);
xlim([0.5, max_p+0.5]);

% Plot 3: Objective value vs p
subplot(2,3,3);
plot([results.p], [results.objective], '-d', 'LineWidth', 2, 'MarkerSize', 8, 'Color', [0.2 0.7 0.3]);
xlabel('Number of Stations (p)');
ylabel(sprintf('Objective Value (%s)', cost_units));
title('P-Median Objective vs p');
grid on;
xlim([0.5, max_p+0.5]);

% Plot 4: Coverage comparison
subplot(2,3,4);
under_8 = [results.areas_under_8min];
under_10 = [results.areas_under_10min];
over_15 = [results.areas_over_15min];

bar([results.p], [under_8; under_10; over_15]');
xlabel('Number of Stations (p)');
ylabel('Number of Areas');
title('Coverage by Response Time');
legend('<8 min', '<10 min', '>15 min', 'Location', 'best');
grid on;
xlim([0.5, max_p+0.5]);

% Plot 5: Heat map of travel times
subplot(2,3,5);
imagesc(travel_time_matrix');
colorbar;
xlabel('Demand Areas');
ylabel('Stations');
set(gca, 'YTick', 1:n_stations, 'YTickLabel', station_names);
title('Travel Time Matrix (minutes)');
colormap(flipud(hot));

% Plot 6: Current vs Optimal (if applicable)
subplot(2,3,6);
if ~isempty(current_p_idx)
    opt_times_vec = zeros(n_areas, 1);
    for i = 1:n_areas
        opt_times_vec(i) = travel_time_matrix(i, opt_assignments(i));
    end
    
    comparison = [current_min_time, opt_times_vec];
    bar(comparison);
    xlabel('Area Number');
    ylabel('Response Time (min)');
    title(sprintf('Current vs Optimal (p=%d)', n_stations));
    legend('Current', 'Optimal', 'Location', 'best');
    grid on;
    yline(8, 'r--', 'LineWidth', 1);
    yline(15, 'r--', 'LineWidth', 1);
end

sgtitle('P-Median Firehouse Optimization Results');

% Figure 2: Distance heat map
figure('Position', [100, 100, 1000, 600], 'Name', 'Distance Matrix');
imagesc(distance_matrix');
colorbar;
xlabel('Demand Areas');
ylabel('Stations');
set(gca, 'YTick', 1:n_stations, 'YTickLabel', station_names);
title('Distance Matrix');
colormap(flipud(hot));

% Add text labels
for i = 1:n_areas
    for j = 1:n_stations
        if distance_matrix(i,j) > mean(distance_matrix(:))
            txt_color = 'white';
        else
            txt_color = 'black';
        end
        text(i, j, sprintf('%.1f', distance_matrix(i,j)), ...
            'HorizontalAlignment', 'center', 'Color', txt_color, 'FontSize', 8);
    end
end

%% ============================================================
%% STEP 15: GEOGRAPHIC MAP VISUALIZATION
%% ============================================================

% Figure 3: Geographic Map - Current Configuration
figure('Position', [150, 150, 1400, 700], 'Name', 'Geographic Visualization');

% Subplot 1: Current Configuration
subplot(1,2,1);
hold on;

% Plot all stations (gray)
plot(station_coords(:,2), station_coords(:,1), 's', ...
    'MarkerSize', 12, 'MarkerFaceColor', [0.7 0.7 0.7], ...
    'MarkerEdgeColor', 'k', 'LineWidth', 1.5);

% Plot demand points
scatter(demand_coords(:,2), demand_coords(:,1), 100, current_min_time, ...
    'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1);

% Draw assignment lines
for i = 1:n_areas
    assigned_station = current_assignment(i);
    plot([demand_coords(i,2), station_coords(assigned_station,2)], ...
         [demand_coords(i,1), station_coords(assigned_station,1)], ...
         '--', 'Color', [0.5 0.5 0.5 0.5], 'LineWidth', 1);
end

% Labels
for i = 1:n_stations
    text(station_coords(i,2), station_coords(i,1), ...
         sprintf('  %s', station_names{i}), ...
         'FontSize', 9, 'FontWeight', 'bold');
end

for i = 1:n_areas
    text(demand_coords(i,2), demand_coords(i,1), ...
         sprintf('  %s', demand_names{i}), ...
         'FontSize', 7);
end

colorbar;
colormap(jet);
caxis([min(current_min_time), max(current_min_time)]);
xlabel('Longitude');
ylabel('Latitude');
title('Current Configuration - All Stations Open');
grid on;
hold off;

% Subplot 2: Optimal Configuration
if ~isempty(current_p_idx)
    subplot(1,2,2);
    hold on;
    
    % Plot non-selected stations (red X)
    for i = 1:n_stations
        if ~ismember(i, opt.selected_sites)
            plot(station_coords(i,2), station_coords(i,1), 'rx', ...
                'MarkerSize', 15, 'LineWidth', 3);
        end
    end
    
    % Plot selected stations (green)
    selected_coords = station_coords(opt.selected_sites, :);
    plot(selected_coords(:,2), selected_coords(:,1), 's', ...
        'MarkerSize', 15, 'MarkerFaceColor', [0.2 0.8 0.2], ...
        'MarkerEdgeColor', 'k', 'LineWidth', 2);
    
    % Calculate optimal times for coloring
    opt_times_for_color = zeros(n_areas, 1);
    for i = 1:n_areas
        opt_times_for_color(i) = travel_time_matrix(i, opt_assignments(i));
    end
    
    % Plot demand points
    scatter(demand_coords(:,2), demand_coords(:,1), 100, opt_times_for_color, ...
        'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1);
    
    % Draw optimal assignment lines
    colors = lines(length(opt.selected_sites));
    for i = 1:n_areas
        assigned_station = opt_assignments(i);
        color_idx = find(opt.selected_sites == assigned_station);
        plot([demand_coords(i,2), station_coords(assigned_station,2)], ...
             [demand_coords(i,1), station_coords(assigned_station,1)], ...
             '--', 'Color', [colors(color_idx,:) 0.6], 'LineWidth', 1.5);
    end
    
    % Labels for selected stations
    for i = opt.selected_sites'
        text(station_coords(i,2), station_coords(i,1), ...
             sprintf('  %s ✓', station_names{i}), ...
             'FontSize', 9, 'FontWeight', 'bold', 'Color', [0 0.6 0]);
    end
    
    % Labels for closed stations
    for i = 1:n_stations
        if ~ismember(i, opt.selected_sites)
            text(station_coords(i,2), station_coords(i,1), ...
                 sprintf('  %s ✗', station_names{i}), ...
                 'FontSize', 9, 'Color', [0.8 0 0]);
        end
    end
    
    % Labels for demand areas
    for i = 1:n_areas
        text(demand_coords(i,2), demand_coords(i,1), ...
             sprintf('  %s', demand_names{i}), ...
             'FontSize', 7);
    end
    
    colorbar;
    colormap(jet);
    caxis([min(opt_times_for_color), max(opt_times_for_color)]);
    xlabel('Longitude');
    ylabel('Latitude');
    title(sprintf('Optimal Configuration (p=%d)', n_stations));
    grid on;
    hold off;
end

sgtitle('Geographic Distribution of Stations and Demand Areas');

% Figure 4: Optimal Configuration Map for Different p Values
figure('Position', [200, 200, 1600, 1000], 'Name', 'Optimal Configurations for Different p');

% Create subplots for p = 1, 2, 3, 4 (or fewer if n_stations < 4)
plot_configs = min(4, max_p);
for p_plot = 1:plot_configs
    subplot(2, 2, p_plot);
    hold on;
    
    p_val = p_plot;
    result = results(p_val);
    
    % Plot non-selected stations (gray X)
    for i = 1:n_stations
        if ~ismember(i, result.selected_sites)
            plot(station_coords(i,2), station_coords(i,1), 'x', ...
                'MarkerSize', 10, 'LineWidth', 2, 'Color', [0.7 0.7 0.7]);
        end
    end
    
    % Plot selected stations
    selected_coords = station_coords(result.selected_sites, :);
    plot(selected_coords(:,2), selected_coords(:,1), 's', ...
        'MarkerSize', 12, 'MarkerFaceColor', [0.2 0.8 0.2], ...
        'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
    
    % Calculate times for this configuration
    times_for_config = zeros(n_areas, 1);
    for i = 1:n_areas
        times_for_config(i) = travel_time_matrix(i, result.assignments(i));
    end
    
    % Plot demand points
    scatter(demand_coords(:,2), demand_coords(:,1), 80, times_for_config, ...
        'filled', 'MarkerEdgeColor', 'k');
    
    % Draw assignment lines
    colors = lines(length(result.selected_sites));
    for i = 1:n_areas
        assigned_station = result.assignments(i);
        color_idx = find(result.selected_sites == assigned_station);
        plot([demand_coords(i,2), station_coords(assigned_station,2)], ...
             [demand_coords(i,1), station_coords(assigned_station,1)], ...
             '--', 'Color', [colors(color_idx,:) 0.4], 'LineWidth', 1);
    end
    
    colorbar;
    colormap(jet);
    xlabel('Longitude');
    ylabel('Latitude');
    title(sprintf('p=%d | Avg: %.1f min | Max: %.1f min', ...
                  p_val, result.avg_time, result.max_time));
    grid on;
    hold off;
end

sgtitle('Optimal Station Configurations for Different p Values');

fprintf('\n✓ Analysis complete with geographic visualization!\n\n');

%% ============================================================
%% P-MEDIAN SOLVER FUNCTION
%% ============================================================

function [selected_sites, assignments, total_cost] = solveP_Median(cost_matrix, p, demand_weights)
    % P-median integer linear programming solver
    
    [n_demand, n_candidates] = size(cost_matrix);
    
    if nargin < 3
        demand_weights = ones(n_demand, 1);
    end
    
    % Variables: x(j) for sites, y(i,j) for assignments
    n_x = n_candidates;
    n_y = n_demand * n_candidates;
    n_vars = n_x + n_y;
    
    % Objective: minimize weighted costs
    f = zeros(n_vars, 1);
    for i = 1:n_demand
        for j = 1:n_candidates
            y_idx = n_x + (i-1)*n_candidates + j;
            f(y_idx) = cost_matrix(i,j) * demand_weights(i);
        end
    end
    
    % Inequality: y(i,j) <= x(j)
    A_ineq = [];
    b_ineq = [];
    
    for i = 1:n_demand
        for j = 1:n_candidates
            y_idx = n_x + (i-1)*n_candidates + j;
            constraint = zeros(1, n_vars);
            constraint(y_idx) = 1;
            constraint(j) = -1;
            A_ineq = [A_ineq; constraint];
            b_ineq = [b_ineq; 0];
        end
    end
    
    % Equality: select p sites, assign each demand once
    A_eq = [];
    b_eq = [];
    
    % Exactly p facilities
    constraint = zeros(1, n_vars);
    constraint(1:n_x) = 1;
    A_eq = [A_eq; constraint];
    b_eq = [b_eq; p];
    
    % Each demand to one facility
    for i = 1:n_demand
        constraint = zeros(1, n_vars);
        for j = 1:n_candidates
            y_idx = n_x + (i-1)*n_candidates + j;
            constraint(y_idx) = 1;
        end
        A_eq = [A_eq; constraint];
        b_eq = [b_eq; 1];
    end
    
    % Solve
    lb = zeros(n_vars, 1);
    ub = ones(n_vars, 1);
    intcon = 1:n_vars;
    
    options = optimoptions('intlinprog', 'Display', 'off');
    [solution, total_cost, exitflag] = intlinprog(f, intcon, A_ineq, b_ineq, A_eq, b_eq, lb, ub, options);
    
    if exitflag <= 0
        warning('Optimization exit flag: %d', exitflag);
    end
    
    % Extract solution
    x_solution = solution(1:n_x);
    selected_sites = find(x_solution > 0.5);
    
    assignments = zeros(n_demand, 1);
    for i = 1:n_demand
        for j = 1:n_candidates
            y_idx = n_x + (i-1)*n_candidates + j;
            if solution(y_idx) > 0.5
                assignments(i) = j;
                break;
            end
        end
    end
end