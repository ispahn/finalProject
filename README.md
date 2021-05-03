# finalProject

To use integralSolver, run the program from Matlab and input the function and x bounds and y bounds if it is a double integral. Press solve and then the answer will output in the Command Window.

Note: Functions (including bounds for double integrals if necessary) must be inputed as function handles. If the bound of the inner variable of a double integral is a function of the outer, include it in the y bounds as a function of x and switch the variables accordingly. (i.e. x must be the outer variable and must have constant bounds)

Function handles are preceded by '@(x)' or '@(x,y)' for double integrals. Variables in functions that are followed by a multiplication or exponential operator must first be followed by '.'. The input is very picky but does work if correct.