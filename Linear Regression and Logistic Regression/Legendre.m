function[L] = Legendre(n)
    L = 1:n;
    L(1) = x;
    L(2) = 1/2*(3*x^2-1);
    for R = 3:n
        L(R) = (2*R-1)/R * x * L(R-1) - (R-1)/R * L(R-2);
    end
end