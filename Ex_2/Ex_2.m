% What funtion to  use ?
% fminbnd stands for "find minimum bounded." function is particularly useful when we have a univariate (single-variable) 
% function and we want to locate the minimum within a specified interval. 
% It iteratively narrows down the search interval to find the minimum value.
% 
%aditional comemnt: We could use fmincon if we use as a constarin
% 0<= M0 <=100, but this is a definition of an interval, so fminbnd seems more
%straigth forward.
%
% Define the inflation-affected money demand elasticity
alpha = 0.2;

% Define the function for the inflationary tax
I = @(x, M0) x * M0 * exp(-alpha * x);

% Define the initial amount of money
M0 = 100; % Initial amount between 0 and 100 euros

% Define the range of inflation rates
inflation_range = [0 100];

% Define the function to maximize (negative sign for minimization)
fun_to_minimize = @(x) -I(x, M0);

% Find the optimal inflation rate within the specified range
[optimal_inflation_rate, max_I] = fminbnd(fun_to_minimize, inflation_range(1), inflation_range(2));

% Display the optimal inflation rate and the maximum inflationary tax
fprintf('Optimal inflation rate: %.2f%% \n', optimal_inflation_rate);
fprintf('Maximum inflationary tax: %.2f%% \n', -max_I);


% Define the function for the inflationary tax
I = @(x) x .* M0 .* exp(-alpha * x); % Use .* for element-wise multiplication

% Generate x values
x_values = linspace(0, 20, 81);  % Sweep inside a reasonable  inflation rate

% Calculate corresponding I values
I_values = I(x_values);

% Plot I vs x
plot(x_values, I_values);
xlabel('Inf. rate (%)');
ylabel('Inflationary tax (%)');
title('Inflationary Tax vs Inflation Rate');