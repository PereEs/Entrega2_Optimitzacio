%OBJECTIVE: MAXIMIZE THE TOTAL BENEFIT OBTAINED FROM ALL THREE COMPANIES
Q = 20;
R = 10;
c = Q-R;
x0 = ones(1,10);
fun = @(x) handle_fun(x, c);
options = optimoptions('fsolve','Display','iter');
x = fsolve(fun,x0, options);

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

% Objective function to maximize the total net benefit = TNB (- to maximize)
TNB = @(x) -(B1(x(1), x(4)) + B2(x(2), x(5)) + B3(x(3), x(6)));

LAMB = x(1:4);
X = x(end-2:end);
P = [P1(x(8)) P2(x(9)) P3(x(10))];
S = [S1(x(5)) S2(x(6)) S3(x(7))];
C = [C1(x(8)) C2(x(9)) C3(x(10))];
B = [B1(x(5), x(8)) B2(x(6), x(9)) B3(x(7), x(10))];
pt = sum(x(5:7));    % Total goods produced
xt = sum(x(8:10));    % Total water allocated
Pt = sum(P);          % Total maximum production
Ct = sum(C);          % Total cost production
Bt = sum(B);          % Total benefit

%Print Lambdas
first_four = x(1:4);
fprintf ('For Q = %d and  R = % d \n', Q,R);
fprintf('The Lambda values are: %.4f, %.4f, %.4f, %.4f\n',LAMB);

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

