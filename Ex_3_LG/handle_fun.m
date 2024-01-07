function F = handle_fun(x, c)
g = gradientTNB(c);
f = matlabFunction(g);
F = f(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
end