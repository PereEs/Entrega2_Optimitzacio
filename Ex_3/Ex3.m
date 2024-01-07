%This code sets up the objective function, nonlinear constraint, cost functions, production functions, 
% and unit price functions based on the given problem. 
% It uses fmincon to maximize the total net benefit subject to the constraint on total water allocation. 
% Adjust the constraints or initial guesses as necessary to match the problem's specifics

% Max number of products where x1,x2,x3 is the wather flow for each company
P1 = @(x1) 0.4 * (x1).^0.9;
P2 = @(x2) 0.5 * (x2).^0.8;
P3 = @(x3) 0.6 * (x3).^0.7;

% Production cost
C1 = @(x1) 3 * P1(x1).^1.3;
C2 = @(x2) 5 * P2(x2).^1.2;
C3 = @(x3) 6 * P3(x3).^1.15;

% Selling price per unit
S1 = @(p1) 12 - p1;
S2 = @(p2) 20 - 1.5 * p2;
S3 = @(p3) 28 - 2.5 * p3;

%Benefits = #units produced (pj)*selling price (Sj)-production cost(Cj)

B1 = @(p1,x1) p1*S1(p1)-C1(x1);
B2 = @(p2,x2) p2*S2(p2)-C2(x2);
B3 = @(p3,x3) p3*S3(p3)-C3(x3);

% Objective function to maximize the total net benefit (- to maximize)
objective = @(x) -(B1(x(1), x(4)) + B2(x(2), x(5)) + B3(x(3), x(6)));

% Define the nonlinear constraint function for water allocation
% x1+x2+x3<Q-R
Q = 20; % River flow
R = 10; % Amount of water to be kept in the river
A = [0 0 0 1 1 1];
b = [Q-R];
x0 = [1,1,1,1,1,1];
% Setting up the lower and upper bounds for 
lb = zeros(1, 6); % Lower bounds for x (non-negative allocations)
ub = Inf * ones(1, 6); % Upper bounds for x (unrestricted)

nonlcon = @my_const;   % Nonlinear constraints specified in "my_const" function
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
[x_optimal, fval] = fmincon(objective, x0, A,b, [], [], lb, ub, nonlcon, options);

% Calculate optimal production amounts
p1_optimal = P1(x_optimal(1));
p2_optimal = P2(x_optimal(2));
p3_optimal = P3(x_optimal(3));

% Calculate optimal selling unit prices
s1_optimal = S1(p1_optimal);
s2_optimal = S2(p2_optimal);
s3_optimal = S3(p3_optimal);

% Display results
fprintf('Optimal water allocations: x4 = %.2f, x5 = %.2f, x6 = %.2f\n', x_optimal(4), x_optimal(5), x_optimal(6));
fprintf('Optimal production amounts: x1 = %.2f, x2 = %.2f, x3 = %.2f\n', x_optimal(1), x_optimal(2), x_optimal(3));
fprintf('Optimal unit prices: s1 = %.2f, s2 = %.2f, s3 = %.2f\n', s1_optimal, s2_optimal, s3_optimal);
fprintf('Maximum total net benefit: %.2f\n', -fval);

% to better show in a table
X = (x_optimal(4:6));                                      %Water
P = [P1(x_optimal(4)), P2(x_optimal(5)), P3(x_optimal(6))]; %Maximum_Production
S = [S1(x_optimal(1)), S2(x_optimal(2)), S3(x_optimal(3))]; %Selling Unit_Price
C = [C1(x_optimal(4)), C2(x_optimal(5)), C3(x_optimal(6))]; %Cost_Production
B = [B1(x_optimal(1), x_optimal(4)), B2(x_optimal(2), x_optimal(5)), B3(x_optimal(3), x_optimal(6))];% Benefit
% Calculate totals
xt = sum(X); % Total water
pt = sum(x_optimal(1:3)); % Total goods produced
xt_alloc = sum(x_optimal(4:6)); % Total water allocated
Pt = sum(P); % Total maximum production
Ct = sum(C); % Total cost production
Bt = sum(B); % Total benefit

% Create a table
T = table(X', P', S', C', B', 'VariableNames', {'Water', 'Maximum_Production', 'Unit_Price', 'Cost_Production', 'Benefit'});
T.Properties.RowNames = {'Company1', 'Company2', 'Company3'};

% Create a table for the totals with matching variable names
T_totals = table(xt, Pt, NaN, Ct, Bt, 'VariableNames', {'Water', 'Maximum_Production', 'Unit_Price', 'Cost_Production', 'Benefit'});
T_totals.Properties.RowNames = {'Total'};

% Adjust variable names in the initial table to match the totals table
T.Properties.VariableNames = T_totals.Properties.VariableNames;

% Concatenate tables to create a single table with the totals row
result_table = [T; T_totals];
disp(result_table);
