%Ex_1
% Quetion is n_ce and n_cu optimal for max profit
%profict is 200*n_ce + 600 *n_cu
%Constrains are:
%n_ce+n_cu<=80
%n_ce<=n_cu+30 , moving variables to one side n_ce-n_cu<=30
%there is also a constrain about number of hours that can be placed as
%n_ce+4*n_cu<=160

% Objective function coefficients
f = [200; 600]; % Coefficients for n_ce and n_cu

% Inequality constraints
A = [1, 1; 1, -1; 1, 4]; % Coefficients of the constraints
b = [80; 30; 160]; % Right-hand side values of the constraints
Aeq = []; %coefficient eq constraint
beq = []; %result of eq constraints
% Lower and upper bounds for variables
LB = [0; 0]; % n_ce >= 0, n_cu >= 0
UB = []; % No upper bounds

intcon = 1:2;

% Solve the mixed-integer linear programming problem

[x, fval, exitflag] = intlinprog(-f, intcon, A, b, Aeq, beq, LB,UB); %maximize: -f

% Extract the optimal values
n_ce_optimal = x(1);
n_cu_optimal = x(2);

% Display optimal values and objective function value
fprintf('Optimal value of number of ceramics: %d\n', n_ce_optimal);
fprintf('Optimal value of number of copper: %d\n', n_cu_optimal);
fprintf('The max profit in euros is : %d\n', -fval); % Multiply by -1 for maximization


ce = 0:80;
cu = 0:80;
[X,Y] = meshgrid(ce,cu);
Z = 200.*X+600.*Y;
I = (X+Y<=80 & X-Y<=30 & X+4*Y<=160 );
I2 = (X-Y<30);
I3 = (X+4*Y<160);

scatter3(X(I),Y(I),Z(I),'.');
xlabel('# Ceramic Items')
ylabel('# Copper Items')
zlabel('Profit (euros)')




