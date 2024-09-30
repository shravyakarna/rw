num_walkers = 10000;
num_steps = 1000;
dimension = 2;
mu = 0;
sigma = 1;

final_positions = zeros(num_walkers, dimension);

for i = 1:num_walkers
    steps = sigma * randn(num_steps, dimension) + mu;  
    final_positions(i, :) = sum(steps);
end

mean_final = mean(final_positions);
std_final = std(final_positions);

figure;
histogram2(final_positions(:, 1), final_positions(:, 2), 'Normalization', 'pdf');
title('Gaussian Distribution of Final Locations');
xlabel('X Position');
ylabel('Y Position');
zlabel('Probability Density');
grid on;

sample_sizes = round(linspace(100, num_walkers, 20));
empirical_means = zeros(length(sample_sizes), dimension);

for j = 1:length(sample_sizes)
    sample_size = sample_sizes(j);
    empirical_means(j, :) = mean(final_positions(1:sample_size, :));
end

theoretical_mean = mu * ones(length(sample_sizes), dimension);

figure;
plot(sample_sizes, empirical_means(:, 1), '-o', 'DisplayName', 'Empirical X Mean');
hold on;
plot(sample_sizes, empirical_means(:, 2), '-x', 'DisplayName', 'Empirical Y Mean');
plot(sample_sizes, theoretical_mean(:, 1), '--', 'DisplayName', 'Theoretical X Mean');
plot(sample_sizes, theoretical_mean(:, 2), '--', 'DisplayName', 'Theoretical Y Mean');
title('Convergence of Empirical Mean to Theoretical Mean (Law of Large Numbers)');
xlabel('Sample Size');
ylabel('Mean');
legend show;
grid on;

disp('Empirical Mean of Final Positions:');
disp(mean_final);

disp('Empirical Standard Deviation of Final Positions:');
disp(std_final);
