from sympy import symbols, integrate, sqrt
x=symbols("x")
a=integrate(sqrt(1-x**2),(x,-1,1))*2
print(a)