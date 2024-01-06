cvx_begin
    % Variables
    variable n_ce;
    variable n_cu;
    
    % Objective function to maximize profit
    maximize(200 * n_ce + 600 * n_cu);
    
    % Constraints
    subject to
        n_ce + n_cu <= 80;
        n_ce - n_cu <= 30;
        n_ce + 4 * n_cu <= 160;
        
        % Non-negative constraints
        n_ce >= 0;
        n_cu >= 0;
cvx_end

% Display optimal values and objective function value
fprintf('Optimal value of number of ceramics: %d\n', round(n_ce));
fprintf('Optimal value of number of copper: %d\n', round(n_cu));
fprintf('The max profit in euros is: %d\n', round(cvx_optval));
