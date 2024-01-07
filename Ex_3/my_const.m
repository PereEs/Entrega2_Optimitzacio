function [c,ceq] = my_const(x)
% Maximum amount of product
P1 = @(x1) 0.4*(x1)^0.9;
P2 = @(x2) 0.5*(x2)^0.8;
P3 = @(x3) 0.6*(x3)^0.7;
%inequality constraints (c)
c(1) = x(1)-P1(x(4));  %c(1): It imposes a restriction that x(1) should be less than or equal to the value of P1(x(4)).
c(2) = x(2)-P2(x(5)); %c(2): It ensures that x(2) is less than or equal to the value of P2(x(5)).
c(3) = x(3)-P3(x(6)); %c(3): Similar to the previous constraints, it sets x(3) less than or equal to P3(x(6)).

ceq = []; %No equality constraints
end




