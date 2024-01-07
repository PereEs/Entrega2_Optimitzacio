function F = gradientTNB(c)
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

% TNB function
% TNB = -TNB(To maximize the function)
TNB = @(p1, p2, p3, x1, x2, x3) -(B1(p1, x1) + B2(p2, x2) + B3(p3, x3));

% Constraint
cont1 = @(x1, x2, x3) (x1+x2+x3-c);
cont2 = @(p1, x1) (p1-P1(x1));
cont3 = @(p2, x2) (p2-P2(x2));
cont4 = @(p3, x3) (p3-P3(x3));

g = @(p1, p2, p3, x1, x2, x3, lm1, lm2, lm3, lm4) ...
    TNB(p1, p2, p3, x1, x2, x3) + lm1*cont1(x1, x2, x3) + lm2*cont2(p1, x1) + lm3*cont3(p2, x2) + lm4*cont4(p3, x3);
syms p1 p2 p3 x1 x2 x3 lm1 lm2 lm3 lm4
F = gradient(g(p1, p2, p3, x1, x2, x3, lm1, lm2, lm3, lm4),[p1, p2, p3, x1, x2, x3, lm1, lm2, lm3, lm4]);
end